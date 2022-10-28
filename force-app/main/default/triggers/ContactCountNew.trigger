//
// ContactCount trigger to handle the roll up summary on Account
//
trigger ContactCountNew on Contact (after insert, after delete, after undelete, after update) {
    set<Id> accIdSet = new set<Id>();
    
    if(trigger.isinsert || trigger.isUpdate || trigger.Isundelete){
        for(Contact con: Trigger.new){
            if(Trigger.isInsert || Trigger.isUndelete || (con.AccountId != Trigger.oldMap.get(con.Id).AccountId))
                accIdSet.add(con.AccountId);
        }
    }
    
    if(trigger.isUpdate || trigger.isDelete) {
        for(Contact con: Trigger.old){
            if(Trigger.isDelete || (con.AccountId != Trigger.newMap.get(con.Id).AccountId))
                accIdSet.add(con.AccountId);
        }
    }    
    
    if(!accIdSet.isEmpty()) {
        List<Account> accList = [select Id, Count__c, (Select Id from Contacts) from Account Where ID IN: accIdSet];
        
        for(Account acc : accList){
            System.debug('Contacts--->'+acc.Contacts.size());
            acc.Count__c = acc.Contacts.size();
        }
        update accList;
    }
}