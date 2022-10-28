Global class AssignOfBatchApex Implements Database.Batchable<SObject>
{
   Global Database.QueryLocator start(Database.BatchableContext bcontext)
   {
       string acc='Select id,name,billingcity,industry,rating from account ';
        return Database.getQueryLocator(acc);
   }
    Global void execute(Database.BatchableContext bcontext,list<SObject> harsha)
    {
        if(!harsha.isEmpty())
        {
            list<Account> acclst=new list<Account>();
            for(SObject sobj:harsha)
            {
                Account accrec=(Account) sobj;
                 
                acclst.add(accrec);
            }
            delete acclst;
        }
        
        
    }
    Global  void finish(Database.BatchableContext bcontext)
    {
       system.debug('batch process id'+bcontext.getJobId());
        
        AsyncApexJob ajob=[select id,status,TotalJobItems,JobItemsProcessed,NumberOfErrors,Createdby.email from AsyncApexJob where id=:bcontext.getJobId()];
    }
}