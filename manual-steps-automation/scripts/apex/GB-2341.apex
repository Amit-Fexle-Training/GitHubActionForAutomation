Boolean isTurnOnLightning = true;

List<Profile> applicableProfiles = [SELECT Id FROM Profile WHERE Name in ('CSR Profile')];
List<Case_Setting__c> caseSettingToUpdate = new List<Case_Setting__c>();
for(Profile eachProfile : applicableProfiles){
    Case_Setting__c caseSetting = Case_Setting__c.getInstance(eachProfile.Id);
    caseSetting.Use_Lightning_UI__c = isTurnOnLightning;
    caseSetting.Use_Case_Overview_Lightning__c = !isTurnOnLightning;
    caseSetting.Use_Payment_Summary_Lightning__c = !isTurnOnLightning;
    caseSetting.Use_Case_Creation_Lightning__c = !isTurnOnLightning;
    caseSetting.Use_Case_Comments_Lightning__c = !isTurnOnLightning;
    caseSetting.Use_Case_Creation_Lightning_For_PPM__c = !isTurnOnLightning;
    caseSetting.Use_Related_Cases_List_Lightning__c = !isTurnOnLightning;
    caseSetting.Use_Non_PPM_Data_Lightning__c = !isTurnOnLightning;
    caseSetting.Use_Claim_Summary_Lightning__c = !isTurnOnLightning;
    caseSetting.Use_Case_Actions_Lightning__c = !isTurnOnLightning;
    caseSetting.Use_Account_Guideline_Lightning__c = !isTurnOnLightning;
    caseSetting.Use_Related_Lists_Lightning__c = !isTurnOnLightning;
    caseSetting.Use_Legacy_Cases_List_Lightning__c = !isTurnOnLightning;
    caseSetting.Use_PPM_Data_Lightning__c = !isTurnOnLightning;
    caseSettingToUpdate.add(caseSetting);
}
update caseSettingToUpdate;