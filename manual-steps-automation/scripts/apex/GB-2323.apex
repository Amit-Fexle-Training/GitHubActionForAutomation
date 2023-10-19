//UserName: BillingStatementUser
//Environment: Prod, Twgqa2d, Qa1e
List<AutoHub_Module__c> quotes = [select id,Module_Description__c from AutoHub_Module__c where Name = 'Quotes' order by createddate desc limit 1];
if(quotes.size() > 0){
    quotes[0].Module_Description__c = 'Search, create quotes, get rates and manage your quotes';
	update quotes;
}