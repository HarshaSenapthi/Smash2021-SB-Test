trigger ProductUpdate on Product__c (after insert,after update) {
    
    list<Affliated_prouct__c> Ap=new list<Affliated_prouct__c>();
    list<id> lststr=new list<id>();
    for(Product__c pp:trigger.new)
    {
        lststr.add(pp.Bundle__c);
       
    }
     list<Product__c> lstbun=[select id,name from Product__c where id IN:lststr];
    
    for(Product__c p:trigger.new)
    {
       
        if(p.Product_Family__c=='SLA')
        {
            Affliated_prouct__c a=new Affliated_prouct__c();
            a.Bundle__c='a0G2v00002gzJjwEAE';
            a.Productc__c=p.id;
            ap.add(a);
        }
        
    }
     insert ap;
}