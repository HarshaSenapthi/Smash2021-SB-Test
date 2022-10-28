({
    doInit: function( component, event, helper ) {
        var action = component.get("c.getPageLayoutFields");
        
		action.setCallback(this, function(response) {
        	var state = response.getState();
			if (state === "SUCCESS") {
                component.set("v.layoutSections", response.getReturnValue() );
                console.log( response.getReturnValue() );
            }
            else if (state === "INCOMPLETE") {
            }
            else if (state === "ERROR") {
                var errors = response.getError();
				console.log( errors );
            }
        });
        
        $A.enqueueAction(action);
        
    },
    
    
	handleSuccess : function(component, event, helper) {
      var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
           "title": "Success!",
           "message": "Proposal created successfully.",
            "type": "success"
        });
        toastEvent.fire(); 
    },
    
    handleLoad : function(component, event, helper) {
    	component.set("v.showSpinner", false);   
    },
    handleSubmit : function(component, event, helper) {
         
    },
    onCancel : function(component, event) {
 
     var homeEvt = $A.get("e.force:navigateToObjectHome");
      homeEvt.setParams({
    "scope": "Proposal__c"
});
     homeEvt.fire();

},
     saveProposal: function(cmp, event, helper) {
        
          var payload = event.getParams().response;
    var navService = component.find("navService");

    var pageReference = {
        type: 'standard__recordPage',
        attributes: {
            "recordId": payload.id,
            "objectApiName": "Proposal__c",
            "actionName": "view"
        }
    }
    event.preventDefault();
    navService.navigate(pageReference);  
        
    }
 
})