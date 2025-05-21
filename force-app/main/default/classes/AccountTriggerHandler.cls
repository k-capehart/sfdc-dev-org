public with sharing class AccountTriggerHandler extends TriggerHandler {
  public override Boolean isDisabled() {
    return BypassAutomation__c.getInstance().Account__c;
  }

  public override void applyDefaults() {
  }

  public override void validate() {
  }
}
