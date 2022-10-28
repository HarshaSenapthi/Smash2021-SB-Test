trigger HarshaTrigger on Account (before insert) {
    
    public static void har()
    {
        
        list<Opportunity> opppp= new list<Opportunity>();
        
    list<Account> acclst = Trigger.new;
    
    for(Account acc:acclst)
    {
           if(acc.Rating == 'Hot')
        {
            Opportunity op = new Opportunity();
             
            op.name='harsha';
            
            opppp.add(op);       
        
        }    
        }
        
        insert opppp;
        
    }
    
  
}