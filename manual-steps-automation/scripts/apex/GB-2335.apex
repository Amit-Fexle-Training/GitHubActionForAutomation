//UserName: SystemIntegrationUser
//Environment: Qa1e,Prod, Twgqa2d
GLOW_r1_Constants__c gr1 = [SELECT Id FROM GLOW_r1_Constants__c LIMIT 1];

GLOW_r1_Constants__c gr1Setting = new GLOW_r1_Constants__c();
gr1Setting.Q2S_Lightning__c = true;
gr1Setting.Id = gr1.Id;
update gr1Setting;
