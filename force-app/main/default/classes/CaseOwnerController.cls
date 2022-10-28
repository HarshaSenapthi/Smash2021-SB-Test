public class CaseOwnerController {

@AuraEnabled
public static String getCaseDetails( Id caseid) 
{
   list<Contact> lstC = [select Id,name,Recruitment_Assessment__c from contact where id=:caseid];
       for (Contact obj: lstC) 
       {
            if(obj.Recruitment_Assessment__c=='Do Not Contact')
               { 
               return 'Only the case owners are authorised to send email on a case.';
               }
       }
   return '';
}
}