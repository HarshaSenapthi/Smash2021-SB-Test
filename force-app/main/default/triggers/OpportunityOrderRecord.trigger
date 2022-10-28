trigger OpportunityOrderRecord on Opportunity (after insert,after update) {
    
    
       list<Order> lstord = new list<Order>();
        for(Opportunity Opp : Trigger.new)
        {
              if(opp.StageName == 'Closed Won' && opp.Amount == 5000000 )
              {
                  Order od = new order();
                  od.OpportunityId = opp.Id;
                  od.AccountId = opp.AccountId;
                  od.EffectiveDate = opp.CloseDate;
                  od.Status= 'Draft';
                  lstord.add(od);
              }
        }
            if(!lstord.isEmpty())
                insert lstord ;
}