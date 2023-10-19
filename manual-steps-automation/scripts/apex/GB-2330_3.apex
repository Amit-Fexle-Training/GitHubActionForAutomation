//UserName: SystemIntegrationUser
//Environment: Qa1e,Prod, Twgqa2d
List<Letter_Disclosure__c> discList = [SELECT Id, State__c, State_Complaint_Language__c from Letter_Disclosure__c  where State__c in ('NE','WA') AND RecordType.DeveloperName = 'Specialty_AMEX'];
for(Letter_Disclosure__c thisLetter : discList)
{
 if(thisLetter.State__c== 'WA')
    thisLetter.State_Complaint_Language__c = 'If you have questions or concerns about the actions of your insurance company or agent, or would like information on your rights to file an appeal, contact the Washington state Office of the Insurance Commissioner\'s consumer protection hotline at 1-800-562-6900 or visit www.insurance.wa.gov. The insurance commissioner protects and educates insurance consumers, advances the public interest, and provides fair and efficient regulation of the insurance industry.';
 else if(thisLetter.State__c== 'NE')
    thisLetter.State_Complaint_Language__c = 'You have the right to have the matter reviewed by the NEBRASKA DEPARTMENT OF INSURANCE, P.O. Box 82089 Lincoln, Nebraska 68501-2089. Their phone number is 877-564-7323.';
}
update discList;