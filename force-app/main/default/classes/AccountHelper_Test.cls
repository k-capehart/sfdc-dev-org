@isTest(SeeAllData=false)
public with sharing class AccountHelper_Test {
  @isTest
  public static void testAccountCreation() {
    Test.startTest();
    List<Account> accs = TestDataFactory.createTestAccounts(1, true);
    Test.stopTest();
    List<Account> result = [SELECT Id FROM Account LIMIT 1];
    Assert.isTrue(!result.isEmpty());
  }
}
// test
// test
// test
// test
// test
// test
