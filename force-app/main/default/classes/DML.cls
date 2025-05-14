public with sharing class DML {
    public void insertMethod(){
        Account newAcct = new Account(name = 'Acme');
        try {
            insert newAcct;
        } catch (DmlException e) {
            // Process exception here
        }
    }

    public void updateMethod(){
        Account existingAcct = [SELECT Id FROM Account WHERE Name = 'Acme' LIMIT 1];
        existingAcct.Name = 'Updated Acme';
        try {
            update existingAcct;
        } catch (DmlException e) {
            // Process exception here
        }
    }

    public void upsertMethod(){
        Account newAcct = new Account(name = 'Acme');
        try {
            upsert newAcct;
        } catch (DmlException e) {
            // Process exception here
        }
    }

    public void deleteMethod(){
        Account existingAcct = [SELECT Id FROM Account WHERE Name = 'Acme' LIMIT 1];
        try {
            delete existingAcct;
        } catch (DmlException e) {
            // Process exception here
        }
    }

    public void undeleteMethod(){
        Account existingAcct = [SELECT Id FROM Account WHERE Name = 'Acme' ALL ROWS];
        try {
            undelete existingAcct;
        } catch (DmlException e) {
            // Process exception here
        }
    }

    public void mergeMethod(){
        Account acct1 = [SELECT Id FROM Account WHERE Name = 'Acme' LIMIT 1];
        Account acct2 = [SELECT Id FROM Account WHERE Name = 'Acme2' LIMIT 1];
        try {
            merge acct1 acct2;
        } catch (DmlException e) {
            // Process exception here
        }
    }
}