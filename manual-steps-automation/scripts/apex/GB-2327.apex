//UserName: BillingStatementUser
//Environment: Prod, Twgqa2d, Qa1e
List<User_Authorization_Limits__c> listUAL = [SELECT id, Level__c, Authorization_Limit__c,Client__c,  Limit_Type__c, RecordType.Name from User_Authorization_Limits__c 
											  WHERE Client__c = 'WELLS' AND RecordType.Name = 'Specialty' 
											  AND Level__c IN ('Wells Fargo Claims Manager','Wells Fargo Claims Team Leader') 
											  AND Limit_Type__c = 'Claim Feature Denial'];

for(User_Authorization_Limits__c recordAUL : listUAL){
    recordAUL.Authorization_Limit__c = 100000;
}
update listUAL;