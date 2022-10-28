public class AccOppSum {
    public static void oppsum(string accname)
    {
        
   Account acc=[select id,name,oppannualsum__c from account where name=:accname];

      if(acc!= null)
      {
          system.debug('name and opptunity sum is');
          system.debug(''+acc);
          system.debug('Hello');
      }
        
    }

}