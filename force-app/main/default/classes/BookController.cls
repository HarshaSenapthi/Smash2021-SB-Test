public with sharing class BookController {
     @AuraEnabled(cacheable=true)
    public static List<Book__c> searchBooks(String searchKey) {
        String key = '%' + searchKey + '%';
        
            SELECT Id, Name, PublishedDate__c, BookDescription__c,PDF_Available__c, Author__c
            FROM Book__c
            WHERE Name LIKE :key
            LIMIT 30
        ];
    }
    @AuraEnabled
    public static void deleteBook(Id recordId){
        try {
            list<Account> lstAccToDelete = new list<Account>();
            System.debug('recordId ====> '+recordId);
            Book__c b = new Book__c(id=recordId);
            delete b;
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
        @AuraEnabled
    public static void addBook(string record){
        system.debug('record'+record);
        Object result = JSON.deserializeUntyped(record);
        system.debug('result'+result);
        map<string,object> mapv = (map<string,object>)result;
        system.debug('mapv'+mapv);
        system.debug('Author'+mapv.get('Author__c'));
        Book__c b = new Book__c(Name=(string)mapv.get('Name'), PublishedDate__c=(string)mapv.get('PublishedDate__c'), BookDescription__c=(string)mapv.get('BookDescription__c'),PDF_Available__c=(Boolean)mapv.get('PDF_Available__c'), Author__c=(string)mapv.get('Author__c'));
        Insert b;

    }
}
