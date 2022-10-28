trigger update_OppAcc_Type on Opportunity (before insert,before update) {
    
      set<ID> accountIDList = new set<ID>();
        
    list <Opportunity> opp = Trigger.new;
      for(Opportunity o : opp)    
      {
          accountIDList.add(o.accountID); // need t0 collect accountid along with opportunity
      }
    
      list<Opportunity> opp1 = [select id,accountId,name from Opportunity where accountId IN:accountIDList] ; 
    
     // get all opportunities along with Account
    
       map<id,account> accs = new map<id,account>([select id,type from account where id IN:accountIDList]);
    
           
             for (opportunity opp2 : opp1)
             {
                 accs.get(opp2.accountId).type='customer';
             }
              update accs.values();
}