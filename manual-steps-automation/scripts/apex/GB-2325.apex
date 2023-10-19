//UserName: BillingStatementUser
//Environment: Prod, Twgqa2d, Qa1e
Id insuranceRecordTypeId = RecordTypeDAO.getRecordTypeId(
            (UtilityDAO.getObjectRecordTypeNameByClient('WELLS')).get('Insurance_Detail__c').get('Insurancedetail'), 'Insurance_Detail__c');


List<Insurance_Detail__c> insuranceList = [select Id, CreatedBy.Name, RecordType.DeveloperName, Benefit__r.RecordType.DeveloperName, Benefit__r.Case__r.Product.Name from Insurance_Detail__c where Benefit__r.RecordType.DeveloperName = 'FSO_Wells_Fargo' and RecordType.DeveloperName != 'FSO_Wells_Fargo'];
for(Insurance_Detail__c insuranceRecord : insuranceList){
    insuranceRecord.RecordTypeId = insuranceRecordTypeId;
}

update insuranceList;