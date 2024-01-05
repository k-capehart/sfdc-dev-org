public class AccountsTriggerHandler extends fflib_SObjectDomain {
	public AccountsTriggerHandler(List<Account> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new AccountsTriggerHandler(sObjectList);
        }
    }
    
    public override void onApplyDefaults() {
        for(Account acc: (List<Account>) Records) {
            acc.Description = 'New account with default description';
        }
    }
    
    public override void onValidate() {
        for(Account acc: (List<Account>) Records) {
            if(acc.Description == null) {
                acc.Description.addError('You must provide a description');
            }
        }
    }

    public override void onBeforeUpdate(Map<Id,SObject> existingRecords) {
        for(Account acc: (List<Account>) Records) {
            acc.AnnualRevenue = acc.AnnualRevenue == null ? 1 : acc.AnnualRevenue;
        }
    }
}