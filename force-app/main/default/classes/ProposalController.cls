public class ProposalController {
  //  public Proposal__c p{get;set;}
    
    
   // public set<id>accid{get;set;}
   // list<id>plist=new list<id>();
  //  public string noofProposals{get;set;}
    
    // public string pVal{get;set;}
     @AuraEnabled
     public static Proposal__c save(Proposal__c p)
    {
        insert p;
        return p;
    }
    
     @AuraEnabled
    public static Id saveDetails(Proposal__c regForm1){
        // DML operation to save Account Details   
        INSERT regForm1;
        return regForm1.Id; 
    }
    
    //public String prVal{get;set;}
 /*    public ProposalController(){
        p=new Proposal__c(); 
         
        }
     
    public ProposalController(ApexPages.StandardController controller) {
        this.p=(Proposal__c)controller.getrecord();
        system.debug('the proposal elements:'+p);
    }
    
    public PageReference save(){  
       
        insert P;
        
        
        PageReference pg = new PageReference('/'+P.id);
        pg.setRedirect(true);
        return pg;
    }   
    public PageReference cancel(){         
        
        PageReference pg = new PageReference('/lightning/o/Proposal__c/list');
        pg.setRedirect(true);
        return pg;
    }   
    public PageReference newp(){         
        
        PageReference pg = new PageReference('/apex/proposalVf');
        pg.setRedirect(true);
        return pg;
    }  
    
    
    
   
    /* public pageReference save(){
p=new Proposal__c();
insert P;
PageReference pg = new PageReference('/lightning/r/Proposal__c/='+p.id);
pg.setRedirect(true);
return pg;
}*/ 
    
}