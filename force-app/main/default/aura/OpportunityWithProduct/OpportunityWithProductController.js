({
    
     handleSuccess : function(component, event, helper) {
         var record = event.getParam("response");
         var apiName = record.apiName;
         var myRecordId = record.id;
         var url = '/apex/OpportunityProductEntry?id='+myRecordId;
         var urlEvent = $A.get("e.force:navigateToURL");
         urlEvent.setParams({
             "url": url
         });
         urlEvent.fire(); 
    },
    
    handleDetail : function(component, event, helper) {
         var record = event.getParam("response");
         var apiName = record.apiName;
         var myRecordId = record.id;
         var url = '/'+myRecordId;
         var urlEvent = $A.get("e.force:navigateToURL");
         urlEvent.setParams({
             "url": url
         });
         urlEvent.fire(); 
    },
    
    handleSubmit : function(component, event, helper) {
        var label = event.getSource().get("v.label");
        if(label == 'Save & AddProducts') {
            component.set("v.isAddProduct",true);
        }
    },


	savenew: function(cmp, event, helper) {
     
         cmp.find("editForm").submit(); 
        
         var homeEvt = $A.get("e.force:navigateToObjectHome");
      homeEvt.setParams({
    "scope": "Opportunity"
});
     homeEvt.fire();

        
   },
   
    saveProposal: function(cmp, event, helper) {
        
         cmp.find("editForm").submit();  
        
              
    },
    
    isRefreshed: function(component, event, helper) {

        location.reload();
        
        
    },
    
   onCancel : function(component, event) {
 
     var homeEvt = $A.get("e.force:navigateToObjectHome");
      homeEvt.setParams({
    "scope": "Opportunity"
});
     homeEvt.fire();

},
    onAddproduct : function(component, event, helper){
        
      // component.find("editForm").submit();
        event.preventDefault(); // stop form submission
        var eventFields = event.getParam("fields");
         var action = component.get("c.saveopprtunity");
        //Set method parameter of saveStudent() method.
        action.setParams({"opp": eventFields});
        
        action.setCallback(this, function(response){
            //<response.getState()> return response status as SUCCESS/ERROR/INCOMPLETE etc.
           var result = response.getReturnValue();
            alert(result)
            var url = '/apex/OpportunityProductEntry?id='+result;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire(); 
            //If response from server side is <SUCCESS>, then we will display a success message.
        });
        
        $A.enqueueAction(action); 
        
        
       //  var recordId = component.get("v.recordId");
        
        
        
   //    var recTempId = component.get("v.recordId");
       
      //  alert(recTempId);
     //  var result = event.getParams().response;

      //  window.location.href='/apex/OpportunityProductEntry?id='+recTempId; 
        
         
   /*  var urlEvent = $A.get("e.force:navigateToURL");
    var recordId = component.get("v.recordId");    
        urlEvent.setParams({
        "url": "/apex/OpportunityProductEntry?recordId="+recordId
        });
    urlEvent.fire(); */
        
       
 /*  var pageName = 'OpportunityProductEntry';
$A.get("e.force:navigateToURL").setParams(   {"url": "/apex/" + pageName}   ).fire();
        
var pageName = '/apex/OpportunityProductEntry';
var navService = component.find("navigationService");
var pageReference = {
     type: 'standard__webPage',
     attributes: {
            url: pageName,
      }
};
event.preventDefault();
navService.navigate(pageReference); */
     /*   var recordId = component.get("v.recordId");
        var url = '/apex/OpportunityProductEntry?id={!opportunity.Name}';
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire(); */
    }
    })