//UserName: BillingStatementUser
//Environment: Prod, Twgqa2d, Qa1e
List<Picklist_Entry__c> data = [SELECT Language_Code__c, Key__c, Description__c 
            FROM Picklist_Entry__c where RecordType.Name = 'Transform Text'  and key__c = 'Other'];

for(Picklist_Entry__c pe: data){

	if(pe.Description__c == 'Other'){
		pe.Language_Code__c = 'English';
	}else if(pe.Description__c == 'Otro'){
		pe.Language_Code__c = 'Spanish';
	}
}

update data;