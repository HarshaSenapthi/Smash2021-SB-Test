public class updateex {

    public static void harsha()
    {
        list<Lead> l=[select id from Lead where AnnualRevenue>=2000000];
        
        if(!l.isEmpty())
        {
            for(Lead le:l)
            {
                le.status='closed-converted';
                
            }
              update l;
        }
        
    }
}