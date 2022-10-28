trigger oppcount on Account (after insert,after update) {
    
        list<Account> acc=Trigger.new;
   
              if(acc.size() > 0) {
            List<Account> accountList = [SELECT Id, (SELECT Id FROM Opportunities) FROM Account WHERE Id in: acc];
            if(accountList.size() > 0){

                for(Account accRec : accountList)

                {

                    accRec.OppCount__c = accRec.Opportunities.size();
                     
                     accountList.add(accRec);
                }  

                UPDATE accountList;

            }

        }

    }