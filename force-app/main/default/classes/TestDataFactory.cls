@isTest(SeeAllData=False) //test
public with sharing class TestDataFactory {
    public static List<Account> createTestAccounts(Integer num, boolean doInsert) {
        List<Account> accs = new List<Account>();
        for(Integer i=0;i < num; i++) {
            accs.add(new Account(
                Name = 'Test Account ' + i,
                BillingStreet = '123 Test Street'
            ));
        }
        if(doInsert) { insert accs; }
        return accs;
    } // test
}