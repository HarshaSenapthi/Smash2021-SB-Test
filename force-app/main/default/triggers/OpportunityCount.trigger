trigger OpportunityCount on Opportunity (after insert, after delete, after undelete, after update) {
    
     set<Id> accIdSet = new set<Id>();
    
    if(trigger.isinsert || trigger.isUpdate || trigger.Isundelete){
        for(Opportunity opp: Trigger.new){
            if(Trigger.isInsert || Trigger.isUndelete || (opp.AccountId != Trigger.oldMap.get(opp.Id).AccountId))
                accIdSet.add(opp.AccountId);
        }
    }
    
    if(trigger.isUpdate || trigger.isDelete) {
        for(Opportunity opp: Trigger.old){
            if(Trigger.isDelete || (opp.AccountId != Trigger.newMap.get(opp.Id).AccountId))
                accIdSet.add(opp.AccountId);
        }
    }

             if(accIdSet.size() > 0) {
            List<Account> accountList = [SELECT Id, (SELECT Id FROM Opportunities) FROM Account WHERE Id in: accIdSet];
            if(accountList.size() > 0){

                for(Account accRec : accountList)

                {

                    accRec.OppCount__c = accRec.Opportunities.size();
                     
                }  

                UPDATE accountList;

            }

        }    

}