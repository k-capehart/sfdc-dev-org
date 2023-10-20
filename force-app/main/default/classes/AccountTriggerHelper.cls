public with sharing class AccountTriggerHelper {
    public static Boolean validatePhoneNumber(Account a) {
        return Pattern.matches('[0-9(),./\\-]+', a.Phone);
    }
}