public class QuoteExtension {
  private Id quoteId;
  public QuoteExtension(ApexPages.StandardController controller) {
    quoteId = controller.getId();
  }
  public class Bundle {
    public Bundle(String Name) {
      this.Name = Name;
      this.Items = new List<Item>();
    }
    public String Name { get; set; }
    public List<Item> Items { get; set; }
  }
  public class Item {
    public Item(String Name, String ProductCode) {
      this.Name = Name;
      this.ProductCode = ProductCode;
    }
    public String Name { get; set; }
    public String ProductCode { get; set; }
  }
  public List<Bundle> getBundles() {
    List<Bundle> bundles = new List<Bundle>();
    for(Bundle__c bundle:
       [select id,name,
           (select id,name,ProductCode__c from Products__r) from Bundle__c
            where Quote__c = :quoteId]) {
      Bundle tempBundle = new Bundle(bundle.name);
      for(Product__c product:bundle.Products__r)
        tempBundle.items.add(new Item(product.name,product.ProductCode__c));
      bundles.add(tempBundle);
    }
    return bundles;
  }
}