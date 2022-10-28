trigger PreDel on Account (After delete) {
    
    if(Trigger.isBefore&&Trigger.isDelete)
    {
        list<Account> accrec= Trigger.old;
         for(Account acc : accrec)
         {
             if(acc.Active__c=='Yes')
             {
               //  acc.AddError("You cannot authiorized to remove account records ");
               System.debug('Ypu cannot delete a record');
             }
         }
        
    }

}