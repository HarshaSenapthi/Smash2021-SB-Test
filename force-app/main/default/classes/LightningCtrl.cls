public with sharing class LightningCtrl {
   
    @AuraEnabled 
    public static List<Contact> getContacts(){ 
        List<Contact> conlist = [Select Name, Phone, Email From Contact limit 20 ]; 
        return conlist;
    } 
}
