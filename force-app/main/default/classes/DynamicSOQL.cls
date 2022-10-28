public class DynamicSOQL {
    
   public static void harsha()
   {
     /*  string accrec='select id,name,billingcity from account where billingcity=:cityname';
        list<Account>acclist=Database.query(accrec);
       
       if(!acclist.isEmpty())
       {
           for(Account accc:acclist)
           {
               system.debug(''+accc);
           }
       }
   */
       // static SOQL querry
       //list<Account>lacc=[select count() from account];
    //Dynamic SOQL querry
   
       string cquery='select count() from account';
       integer lacc=Database.countQuery(cquery);
       system.debug('dynamic number'+lacc);
       
       integer num=[select count() from account];
       system.debug('static number'+num);
   }
       
}