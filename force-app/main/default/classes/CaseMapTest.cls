public class CaseMapTest {
    
    public static void harsha(integer reqlimit,integer reqoffset)
    {
      
       list<Account> a=[select id,name,industry from account 
                        
                        ORDER By name limit:reqlimit 
                          offset:reqoffset
                       
                       ];
    if(!a.isEmpty())
    {
     
    for(Account aa:a)
    {
        system.debug('ascending order is'+aa);
        
    }
    }
        
    }

}