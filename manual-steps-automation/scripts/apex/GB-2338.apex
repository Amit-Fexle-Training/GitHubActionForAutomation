//UserName: SystemIntegrationUser
//Environment: Qa1e,Prod, Twgqa2d
System.schedule('AutoHubEventNotificationsBatch Schedule',  '0 30 16 * * ? *', new AutoHubEventNotificationsBatch());