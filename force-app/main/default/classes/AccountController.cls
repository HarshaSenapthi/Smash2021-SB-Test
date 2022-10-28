public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name FROM Account WITH SECURITY_ENFORCED LIMIT 10];
    }

    @AuraEnabled(cacheable=true)
    public static Account getSingleAccount() {
        return [
            SELECT Id, Name, Phone, Type
            FROM Account
            WITH SECURITY_ENFORCED
            LIMIT 1
        ];
    }
    @AuraEnabled( cacheable = true ) 
    public static List< Account > fetchAccounts( String searchKey ) { 
     
        String strKey = '%' + searchKey + '%';
        return [ SELECT Id, Name, Industry FROM Account WHERE Name LIKE: strKey LIMIT 10 ]; 
         
    } 
}