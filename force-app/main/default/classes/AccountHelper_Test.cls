@isTest(SeeAllData=false)
private with sharing class AccountHelper_Test {

    @isTest
    private static void testSetSLA() {
        List<Account> accs = TestDataFactory.createTestAccounts(4, false);
        accs[0].AnnualRevenue = 10;
        accs[1].AnnualRevenue = 10000;
        accs[2].AnnualRevenue = 100000;
        accs[3].AnnualRevenue = 1000000;
        
        Test.startTest();
        insert accs;
        Test.stopTest();

        List<Account> accResult = [SELECT Id, SLA__c, Name FROM Account ORDER BY AnnualRevenue ASC];
        Assert.areEqual('Bronze', accResult[0].SLA__c, 'SLA was not set correctly.');
        Assert.areEqual('Silver', accResult[1].SLA__c, 'SLA was not set correctly.');
        Assert.areEqual('Gold', accResult[2].SLA__c, 'SLA was not set correctly.');
        Assert.areEqual('Platinum', accResult[3].SLA__c, 'SLA was not set correctly.');
    }
}