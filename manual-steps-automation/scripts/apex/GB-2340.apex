//UserName: SystemIntegrationUser
//Environment: Qa1e,Prod, Twgqa2d
Boolean isTurnOnLightning = true;

List<Profile> applicableProfiles = [SELECT Id FROM Profile WHERE Name in ('AN - Corporate Admin Profile', 'AN - CC Admin Profile', 'AN - CC Regional Admin Profile', 'AN - CC Support Profile', 'Back Office Admin CC', 'Dealer Admin CC', 'Dealer Super User CC', 'Portfolio Adjuster', 'Repair Facility User CC', 'Sales & Service & Admin CC', 'Sales & Service CC', 'Services CC', 'Warranty Admin CC')];
List<Case_Setting__c> caseSettingToUpdate = new List<Case_Setting__c>();
for(Profile eachProfile : applicableProfiles){
    Case_Setting__c caseSetting = Case_Setting__c.getInstance(eachProfile.Id);
    caseSetting.Use_Case_Actions_Lightning__c = isTurnOnLightning;
    if(caseSetting.Number_Of_Days__c == null){
        caseSetting.Number_Of_Days__c = 0;
    }
    caseSettingToUpdate.add(caseSetting);
}
update caseSettingToUpdate;