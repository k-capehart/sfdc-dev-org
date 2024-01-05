public with sharing class AccountsService {
    public static void multiplyRevenue(Set<Id> accountIds, Integer factor) {
        if(accountIds == null || accountIds.isEmpty()) {
            throw new AccountServiceException('Account IDs not specified');
        }

        Accounts accounts = new Accounts(new AccountsSelector().selectById(accountIds));
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[]{Account.SObjectType});
        accounts.multiplyRevenue(factor, uow);
    }

    public class AccountServiceException extends Exception{}
}