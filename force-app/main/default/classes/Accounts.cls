public class Accounts extends fflib_SObjects {
    public Accounts(List<Account> sObjectList) {
		super(sObjectList, Schema.Account.SObjectType);
	}

    public List<Account> getAccounts() {
        return (List<Account>) getRecords();
    }

    public void multiplyRevenue(Integer factor, fflib_SObjectUnitOfWork uow) {
        for(Account acc: getAccounts()) {
            acc.AnnualRevenue = acc.AnnualRevenue * factor;
            uow.registerDirty(acc);
        }
        uow.commitWork();
    }
}