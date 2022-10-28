public class ListCollection {
   
    public static void data(){
        
    
    list<String> listacc=new list<STring>();
    
    listacc.add('harsha');
    listacc.add('vadhan');
    listacc.add('senapathi');
    
    if(!listacc.isEmpty())
    {
        for(String acc:listacc)
        {
            system.debug('elemets are'+acc);
        }
    }
    }
}