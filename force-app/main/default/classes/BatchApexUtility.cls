Global class BatchApexUtility implements Database.Batchable<SObject> 
{
    Global Database.QueryLocator start(Database.BatchableContext bcontext)
    {
        string accquery='select id,name,industry,rating from account';
         return database.getQueryLocator(accquery);
        
    }
    
    Global void execute(Database.BatchableContext bcontext,List<SObject> recordsToprocess)
    {
       if(!recordsToprocess.isEmpty())
       {
           
           list<Account> accrec=new list<Account>();
           for(SObject sorec:recordsToprocess)
           {
               Account acc=(Account) sorec;
               acc.Phone='8520920965';
               accrec.add(acc);
           }
           
           update accrec;
       }
        
        
    }
    Global void finish(Database.BatchableContext bcontext)
    {
        System.debug('Batch job id is'+bcontext.getJobId());
        
        AsyncApexJob jobdetails = [select id,status,TotalJobItems,JobItemsProcessed,NumberOfErrors,Createdby.email from AsyncApexJob where id=:bcontext.getJobId()];
    }

}