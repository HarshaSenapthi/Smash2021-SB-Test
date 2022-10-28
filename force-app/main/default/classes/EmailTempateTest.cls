public class EmailTempateTest {

    public static void Data()
    {
        
        list<emailtemplate> email=[select id,name,subject,description,body from emailtemplate];
        
       if(!email.isEmpty())
       {
           for(emailtemplate empt:email)
           {
               System.debug('email data is'+empt);
           }
       }
    }
}