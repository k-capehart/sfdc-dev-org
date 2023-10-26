@isTest(SeeAllData=false)
public with sharing class AccountTriggerTest {
    @isTest static void testAccount() {
        Account a = new Account(Name = 'Test', Phone = '1234567890');
        AccountTriggerHelper.validatePhoneNumber(a);
    }
}