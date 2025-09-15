public with sharing class CaseTriggerHandler extends TriggerHandler {
  public override void handleAfterUpdate() {
    Set<Id> parentCaseIds = new Set<Id>();
    for (Case c : (List<Case>) Trigger.new) {
      Case oldCase = (Case) Trigger.oldMap.get(c.Id);
      if (
        c.Status == 'Closed' &&
        oldCase.Status != 'Closed' &&
        c.ParentId != null
      ) {
        parentCaseIds.add(c.ParentId);
      }
    }
    if (parentCaseIds.isEmpty()) {
      return;
    }

    List<Case> parentCases = [
      SELECT Id, Status
      FROM Case
      WHERE Id IN :parentCaseIds
    ];
    for (Case c : parentCases) {
      c.Status = 'Closed';
    }
    update parentCases;
  }
}
