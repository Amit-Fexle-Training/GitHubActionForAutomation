GLOW_r1_Constants__c glowConstant = [SELECT id FROM GLOW_r1_Constants__c WHERE Name = 'GLOW r1 Constants (Organization)'];
glowConstant.Allow_ISD_Integration__c = true;
update glowConstant;