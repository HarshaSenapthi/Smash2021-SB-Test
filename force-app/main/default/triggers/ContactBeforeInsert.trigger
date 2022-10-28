trigger ContactBeforeInsert on Contact (before insert,before update) {
    
  for(Contact con : Trigger.new){
            if(trigger.isBefore && trigger.isInsert){
                con.Description = 'Contact is created Successfully' ;
             }
            if(trigger.isUpdate && trigger.isUpdate)
            {  
               con.Description = con.Description + 'Contact is updated by' +UserInfo.getUserName();
            }
        }  

}