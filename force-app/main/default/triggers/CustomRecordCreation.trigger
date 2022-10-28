trigger CustomRecordCreation on Product2(before insert,before update) {
     set<String> namedup=new set<String>();
    list<Product__c> latpro=new list<Product__c>();
    List<Product__c> latpro1=[select id,name,ProductCode__c from Product__c];
    for(Product__c p2:latpro1)
    {
        namedup.add(p2.name);
    }
    for(Product2 p:Trigger.new)
    {
       
       Product__c pp =new product__c();
        pp.Name=p.Name+system.today();
        pp.Product_Family__c=p.Family;
        pp.Product_Type__c=p.Product_Type__c;
        pp.ProductCode__c=p.ProductCode;
        pp.Product__c='01t2v00000CnBuIAAV';
        system.debug(namedup.contains(pp.Name));
        if(namedup.contains(pp.Name)==false)
        {
             latpro.add(pp);
        }
       
    }
    insert latpro;
    
}