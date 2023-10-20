//UserName: BillingStatementUser
//Environment: Prod, Twgqa2d, Qa1e
Picklist_Entry__c pickList = [SELECT Id, Picklist_Value__c,Picklist__c,Record_Type_Developer_Name__c, Object_Name__c from Picklist_Entry__c where Object_Name__c = 'Case' and Picklist__c = 'Country_Picklist__c' and Record_Type_Developer_Name__c = 'Specialty_AMEX' order by CreatedDate desc];

pickList.Picklist_Value__c = pickList.Picklist_Value__c.replace('Cote d‚ÄôIvoire','Cote d’Ivoire');
pickList.Picklist_Value__c = pickList.Picklist_Value__c.replace('Macedonia (The former Yugoslav Republic of)','Macedonia');
pickList.Picklist_Value__c = pickList.Picklist_Value__c.replace('Cura√ßao','Curaçao');
pickList.Picklist_Value__c = pickList.Picklist_Value__c.replace('Saint Barth√©lemy','Saint Barthelemy');
pickList.Picklist_Value__c = pickList.Picklist_Value__c.replace('Lao People‚Äôs Democratic Republic','Lao People’s Democratic Republic');

update pickList;