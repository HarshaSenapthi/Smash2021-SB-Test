public class ConstructorSample {
    
    string n,r,a,p;
    public ConstructorSample(String name,string rating,string active,string phone)
    {
        n=name;
        r=rating;
        a=active;
        p=phone;
        
        system.debug('name is'+n);
        system.debug('rating is'+r);
        system.debug('active'+a);
        system.debug('phone num is'+p);

    }

}