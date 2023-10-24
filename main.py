import os
from simple_salesforce import Salesforce, format_soql
from pprint import pprint
from datetime import datetime
import configparser
import warnings
import time
import pandas as pd
import copy
import json
import sys
warnings.simplefilter(action='ignore', category=FutureWarning)

def initial_setup():
    releaseDetails = configparser.ConfigParser()
    releaseDetails.read('ReleaseDetails.ini')
    releaseName = releaseDetails.get('ReleaseDetails', 'Release_Name')
    orgNumber = releaseDetails.get('ReleaseDetails', 'Org_Number')
    
    config = configparser.ConfigParser()

    # Read options from the CSV file into a DataFrame
    options_df = pd.read_csv('Org Configs.csv')

    # Create a dictionary from the DataFrame
    options = options_df.set_index('orgName')['configFileName'].to_dict()

    listOfChoices = []
    releaseName  = releaseName #input('Please enter the release Name: ') #sys.argv[1]
    
    while True:
        print("Select an option:")
        for index, org_name in enumerate(options.keys(), start=1):
            print(f"{index}. {org_name}")
            listOfChoices.append(org_name)

        print("0. Exit")

        choice = orgNumber 

        if choice == '0':
            print("Exiting...")
            break
        elif choice.isdigit() and int(choice) in range(1, len(options) + 1):
            selected_option = list(options.keys())[int(choice) - 1]
            print("You have selected:", selected_option)
            confirmation = 'Y' #input("Confirm your choice (Y/N): ") #sys.argv[3]
            if confirmation.lower() == 'y':
                break
        else:
            print("Invalid choice. Please try again.")
            break    
            
    fileName = options[selected_option]+'.ini'

    credsPath = 'creds/'
    if not os.path.exists(credsPath):
        print("Folder path does not exist.")

    fileName = os.path.join(credsPath, fileName)  # Replace 'config_file_name.ini' with the actual name of your credentials file

    if os.path.isfile(fileName):
        config.read(fileName)
    else:
        print(f"The file '{fileName}' does not exist in the '{credsPath}' directory.")
        
    folder_path = 'manual-steps-automation/scripts/apex'
    configDF = get_story_tracker(folder_path, options_df) #pd.read_csv("manual-steps-automation/Story Tracker.csv")
    configDF = configDF.sort_values(by='Script File Name', ascending=True)
    columnsToKeep = ['Execute Script? (Admin Only)', 'Script File Name', 'Run As UserName']
    columnsToKeep.append(selected_option.upper())
    resultDf = configDF.copy()
    successColumn = 'successs'
    errorColumn = 'error'
    columnsToKeep.append(successColumn)
    columnsToKeep.append(errorColumn)
    resultDf[successColumn] = None
    resultDf[errorColumn] = None
    configDF[errorColumn] = False 
    
    return folder_path, configDF, selected_option, resultDf, errorColumn, successColumn, columnsToKeep, releaseName, config

def get_story_tracker(folder_path, options_df):
    config_list = []
    for scriptFileName in os.listdir(folder_path):

        # Initialize variables to store the extracted values
        username = None
        environments = []

        file_path = os.path.join(folder_path, scriptFileName)

        configDict = {}

        orgNameList = list(options_df['orgName'])
        for orgName in orgNameList:
            configDict[orgName.upper()] = False

        # Open the file and read its contents
        with open(file_path, 'r') as file:
            for line in file:
                if line.startswith('//UserName:'):
                    username = line.split(': ')[1].strip()
                elif line.startswith('//Environment:'):
                    environments = [env.strip() for env in line.split(': ')[1].split(',')]

                configDict['Execute Script? (Admin Only)'] = True
                configDict['Script File Name'] = scriptFileName.split('.')[0]
                configDict['Run As UserName'] = username
                for env in environments:
                    if env.upper() in configDict:
                        configDict[env.upper()] = True


        config_list.append(configDict)
    return pd.DataFrame(config_list)

def read_files_in_folder(apex_class_with_changes, folder_path, configDF, selected_option, resultDf, errorColumn, successColumn, columnsToKeep, config):
    # Check if the folder path exists
    if not os.path.exists(folder_path):
        print("Folder path does not exist.")
        return
    
    if apex_class_with_changes:
        configDF['error'] = True 
        for apex_class in apex_class_with_changes:
            configDF.loc[configDF['Script File Name'] == apex_class.split('.')[0], 'error'] = False 
    
    # List all files in the directory and sort them by name
    file_names = sorted(os.listdir(folder_path))
    # Loop over all files in the folder
    for scriptFileName in file_names:
        file_name_without_extension = os.path.splitext(scriptFileName)[0]
        df = configDF[configDF['Script File Name'] == file_name_without_extension]
        if(df.size>0 and list(df['Execute Script? (Admin Only)'])[0] and list(df[selected_option.upper()])[0]):
            index = configDF.index[configDF['Script File Name'] == file_name_without_extension].tolist()[0]
            runAsUserName = list(df['Run As UserName'])[0]
            error = list(df['error'])[0]
            
            if not error: 
                #Connection with the Source Org for SystemIntegrationUser User
                username = config.get(runAsUserName, 'username')
                password = config.get(runAsUserName, 'password')
                org_id = config.get(runAsUserName, 'orgId')
                org_alias = config.get(runAsUserName, 'org_alias')
                sfapi = config.get(runAsUserName, 'sfapi')
                domain = config.get(runAsUserName, 'domain')

                sf = Salesforce(username=username, password=password, organizationId= org_id, domain= domain)

                file_path = os.path.join(folder_path, scriptFileName)

                # Check if the current item is a file
                if os.path.isfile(file_path):
                    # Read the file contents
                    with open(file_path, 'r') as file:
                        scriptCode = file.read()
                        print(f"executing File: {scriptFileName}")
                        result = sf.restful('tooling/executeAnonymous', 
                                                 { 'anonymousBody': f'{scriptCode}' })
                        result['Story Number'] = file_name_without_extension
                        if result['success']:
                            print(f"Script executed successfully for {scriptFileName}")
                            resultDf.at[index, successColumn] = result['success']
                            resultDf.at[index, errorColumn] = result['exceptionMessage']
                        else:
                            if result['exceptionMessage'] is not None:
                                resultDf.at[index, errorColumn] = result['exceptionMessage']
                            else:
                                resultDf.at[index, errorColumn] = 'Script failed to execute'
                            resultDf.at[index, successColumn] = result['success']
                            print(f"Script not executed due to {result['exceptionMessage']}")
                            configDF.loc[configDF['Script File Name'].str.startswith(file_name_without_extension.split('_')[0]), 'error'] = True 
                            #failed_script_name = scriptFileName 
                            

                        records = pd.DataFrame(result,index=[0])

            else: 
                print(f'executing File: {scriptFileName}')
                resultDf.at[index, errorColumn] = f'Script not Executed'
                resultDf.at[index, successColumn] = False
                print(f'Script not Executed')
                
    print('Execution Completed')
    return resultDf


# In[ ]:

changes_from_PR = sys.argv[1].split(',')
for r in changes_from_PR:
    print('change path : ',r)
print('Sourch Branch Name : ',sys.argv[1])
# for arg in sys.argv[1:]:
#     changes_from_PR.append(arg)

#result_list = [file.split('/')[-1] for file in chnages_from_PR if file.startswith('manual-steps-automation/scripts/apex/') and file.endswith('.apex')]
apex_class_with_changes = [file.split('/')[-1] for file in changes_from_PR if file.endswith('.apex')]

if apex_class_with_changes:
    initialSetup = initial_setup()
    
#     #*** For Reference Only ***
#     folder_path = initialSetup[0]
#     configDF = initialSetup[1]
#     selected_option = initialSetup[2]
#     resultDf = initialSetup[3]
#     errorColumn = initialSetup[4]
#     successColumn = initialSetup[5]
#     columnsToKeep = initialSetup[6]
#     releaseName = initialSetup[7]
#     config = initialSetup[8]
    
    resultDf = read_files_in_folder(apex_class_with_changes, initialSetup[0], initialSetup[1], initialSetup[2], initialSetup[3], initialSetup[4], initialSetup[5], initialSetup[6], initialSetup[8]) 

    resultDf = resultDf[initialSetup[6]]

    # Split the dataframe into two based on the 'successs' column
    df_success = resultDf[resultDf['successs'] == True]
    df_failure = resultDf[resultDf['successs'] == False]

    #Save in CSV
    results_path = 'Results/'
    if not os.path.exists(results_path):
        try:
            os.makedirs(results_path)
            print(f"Created results folder at '{results_path}'")

        except OSError:
            print(f"Failed to create results folder at '{results_path}'")

    current_datetime = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    results_folder_path = results_path + initialSetup[7] +'_results ' + current_datetime +'/'

    # Check if the results folder exists
    if not os.path.exists(results_folder_path):
        try:
            os.makedirs(results_folder_path)
            print(f"Created results folder at '{results_folder_path}'")

        except OSError:
            print(f"Failed to create results folder at '{results_folder_path}'")

    if os.path.exists(results_folder_path):
        csvFileName = f'{results_folder_path}/'+initialSetup[2]+'Success Result.csv'
        df_success.to_csv(csvFileName, index=False)

        csvFileName = f'{results_folder_path}/'+initialSetup[2]+'Failure Result.csv'
        df_failure.to_csv(csvFileName, index=False)
        print('Results saved successfully')
else:
    print('No Chnages Found In Apex Script')

endTime = time.time()
timediff = round((endTime -  startTime)/60,2)
print(f'Total time to execute the script {timediff}')
