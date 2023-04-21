trigger ContactModify on Contact (after insert,after delete,after update) {

    if(Trigger.isAfter){

        Set <Id> accIds = new Set <Id>();

        //collect account IDs after contact is inserted
        if(Trigger.isInsert){            
            for(Contact c:Trigger.new){
                accIds.add(c.accountID);
            }
        }

         //collect account IDs after contact account is updated or deleted
        if(Trigger.isUpdate || Trigger.isDelete){
            for(Contact c:Trigger.old){
                accIds.add(c.accountID);
            }
        }

        //Get the all the collected accounts details and related contacts
        List<Account> accountList =[SELECT Id,Name,Total_Contacts__c,(Select Id from Contacts) from Account where Id IN: accIds];
        List <Account> accountsToUpdate = new List <Account>();
        for(Account a: accountList){
            Account aObj = new Account();
            aObj.Id = a.Id;
            aObj.Total_Contacts__c = a.Contacts.size();
            System.debug('aObj.Name>>'+a.Contacts.size());
            accountsToUpdate.add(aObj);
        }

        System.debug('accountsToUpdate>>'+accountsToUpdate);
        update accountsToUpdate;

    }

}