public with sharing class MassAccDeleteHandler {
    @AuraEnabled(cacheable = true)
    public static List<Account> fetchAccountList() {
        return [ SELECT Id, Name, Website FROM Account order by Name asc limit 15];    
    }
    
    @AuraEnabled
    public static void deleteSelectedAccounts(List<Account> accountLst) {
        delete accountLst;
    }
    
    @AuraEnabled
    public static void deleteSingleAccount(Account accounts) {
        /*Contact cs=[select id,name from contact where Id=:contacts];
        system.debug('cs'+cs);*/
        delete accounts;
    }
    
     @AuraEnabled( cacheable = true ) 
    public static List< Account > fetchAccounts( String searchKey ) { 
     
        String strKey = '%' + searchKey + '%'; 
        return [ SELECT Id, Name, Website FROM Account   WHERE Name LIKE: strKey LIMIT 10 ]; 
         
    } 
}
