List<Letter_Template__c> listOfLetterTemplate = new List<Letter_Template__c>();
listOfLetterTemplate.add(new Letter_Template__c(Document_Name__c = 'Closed_Without_Payment_Letter', Template_Id__c = 'AMEX058-Closed Without Payment Letter', 
                                                Email_Template_Name__c = 'AMEXClaimClosedWithoutPayment', Template_Description__c = 'Claim Closed Without Payment AMEX', 
                                                Client__c = 'AMEX', Allow_Preview__c = false, Is_Active__c = true, Email_Reminder_Days__c = 2, Letter_Reminder_Days__c = 5, Mail_Communication_Mandatory__c = true));
insert listOfLetterTemplate;

List<Letter_Template__c> listOfLetterTemplateNew = [SELECT Id FROM Letter_Template__c WHERE Template_Id__c = 'AMEX058-Closed Without Payment Letter'];

List<Letter_Language__c> listOfLetterLanguage = new List<Letter_Language__c>();
listOfLetterLanguage.add(new Letter_Language__c(Language_Code__c = 'English', Number_of_Pages__c = '2', 
                                                SCM_Template_Name__c = 'Claim-Closed Without Payment.docx', Letter_Template__c = listOfLetterTemplateNew[0].Id));
insert listOfLetterLanguage;