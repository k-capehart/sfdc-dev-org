public with sharing class AccountHelper {
    public static void setSLA(List<Account> accList) {
        for(Account acc: accList) {
            if(acc.AnnualRevenue >= 1000000) {
                acc.SLA__c = 'Platinum';
            } else if (acc.AnnualRevenue >= 100000) {
                acc.SLA__c = 'Gold';
            } else if (acc.AnnualRevenue >= 10000) {
                acc.SLA__c = 'Silver';
            } else {
                acc.SLA__c = 'Bronze';
            }
        }
    }
}