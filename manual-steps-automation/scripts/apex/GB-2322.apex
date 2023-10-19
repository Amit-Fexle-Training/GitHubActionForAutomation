//UserName: BillingStatementUser
//Environment: Prod, Twgqa2d, Qa1e
List<AutoHub_Module__c> modules = new List<AutoHub_Module__c>();
modules.add(new AutoHub_Module__c(Name = 'Contracts', Source__c='Dealer Portal', Is_Dealer_Portal_Module__c = true, Module_API_Name__c='Contract__c', Module_Description__c = 'Search, View, manage your contracts'));
modules.add(new AutoHub_Module__c(Name = 'Quotes', Source__c='Dealer Portal', Is_Dealer_Portal_Module__c = true,
Module_API_Name__c='Quote__c', Module_Description__c = 'Search, create quotes, get rates and manage your quotes'));
modules.add(new AutoHub_Module__c(Name = 'Cases', Source__c='Dealer Portal', Is_Dealer_Portal_Module__c = true,
Module_API_Name__c='Case', Module_Description__c = 'Search, View Summary and manage your cases'));
modules.add(new AutoHub_Module__c(Name = 'Remit Quotes', Source__c='Dealer Portal', Is_Dealer_Portal_Module__c = true,
Module_API_Name__c='', Module_Description__c = 'Remit quotes and void contracts'));
modules.add(new AutoHub_Module__c(Name = 'Contacts', Source__c='Dealer Portal', Is_Dealer_Portal_Module__c = false,
Module_API_Name__c='Contact'));
modules.add(new AutoHub_Module__c(Name = 'Lienholders', Source__c='Dealer Portal', Is_Dealer_Portal_Module__c = false,
Module_API_Name__c='Dealer_Lienholder__c'));
insert modules;

List<Profile__c> profiles = new List<Profile__c>();
profiles.add(new Profile__c(Name = 'Back Office Admin CC'));
profiles.add(new Profile__c(Name = 'Dealer Admin CC'));
profiles.add(new Profile__c(Name = 'Dealer Super User CC'));
profiles.add(new Profile__c(Name = 'F&I Sales CC'));
profiles.add(new Profile__c(Name = 'Sales & Service CC'));
profiles.add(new Profile__c(Name = 'Services CC'));
profiles.add(new Profile__c(Name = 'Warranty Admin CC'));
profiles.add(new Profile__c(Name = 'Autohub'));
insert profiles;