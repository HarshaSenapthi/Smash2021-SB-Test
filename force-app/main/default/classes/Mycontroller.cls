public class Mycontroller {
    @AuraEnabled   
    public static string saveopprtunity(Opportunity opp)
    {
        insert opp;
        system.debug('Opp>>> '+opp);
        return opp.Id;
    }    
}