public class DelTest {
    
    public static void mytest()
    {
              list<contact>lcon=[select id,lastname,isdeleted,phone from contact where createddate=LAST_WEEK];
        
        if(!lcon.isEmpty())
        {
            delete lcon;
        }
    }
    public static void mytest2()
    {
        list<Contact> listcon=[select id,phone,lastname from contact where id=null ];
        if(!listcon.isEmpty())
        {
            delete listcon;
        }
    }

}