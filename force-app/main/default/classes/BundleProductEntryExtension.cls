public class BundleProductEntryExtension {
    
  public Bundle__c theOpp {get;set;}
    public String searchString {get;set;}
    public opportunityLineItem[] shoppingCart {get;set;}
    public priceBookEntry[] AvailableProducts {get;set;}
    public Pricebook2 theBook {get;set;}   
    public Product2 search {Set;Get;}
    
    public String toSelect {get; set;}
    public String toUnselect {get; set;}
    public Decimal Total {get;set;}
    
    public Boolean overLimit {get;set;}
    public Boolean multipleCurrencies {get; set;}
    public Decimal OppTotals {Set;Get;}
    
    private Boolean forcePricebookSelection = false;
    
     Set<opportunityLineItem> forDeletion = new Set<opportunityLineItem>{};


    public BundleProductEntryExtension(ApexPages.StandardController controller) {

        search = new Product2(Product_Type__c='');
        // Need to know if org has multiple currencies enabled
        multipleCurrencies = UserInfo.isMultiCurrencyOrganization();

        // Get information about the Opportunity being worked on
        if(multipleCurrencies)
            theOpp = database.query('select Id,Pricebook2Id__c,Pricebook2.Name,CurrencyIsoCode from Bundle__c where Id = \'' + controller.getRecord().Id + '\' limit 1');
        else
            theOpp = [select Id, Pricebook2Id__c from Bundle__c where Id = :controller.getRecord().Id limit 1];
        
        // If products were previously selected need to put them in the "selected products" section to start with
        shoppingCart = [select Id, Quantity,Discount,TotalPrice__c,Subtotal,TotalPrice,Grade__c, UnitPrice, Description, PriceBookEntryId, PriceBookEntry.Name, PriceBookEntry.IsActive, PriceBookEntry.Product2Id, PriceBookEntry.Product2.Name,PriceBookEntry.Product2.ProductCode, PriceBookEntry.PriceBook2Id,OpportunityId,Initial_Quantity__c,Delta__c,Upsell__c,Downsell__c,Renewal__c  from opportunityLineItem where OpportunityId=:theOpp.Id];
        refreshTotals();
    
        // Check if Opp has a pricebook associated yet
        if(theOpp.Pricebook2Id__c == null){
            Pricebook2[] activepbs = [select Id,Name from Pricebook2 where isActive = true limit 2];
            if(activepbs.size() == 2){
                forcePricebookSelection = true;
                theBook = new Pricebook2();
            }
            else{
                theBook = activepbs[0];
            }
        }
        else{
          //  theBook = theOpp.Pricebook2;
        }
        if(Test.isRunningTest()) theBook= new PriceBook2(Id=Test.getStandardPricebookId());
        if(!forcePricebookSelection)
            updateAvailableList();
    }
    public void clearfilter(){
        searchString=null;
        search = new Product2(family=null);
        updateAvailableList();
    } 
    // this is the 'action' method on the page
    public PageReference priceBookCheck(){
    
        // if the user needs to select a pricebook before we proceed we send them to standard pricebook selection screen
        if(forcePricebookSelection){        
            return changePricebook();
        }
        else{
        
            //if there is only one active pricebook we go with it and save the opp
            if(theOpp.pricebook2Id__c != theBook.Id){
                try{theOpp.Pricebook2Id__c = theBook.Id;update(theOpp);}catch(Exception e){ApexPages.addMessages(e);}
            }
            
            return null;
        }
    }
       
    public String getChosenCurrency(){
    
        if(multipleCurrencies)
            return (String)theOpp.get('CurrencyIsoCode');
        else
            return '';
    }

    public void updateAvailableList() {
    
        // We dynamically build a query string and exclude items already in the shopping cart
        String qString = 'select Id,Pricebook2Id,IsActive,Product2.Curriculum__c,Product2.Name,Product2.Family,Product2.Product_Type__c,Product2.IsActive,Product2.Description,Product2.ProductCode,UnitPrice from PricebookEntry where IsActive=true and Pricebook2Id = \'' + theBook.Id + '\'';
        if(multipleCurrencies)
            qstring += ' and CurrencyIsoCode = \'' + theOpp.get('currencyIsoCode') + '\'';
        
        // note that we are looking for the search string entered by the user in the name OR description
        // modify this to search other fields if desired
        if(String.isNotBlank(searchString)){
            qString+= ' and (Product2.Name like \'%' + searchString + '%\' or Product2.Description like \'%' + searchString + '%\')';
        }system.debug(search.Product_Type__c);
        if(search !=null && String.isNotBlank(search.Curriculum__c))
        { 
          qString+= ' AND Product2.Curriculum__c = \''+ String.escapeSingleQuotes(search.Curriculum__c.trim()) +'\'';
        }
        if(search !=null && String.isNotBlank(search.Product_Type__c))
        { 
          qString+= ' AND  Product2.Product_Type__c = \''+String.escapeSingleQuotes(search.Product_Type__c.trim()) +'\'';
        }
        if(search !=null && search.IsActive )
        { 
          qString+= ' AND  Product2.IsActive ='+search.IsActive ;
        }  
        
        Set<Id> selectedEntries = new Set<Id>();
        for(opportunityLineItem d:shoppingCart){
            selectedEntries.add(d.PricebookEntryId);
        }
        
        if(selectedEntries.size()>0){
            String tempFilter = ' and Id not in (';
            for(Id i : selectedEntries){
                tempFilter+= '\'' + (String)i + '\',';
            }
            String extraFilter = tempFilter.substring(0,tempFilter.length()-1);
            extraFilter+= ')';
            
            qString+= extraFilter;
        }
        
        qString+= ' order by Product2.Name';
        qString+= ' limit 101';
        
        system.debug('qString:' +qString);        
        AvailableProducts = database.query(qString);
        
        // We only display up to 100 results... if there are more than we let the user know (see vf page)
        if(AvailableProducts.size()==101){
            AvailableProducts.remove(100);
            overLimit = true;
        }
        else{
            overLimit=false;
        }
    }
    
    public void addToShoppingCart(){
    
        // This function runs when a user hits "select" button next to a product
    
        for(PricebookEntry d : AvailableProducts){
            if((String)d.Id==toSelect){
                shoppingCart.add(new opportunityLineItem(OpportunityId=theOpp.Id, PriceBookEntry=d, PriceBookEntryId=d.Id,Quantity=1, UnitPrice=d.UnitPrice));
                break;
            }
        }
        
        updateAvailableList();  
    }
    
    public void cloneProduct(){
        opportunityLineItem olditem = shoppingCart[(Integer.valueof(apexPages.currentPage().getParameters().get('index')))];
        Map<String,Object> mapOb= (Map<String, Object>)JSON.deserializeUntyped( JSON.serialize( olditem ));
        mapOb.remove('TotalPrice');
        olditem = (opportunityLineItem) JSON.deserialize(JSON.serialize(mapOb), opportunityLineItem.class);
        if(shoppingCart.size()-1>(Integer.valueof(apexPages.currentPage().getParameters().get('index'))))
            shoppingCart.add((Integer.valueof(apexPages.currentPage().getParameters().get('index')))+1,olditem.clone());
        else
         shoppingCart.add(olditem.clone());
        system.debug(olditem.clone());
        refreshTotals();
    }
    public PageReference removeFromShoppingCart(){
    
        // This function runs when a user hits "remove" on an item in the "Selected Products" section
    

        system.debug(apexPages.currentPage().getParameters().get('delRecId'));
        System.debug(shoppingCart);
        Boolean hasduplicateRecord = false;
        for(opportunityLineItem d : shoppingCart){
            if((String)d.PriceBookEntryId==toUnselect){
                System.debug(d.Id + ' == '+ apexPages.currentPage().getParameters().get('delRecId'));

                
                if(d.Id!=null &&  String.isNotBlank(apexPages.currentPage().getParameters().get('delRecId')) 
                              && d.Id == apexPages.currentPage().getParameters().get('delRecId'))
                {
                    forDeletion.add(d);
                    shoppingCart.remove(Integer.valueof(apexPages.currentPage().getParameters().get('index')));
                    break;
                } else if(String.isBlank(apexPages.currentPage().getParameters().get('delRecId'))){
                    shoppingCart.remove(Integer.valueof(apexPages.currentPage().getParameters().get('index')));
                    break;
                }
                 
            }
        }
        System.debug(shoppingCart);
        System.debug(apexPages.currentPage().getParameters().get('index'));
        System.debug(forDeletion);
        updateAvailableList();
        refreshTotals();
        return null;
    }
    Public void refreshTotals()
    {
        Integer count =0;
        OppTotals = 0;
        System.debug(apexPages.currentPage().getParameters().get('index'));
        for(OpportunityLineItem opl:  shoppingCart)
        {
            Map<String,Object> so =(Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(opl)); 
            System.debug(so.get('Discount'));
            if(opl.TotalPrice__c== null || opl.TotalPrice__c==0)
                opl.TotalPrice__c  =opl.TotalPrice;
            if(so.get('UnitPrice') !=null && so.get('Quantity')!=null && so.get('Discount')!=null && opl.UnitPrice>=0 && opl.Quantity>=0 && so.get('Discount')!=null && opl.Discount>=0 && String.valueof(count)==apexPages.currentPage().getParameters().get('index'))
            {
                opl.TotalPrice__c = ((opl.UnitPrice-(opl.UnitPrice* ((opl.Discount)/100) ))*opl.Quantity).setScale(2);
            }   
            else if(so.get('UnitPrice')!=null && so.get('Quantity')!=null && opl.UnitPrice>=0 && opl.Quantity>=0 && so.get('Discount')==null&& String.valueof(count)==apexPages.currentPage().getParameters().get('index'))
                
                {
                    opl.TotalPrice__c = (opl.UnitPrice*opl.Quantity).setScale(2);
                }
                
            if(so.get('UnitPrice')!=null && opl.UnitPrice>=0 && opl.TotalPrice__c!=null )    
                OppTotals = OppTotals+opl.TotalPrice__c;    
            
            count++;
        }
        OppTotals.setScale(2);
        System.debug(OppTotals);
    } 
    public void TotalPriceChange()
    {
        List<opportunityLineItem> sc = shoppingCart;
        Integer count = 0;
        for(opportunityLineItem d : shoppingCart){
            if(String.valueof(count)==apexPages.currentPage().getParameters().get('index')){
                    d.Quantity =d.Quantity==null?1:d.Quantity;
                    
                    System.debug(d.UnitPrice +''+d.TotalPrice+''+d.Quantity);
                    d.Discount = (math.abs((d.UnitPrice- (d.TotalPrice__c/d.Quantity))/(d.UnitPrice))*100).setScale(2);
                
            }
            count++;
        }
        refreshTotals();
    } 
    public PageReference onSave(){
    
       try
       {
        System.debug(shoppingCart);
        // If previously selected products are now removed, we need to delete them
        if(forDeletion.size()>0)
            delete(new List<opportunityLineItem>(forDeletion));
    
        // Previously selected products may have new quantities and amounts, and we may have new products listed, so we use upsert here
           if(shoppingCart.size()>0){
               // To update renewed values in product
               for(opportunityLineItem oli:shoppingCart){
                   if(oli.Initial_Quantity__c != null){                    
                       if(oli.Initial_Quantity__c == oli.Quantity){
                           oli.Renewed_Qty__c = oli.Quantity;
                            oli.Delta__c =0;
                           // oli.Quantity = renQty;
                            oli.Upsell__c =  null;
                            oli.Downsell__c = null;
                            oli.Renewal__c = oli.Initial_Quantity__c;
                       }
                       else if(oli.Initial_Quantity__c < oli.Quantity){
                           oli.Renewed_Qty__c = oli.Quantity;
                            oli.Delta__c = oli.Quantity - oli.Initial_Quantity__c;
                           // oli.Quantity = renQty;
                            oli.Upsell__c =  oli.Delta__c;
                            oli.Downsell__c = null;
                            oli.Renewal__c = oli.Initial_Quantity__c;
                       }
                      
                        else{
                  
                            oli.Renewed_Qty__c = oli.Quantity;
                            oli.Delta__c =  oli.Initial_Quantity__c - oli.Renewed_Qty__c;
                            //oli.Quantity = renQty;
                            oli.Downsell__c = oli.Delta__c;
                            oli.Upsell__c = null;
                            oli.Renewal__c = oli.Quantity;
                        }
                    } 
                 }
                 
                upsert(shoppingCart);
           }
        }
        catch(Exception e){
            ApexPages.addMessages(e);
            return null;
        }  
           
        // After save return the user to the Opportunity
        return new PageReference('/' + ApexPages.currentPage().getParameters().get('Id'));
    }
    
    public PageReference onCancel(){
 
        // If user hits cancel we commit no changes and return them to the Opportunity   
        return new PageReference('/' + ApexPages.currentPage().getParameters().get('Id'));
    } 
    
    public PageReference changePricebook(){
    
        // This simply returns a PageReference to the standard Pricebook selection screen
        // Note that is uses retURL parameter to make sure the user is sent back after they choose
    
        //PageReference ref = new PageReference('/oppitm/choosepricebook.jsp');
        PageReference ref = new PageReference('/apex/ChangePriceBookVF');
        ref.getParameters().put('id',theOpp.Id);
        ref.getParameters().put('retURL','/apex/opportunityProductEntry?id=' + theOpp.Id);
        
        return ref;
    }
}