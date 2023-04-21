public class AccountListController {

    @AuraEnabled
	public static List<Account> getAccounts() {
   		return [SELECT Id, Name, CreatedDate FROM Account ORDER BY CreatedDate DESC LIMIT 10];
	}
}