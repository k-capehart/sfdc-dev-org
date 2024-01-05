public class AccountsSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Account.Name,
            Account.Description,
            Account.AnnualRevenue
        };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Account.sObjectType;
    }
    
    public List<Account> selectById(Set<Id> idSet) {
		return (List<Account>) selectSObjectsById(idSet);
    }

    public List<Account> selectByIdWithOwnership(Set<Id> idSet) {
        List<Schema.SObjectField> fields = getSObjectFieldList();
        fields.add(Account.Ownership);
        return (List<Account>) Database.query(
            newQueryFactory()
                .selectFields(fields)
                .setCondition('Id in :idSet')
                .toSOQL()   
        );
    }
}