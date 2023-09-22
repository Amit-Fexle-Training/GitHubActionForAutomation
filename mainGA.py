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

print(sys.argv[1], sys.argv[2], sys.argv[3])

'''warnings.simplefilter(action='ignore', category=FutureWarning)

config = configparser.ConfigParser()

# Read options from the CSV file into a DataFrame
options_df = pd.read_csv('Org Configs.csv')

# Create a dictionary from the DataFrame
options = options_df.set_index('orgName')['configFileName'].to_dict()

listOfChoices = []
releaseName  = sys.argv[1] #input('Please enter the release Name: ')
#while True:
print("Select an option:")
for index, org_name in enumerate(options.keys(), start=1):
    print(f"{index}. {org_name}")
    listOfChoices.append(org_name)

print("0. Exit")

choice = sys.argv[2] #input("Enter your choice (0-{max_choice}): ".format(max_choice=len(options)))

if choice == '0':
    print("Exiting...")
    break
elif choice.isdigit() and int(choice) in range(1, len(options) + 1):
    selected_option = list(options.keys())[int(choice) - 1]
    print("You have selected:", selected_option)
    confirmation = sys.argv[3] #input("Confirm your choice (Y/N): ")
    if confirmation.lower() == 'y':
        break
else:
    print("Invalid choice. Please try again.")

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
configDF = pd.read_csv("manual-steps-automation/Story Tracker.csv")
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

#secondary_path_folder_name = 'scripts\apex'
def read_files_in_folder(folder_path):
    isExecutingFirstTime = True
    results = None
    # Check if the folder path exists
    if not os.path.exists(folder_path):
        print("Folder path does not exist.")
        return
    
    # Loop over all files in the folder
    for scriptFileName in os.listdir(folder_path):
        file_name_without_extension = os.path.splitext(scriptFileName)[0]
        df = configDF[configDF['Script File Name'] == file_name_without_extension]
        #print(list(df['Execute Script? (Admin Only)'])[0])
        #print(list(df[selected_option.upper()])[0])
        if(df.size>0 and list(df['Execute Script? (Admin Only)'])[0] and list(df[selected_option.upper()])[0]):
            index = configDF.index[configDF['Script File Name'] == file_name_without_extension].tolist()[0]
            runAsUserName = list(df['Run As UserName'])[0]
            
            #Connection with the Source Org for SystemIntegrationUser User
            username = config.get(runAsUserName, 'username')
            password = config.get(runAsUserName, 'password')
            #org_id = config.get(runAsUserName, 'orgId')
            security_token = config.get(runAsUserName, 'security_token')
            sfapi = config.get(runAsUserName, 'sfapi')
            domain = config.get(runAsUserName, 'domain')

            sf = Salesforce(username=username, password=password, security_token= security_token, domain= domain)

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
                        resultDf.at[index, errorColumn] = result['exceptionMessage']
                        resultDf.at[index, successColumn] = result['success']
                        print(f"Script not executed due to {result['exceptionMessage']}")
                    
                    records = pd.DataFrame(result,index=[0])
                    
                    if(isExecutingFirstTime == True):
                        results = records
                        isExecutingFirstTime = False
                    else:
                        existing_df = resultDf
                        updated_sheet = pd.concat([existing_df, records], ignore_index=True)
                        results = updated_sheet
                    
                    print("")
                    
    print('Execution Completed')
    return resultDf

# Call the function to read files in the folder
startTime = time.time()
resultDf = read_files_in_folder(folder_path)
endTime = time.time()
timediff = round((endTime -  startTime)/60,2)
print(f'Total time to execute the script {timediff}')

resultDf = resultDf[columnsToKeep]

#Save in CSV
results_folder_path = releaseName +'_results/'

# Check if the results folder exists
if not os.path.exists(results_folder_path):
    try:
        os.makedirs(results_folder_path)
        print(f"Created results folder at '{results_folder_path}'")
        
    except OSError:
        print(f"Failed to create results folder at '{results_folder_path}'")
        
if os.path.exists(results_folder_path):
    csvFileName = f'{results_folder_path}/'+selected_option+'Result.csv'
    resultDf.to_csv(csvFileName)
    print('Results saved successfully')'''
