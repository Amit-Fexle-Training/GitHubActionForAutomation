#import os
#from simple_salesforce import Salesforce, format_soql
#from pprint import pprint
#from datetime import datetime
#import configparser
#import warnings
#import time
#import pandas as pd
#import json
import sys



chnages_from_PR = sys.argv[0]
print(chnages_from_PR)
print(type(chnages_from_PR))

#result_list = [file.split('/')[-1] for file in chnages_from_PR if file.startswith('manual-steps-automation/scripts/apex/') and file.endswith('.apex')]
result_list = [file.split('/')[-1] for file in chnages_from_PR if file.endswith('.apex')]

print(result_list)

for result in result_list:
    print(result.split('.')[0])
