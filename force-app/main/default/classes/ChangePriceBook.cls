public class ChangePriceBook {
  public string selected {Set;Get;}
    Public Boolean hasError {Set;Get;}
    public String errorMessage {Set;Get;}
    public String oppId;
    public  List<SelectOption> getallPriceBooks{
    get{
    getallPriceBooks = new List<SelectOption>();
    getallPriceBooks.add(new SelectOption('', '---NONE---'));
    for(Pricebook2  pb2:[SELECT Name, Id, IsActive,IsStandard FROM Pricebook2 where IsActive=true])
    {
        getallPriceBooks.add(new SelectOption(pb2.Id, pb2.Name));
    }
    return getallPriceBooks;
    }
    Set;
   }
   
   public  ChangePriceBook(){
       hasError = false;
       errorMessage ='';
       oppId = ApexPages.currentPage().getParameters().get('Id');
   }   
   
   public PageReference updatePriceBook(){
     Opportunity op = [SELECT HasOpportunityLineItem, Pricebook2Id FROM Opportunity where id=:oppId];
    if(String.isNotBlank(selected) && op !=null  && (!op.HasOpportunityLineItem) ){
        try{
            Update new List<Opportunity> {new Opportunity(id=oppId,pricebook2Id=selected)};
        }Catch(Exception ex){ hasError = true;errorMessage =ex.getMessage(); }
        
    }
    else
    {
        hasError = true;errorMessage ='Cannot change pricebook on opportunity with line items';
    }
    PageReference ref = new PageReference('/apex/opportunityProductEntry?id=' + oppId);
    
    return hasError?null:ref;
   }   
   
   public PageReference backtoProductPage(){
     PageReference ref = new PageReference('/apex/opportunityProductEntry?id=' + oppId);
   return ref;      
   }
}