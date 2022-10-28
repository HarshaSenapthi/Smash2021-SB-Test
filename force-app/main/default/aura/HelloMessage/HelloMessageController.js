({
	myAction : function(component, event, helper) {
		var btclicked = event.getSource();
        var btMessage = btclicked.get(v.label);
        componant.set("v.message",btMessage);
	}
})