({
	init: function (cmp) {
        var action = cmp.get("c.getAccounts");
        action.setCallback(this, function(response){           
            var state = response.getState();
            if (state === "SUCCESS") {                 
                cmp.set("v.accountlist", response.getReturnValue());
            }
        });
	 $A.enqueueAction(action);     
    }
})