public class MapTest {
    
    public static void m1()
    {
        map<integer,string> cnames=new map<integer,string>();
        system.debug('size of the collection is'+cnames.size());
        
        cnames.put(1,'india');
        cnames.put(2, 'australia');
        cnames.put(3, 'england');
        cnames.put(4, 'southafrica');
        if(!cnames.isEmpty())
        {
       
       system.debug('elements inthe collection are'+cnames.get(3));
        }
    }

}