/**
 * @description       : Batch Apex class to process active accounts
 * @last modified on  : 06-24-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class BatchClass implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id, Name FROM Account]);
    }

    public void execute(Database.BatchableContext BC, List<SObject> scope) {
        List<Account> accountsToUpdate = new List<Account>();

        for (SObject s : scope) {
            Account acc = (Account) s;
            acc.Name += ' - Processed';
            accountsToUpdate.add(acc);
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }

    public void finish(Database.BatchableContext BC) {
        System.debug('Batch process completed successfully.');
    }
}