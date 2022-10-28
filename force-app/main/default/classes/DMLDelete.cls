public class DMLDelete {
    
    public static void itemstodelete(string name)
    {
        name=name+'%';
        list<contact>listcon=[select id,lastname,phone from contact where lastname like:name and isdeleted=true ALL ROWS];
        
        if(!listcon.isEmpty())
        {
            undelete listcon;
        }
    }
        public static void m1(){
        
          list<contact>listcon1=[select id,lastname,phone,isdeleted from contact where isdeleted =true
                                                                                        ALL ROWS ];
           for(contact c:listcon1)
           {
               system.debug('deleted comtacts are---------------'+c);
           }
        
    }
    

}