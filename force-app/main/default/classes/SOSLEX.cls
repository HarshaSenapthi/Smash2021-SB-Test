public class SOSLEX {
    
    public static void harsha()
    {
        List<List<Sobject>> lsttext =[FIND 'ha*' IN ALL FIELDS RETURNING 
                             Account(name,industry,rating),
                              Lead(lastname,company,status)
                             ] ;
    
            if(!lsttext.isEmpty())
            {
                system.debug(''+lsttext);
            }
}
    
}