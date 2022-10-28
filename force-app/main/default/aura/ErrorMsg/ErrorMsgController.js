({
    doInit : function(component, event, helper) {
        var action=component.get("c.getCaseDetails");
        var caseid=component.get("v.recordId");
        console.log("Case id is:"+caseid);
        action.setParams({
            "caseid":caseid
                        });
        action.setCallback(this,function(response)
        {
             var state=response.getState();
            if(state=="SUCCESS")
            {
                 var storeResponse = response.getReturnValue();   
                 component.set("v.ErrorMsg",storeResponse);
            }
        });
        $A.enqueueAction(action);
    },

})