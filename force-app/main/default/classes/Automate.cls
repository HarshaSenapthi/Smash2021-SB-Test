public class Automate {

    public List<account> enrollmentlist {get;set;}
    public Id recId {get; set;}
      public account classrec {get; set;}
    
    public Automate(ApexPages.StandardController controller){
        classrec = (Account)controller.getRecord();
        recId = classrec.Id;
        system.debug('sakdhsaj'+recId);
    }
    
    public PageReference createCompetencyRecs() {
   // createCompetencyRecs(recId);
    account clst=[select id,name,Back_Check__c from account where id =:recId];
     clst.Back_Check__c=true;
     system.debug('sakdhsaj'+recId);
     update clst;
    PageReference pageRef = new PageReference('/'+recId);
    pageRef.setRedirect(true);
    return pageRef; 
    }
    
   
    
}