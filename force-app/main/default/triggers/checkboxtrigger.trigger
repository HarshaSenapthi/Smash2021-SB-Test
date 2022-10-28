trigger checkboxtrigger on Contact (before insert,before update) {

    list<Contact>aclist=new list<Contact>();
     list<string>ulist=new list<string>();
   for(Contact ac:trigger.new){
       if(ac.Generalist__c==true){
         string ulist1 = Schema.Contact.fields.Generalist__c.getDescribe().getLabel();
           ulist.add(ulist1);
       }
       if(ac.Data_Analytics_Specialist__c==true){
         string ulist2 = Schema.Contact.fields.Data_Analytics_Specialist__c.getDescribe().getLabel();
           ulist.add(ulist2);
       }
       if(ac.Machine_Learning_Specialist__c==true){
         string ulist3 = Schema.Contact.Machine_Learning_Specialist__c.getDescribe().getLabel();
           ulist.add(ulist3);
       }
       if(ac.Cybersecurity_Technologist__c==true){
         string ulist4 = Schema.Contact.fields.Cybersecurity_Technologist__c.getDescribe().getLabel();
           ulist.add(ulist4);
       }
        if(ac.Cybersecurity_Specialist__c==true){
         string ulist5 = Schema.Contact.fields.Cybersecurity_Specialist__c.getDescribe().getLabel();
           ulist.add(ulist5);
       }
       if(ulist.size()>0){
         string s ='';
       for(string u:ulist)
       {
       
          s=s+u+(';');
                 
       }
            ac.Credential_of_Interest__c =s;
            System.debug('the values are '+ac.Credential_of_Interest__c);
           System.debug('the values are '+s);
       }
       
   } 

}