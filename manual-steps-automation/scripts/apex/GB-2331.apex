//UserName: SystemIntegrationUser
//Environment: Qa1e,Prod, Twgqa2d
List<Skill> listOfSkill = [SELECT Id FROM Skill WHERE MasterLabel = 'AMEX'];
List<ServiceResourceSkill> serviceResourceSkillToBeInsert = new List<ServiceResourceSkill>();
List<ServiceResource> serviceResourceListToActivate = new List<ServiceResource>();
List<ServiceResource> serviceResourceListToDeActivate = new List<ServiceResource>();
for(ServiceResource sR: [SELECT Id, IsActive FROM ServiceResource WHERE Recordtype.DeveloperName = 'Specialty_AMEX' AND RelatedRecord.IsActive = True]){
	ServiceResourceSkill srSkill = new ServiceResourceSkill();
	srSkill.ServiceResourceId = sR.Id;
	srSkill.SkillId = listOfSkill[0].Id;
	srSkill.EffectiveStartDate = System.now();
	serviceResourceSkillToBeInsert.add(srSkill);
	if(!sr.IsActive){
		serviceResourceListToActivate.add(new ServiceResource(Id = sR.Id, IsActive = true));
		serviceResourceListToDeActivate.add(new ServiceResource(Id = sR.Id, IsActive = false));
	}
}

if(!serviceResourceListToActivate.isEmpty()){
    update serviceResourceListToActivate;
}

if(!serviceResourceSkillToBeInsert.isEmpty()){
    List<Database.SaveResult> sr = Database.Insert(serviceResourceSkillToBeInsert, false);
}

if(!serviceResourceListToDeActivate.isEmpty()){
    update serviceResourceListToDeActivate;
}