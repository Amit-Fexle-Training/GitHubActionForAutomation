//UserName: SystemIntegrationUser
//Environment: Qa1e,Prod, Twgqa2d
List<Bin_Range__c> binList = new List<Bin_Range__c>();
RecordType rc = [SELECT ID FROM RecordType WHERE SobjectType = 'Bin_Range__c' AND DeveloperName = 'FSO'];
Bin_Range__c bin1 = new Bin_Range__c();
bin1.Account_Code__c = 'JP Morgan';
bin1.Account_Type_Id__c = 'EXC';
bin1.Begin_Bin_Range__c = Double.valueOf('450183000000000');
bin1.Card_Type_Description__c = 'Executive Card';
bin1.Chain_Code__c = 'JP Morgan Canada';
bin1.Client__c = 'JP_Morgan';
bin1.Effective_Date__c = Date.valueOf('2021-10-01');
bin1.End_Bin_Range__c = Double.valueOf('450183999999999');
bin1.Expiry_Date__c = Date.valueOf('2099-10-01');
bin1.Policy__c = 'JP Morgan';
bin1.Product_List_Id__c = 'GEN001JPMCA, GEN002JPMCA, GEN005JPMCA, GEN006JPMCA, GEN007JPMCA, GEN008JPMCA, GEN009JPMCA, GEN010JPMCA';
bin1.CurrencyIsoCode = 'CAD';
bin1.RecordTypeId = rc.Id;
binList.add(bin1);

Bin_Range__c bin2 = new Bin_Range__c();
bin2.Account_Code__c = 'JP Morgan';
bin2.Account_Type_Id__c = 'CRP';
bin2.Begin_Bin_Range__c = Double.valueOf('450183000000000');
bin2.Card_Type_Description__c = 'Corporate Card';
bin2.Chain_Code__c = 'JP Morgan Canada';
bin2.Client__c = 'JP_Morgan';
bin2.Effective_Date__c = Date.valueOf('2021-10-01');
bin2.End_Bin_Range__c = Double.valueOf('450183999999999');
bin2.Expiry_Date__c = Date.valueOf('2099-10-01');
bin2.Policy__c = 'JP Morgan';
bin2.Product_List_Id__c = 'GEN001JPMCA, GEN002JPMCA, GEN005JPMCA, GEN006JPMCA, GEN007JPMCA, GEN008JPMCA, GEN009JPMCA, GEN010JPMCA';
bin2.CurrencyIsoCode = 'CAD';
bin2.RecordTypeId = rc.Id;
binList.add(bin2);

Bin_Range__c bin3 = new Bin_Range__c();
bin3.Account_Code__c = 'JP Morgan';
bin3.Account_Type_Id__c = 'PUR';
bin3.Begin_Bin_Range__c = Double.valueOf('450183000000000');
bin3.Card_Type_Description__c = 'Purchasing Card';
bin3.Chain_Code__c = 'JP Morgan Canada';
bin3.Client__c = 'JP_Morgan';
bin3.Effective_Date__c = Date.valueOf('2021-10-01');
bin3.End_Bin_Range__c = Double.valueOf('450183999999999');
bin3.Expiry_Date__c = Date.valueOf('2099-10-01');
bin3.Policy__c = 'JP Morgan';
bin3.Product_List_Id__c = 'GEN001JPMCA, GEN002JPMCA, GEN005JPMCA, GEN006JPMCA, GEN007JPMCA, GEN008JPMCA, GEN009JPMCA, GEN010JPMCA';
bin3.CurrencyIsoCode = 'CAD';
bin3.RecordTypeId = rc.Id;
binList.add(bin3);

Bin_Range__c bin4 = new Bin_Range__c();
bin4.Account_Code__c = 'JP Morgan';
bin4.Account_Type_Id__c = 'ONE';
bin4.Begin_Bin_Range__c = Double.valueOf('450183000000000');
bin4.Card_Type_Description__c = 'One Card';
bin4.Chain_Code__c = 'JP Morgan Canada';
bin4.Client__c = 'JP_Morgan';
bin4.Effective_Date__c = Date.valueOf('2021-10-01');
bin4.End_Bin_Range__c = Double.valueOf('450183999999999');
bin4.Expiry_Date__c = Date.valueOf('2099-10-01');
bin4.Policy__c = 'JP Morgan';
bin4.Product_List_Id__c = 'GEN001JPMCA, GEN002JPMCA, GEN005JPMCA, GEN006JPMCA, GEN007JPMCA, GEN008JPMCA, GEN009JPMCA, GEN010JPMCA';
bin4.CurrencyIsoCode = 'CAD';
bin4.RecordTypeId = rc.Id;
binList.add(bin4);

insert binList;



