trigger DeletePrevention on Contact (before delete) {
    
     list<Contact> cc=Trigger.isDelete ? Trigger.old:Trigger.new;
    
     Id clientRecordTypeId = Schema.SObjectType.contact.getRecordTypeInfosByName().get('Construction').getRecordTypeId();
    system.debug('jgfjhh'+clientRecordTypeId);
    Id clientRecordTypeId1 = Schema.SObjectType.contact.getRecordTypeInfosByName().get('Agricultures').getRecordTypeId();
    String profileName=[Select Id,Name from Profile where Id=:userinfo.getProfileId()].Name;
    for(Contact currentContact :cc) {

        //Check if current user is not a system administrator
        if(profileName !='System Administrator'){

            if(clientRecordTypeId == currentContact.RecordTypeId){
                currentContact.addError('You can not delete a Clieant Account, please contact your Salesforce Administrator');
            }    
          if(clientRecordTypeId1 == currentContact.RecordTypeId){
                currentContact.addError('You can not delete a Clieant Account, please contact your Salesforce Administrator');
            }                
            

        }

    }

}