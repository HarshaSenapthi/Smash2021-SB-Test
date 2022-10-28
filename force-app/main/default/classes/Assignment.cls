public class Assignment {
    
    public static void method()
    {
        list<contact>lcon=[select id,lastname,phone from contact where accountid = null];
        
        Account acc=[select id,name,rating from account where industry = 'EdgeCommunications'];
        
        if(!lcon.isEmpty())
        {
            for(contact c:lcon)
            {
                c.AccountId=acc.Id;
            }
            update lcon;
        }
    }

}