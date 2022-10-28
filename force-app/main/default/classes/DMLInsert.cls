public class DMLInsert {

    public static void maxrecords(integer n)
    {
        if(n>0)
        {
            list<contact>listcon=new list<contact>();
            
            for(integer count=1;count<=n;count++)
            {
               contact con = new contact(); 
                
                con.FirstName='senapathi';
                con.LastName='vardhan';
                con.Department='salesdepartment';
                
                 listcon.add(con);

            }
     
        
        if(!listcon.isEmpty())
        {
            insert listcon;
        }        
    }
    }
}