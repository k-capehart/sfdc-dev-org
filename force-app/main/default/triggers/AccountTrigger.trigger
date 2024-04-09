trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after undelete) {
    new AccountTriggerHandler().run(); // call handler
}