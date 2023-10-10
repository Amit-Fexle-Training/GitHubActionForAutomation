FSO_SObject_And_RecordType_Mapping__c obj = [Select id, name, Client_Name__c, Object_Name__c from FSO_SObject_And_RecordType_Mapping__c order by name desc limit 1];

Integer count = Integer.valueOf(obj.name.substring(1));

List<FSO_SObject_And_RecordType_Mapping__c> recordTypeFSOConfig = new List<FSO_SObject_And_RecordType_Mapping__c> ();  

recordTypeFSOConfig.add(new FSO_SObject_And_RecordType_Mapping__c(Name = 'F'+(++count), Client_Name__c = 'WELLS', Object_Name__c = 'ServiceResource', Business_Process__c = 'ServiceResource', Record_Type_Developer_Name__c = 'FSO_Wells_Fargo'));
        
recordTypeFSOConfig.add(new FSO_SObject_And_RecordType_Mapping__c(Name = 'F'+(++count), Client_Name__c = 'AMEX', Object_Name__c = 'ServiceResource', Business_Process__c = 'ServiceResource', Record_Type_Developer_Name__c = 'Specialty_AMEX'));

insert recordTypeFSOConfig;
        