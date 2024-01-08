public with sharing class AccountTriggerHandler extends TriggerHandler {
    public override Boolean isDisabled() {
        return BypassAutomation__c.getInstance().Accounts__c;
    }

    public override void applyDefaults() {
        for(Account acc: (List<Account>) Trigger.New) {
            if(String.isBlank(acc.Description)) {
                acc.Description = 'New Account';
            }
        }
    }

    public override void validate() {
        for(Account acc: (List<Account>) Trigger.New) {
            if(acc.BillingStreet == null) {
                acc.BillingStreet.addError('Address is required for new accounts.');
            }
        }
    }

    public override void beforeInsert() {
        AccountHelper.setSLA((List<Account>) Trigger.New);
    }

    public override void beforeUpdate() {
        AccountHelper.setSLA((List<Account>) Trigger.New);
    }
}