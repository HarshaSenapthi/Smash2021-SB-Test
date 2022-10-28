public class DMLUpdate {

    public static void method()
    {
        list<Account>listacc=[select id,name,annualrevenue,rating from account  where rating = 'hot'];
        
        if(!listacc.isEmpty())
        {
            for(Account a:listacc)
            {
                a.annualrevenue=2000000;
            }
            update listacc;
        }
    }
}