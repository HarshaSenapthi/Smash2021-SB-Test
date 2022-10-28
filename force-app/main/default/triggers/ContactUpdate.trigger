trigger ContactUpdate on Contact (before insert,before update) {
    
    Map<String, id> productMap = new Map<String, id>();
	for(Account a : [SELECT Id, Name FROM Account])
	{
		productMap.put(a.Name, a.id);
	}

	
    for (Contact c : Trigger.new) 
    { 
    	//retrieve product id from product map
        c.AccountId = productMap.get(c.Account_Name_NA__c);
    }

}