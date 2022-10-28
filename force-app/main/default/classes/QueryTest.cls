public class QueryTest {
    
    public void RecordsByCity(String startingchar)
    {
          startingchar='%'+startingchar;
          list<Account>lstacc=[select id,name,billingcity,phone from account where name like :startingchar];

        if(!lstacc.isEmpty())
        {
           for(Account acc:lstacc)
            {
                system.debug('accounts are'+acc);
            }
        
        }  
       
    }
}