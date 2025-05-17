/**
 * @description       : Classe global Database
 * @last modified on  : 05-16-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class DatabaseClass {
    // Database.insert
    public void doInsert(){
        Account acc = new Account(Name = 'Test Account');
        Database.SaveResult sr = Database.insert(acc);
    }

    public void doInsertWithAllOrNone(){
        Account acc = new Account(Name = 'Test Account2');
        Database.SaveResult sr = Database.insert(acc, false);
    }

    public void doInsertWithAllOrOneAndDmlOptions(){
        // Suponha que queremos inserir alguns contatos e garantir que o sistema ignore regras de atribuição automática de proprietário

        // Criamos a lista de contatos a ser inserida
        List<Contact> contactsToInsert = new List<Contact>{
            new Contact(FirstName = 'Ana', LastName = 'Silva', Email = 'ana.silva@example.com'),
            new Contact(FirstName = 'Carlos', LastName = 'Oliveira', Email = 'carlos.oliveira@example.com')
        };

        // Criamos e configuramos as opções DML
        Database.DMLOptions dmlOptions = new Database.DMLOptions();
        dmlOptions.assignmentRuleHeader.useDefaultRule = false; // Ignora regras automáticas de atribuição de dono

        // Atribuímos as opções DML aos registros
        for (Contact c : contactsToInsert) {
            c.setOptions(dmlOptions);
        }

        // Inserimos usando o método Database.insert com as opções
        Database.insert(contactsToInsert, dmlOptions);
    }

    public void doInsertWithAccessLevel(){
        Account acc = new Account(Name = 'Test Account3');
        Database.SaveResult sr = Database.insert(acc, false, System.AccessLevel.SYSTEM_MODE);
    }

    // Database.update
    public void doUpdate(){
        Account acc = [SELECT Id, Name FROM Account LIMIT 1];
        acc.Name = 'Updated Account';
        Database.SaveResult sr = Database.insert(acc);
    }

    public void doUpdateWithAllOrNone(){
        Account acc = [SELECT Id, Name FROM Account LIMIT 1];
        acc.Name = 'Updated Account';
        Database.SaveResult sr = Database.insert(acc, false);
    }

    public void doUpdateWithAllOrOneAndDmlOptions(){
        Account acc = [SELECT Id, Name FROM Account LIMIT 1];
        acc.Name = 'Updated Account';

        // Criamos e configuramos as opções DML
        Database.DMLOptions dmlOptions = new Database.DMLOptions();
        dmlOptions.assignmentRuleHeader.useDefaultRule = false; // Ignora regras automáticas de atribuição de dono

        acc.setOptions(dmlOptions);

        // Inserimos usando o método Database.insert com as opções
        Database.update(acc, dmlOptions);
    }

    public void doUpdateWithAccessLevel(){
        Account acc = [SELECT Id, Name FROM Account LIMIT 1];
        acc.Name = 'Updated Account';
        Database.SaveResult sr = Database.update(acc, false, System.AccessLevel.SYSTEM_MODE);
    }

    // Database.delete
    public void doDelete(){
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Database.DeleteResult sr = Database.delete(acc);
    }

    public void doDeleteWithAllOrNone(){
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Database.DeleteResult sr = Database.delete(acc, false);
    }

    public void doDeleteWithAccessLevel(){
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Database.DeleteResult sr = Database.delete(acc, false, System.AccessLevel.SYSTEM_MODE);
    }

    // Database.merge
    public void doMerge(){
        Account acc1 = [SELECT Id FROM Account LIMIT 1];
        Account acc2 = [SELECT Id FROM Account WHERE Id != :acc1.Id LIMIT 1];
        Database.MergeResult mr = Database.merge(acc1, acc2);
    }

    public void doMergeWithAllOrNone(){
        Account acc1 = [SELECT Id FROM Account LIMIT 1];
        Account acc2 = [SELECT Id FROM Account WHERE Id != :acc1.Id LIMIT 1];
        Database.MergeResult mr = Database.merge(acc1, acc2, false);
    }

    public void doMergeWithAccessLevel(){
        Account acc1 = [SELECT Id FROM Account LIMIT 1];
        Account acc2 = [SELECT Id FROM Account WHERE Id != :acc1.Id LIMIT 1];
        Database.MergeResult mr = Database.merge(acc1, acc2, false, System.AccessLevel.SYSTEM_MODE);
    }

    // Database.savepoint
    public void doSavepoint(){
        Savepoint sp = Database.setSavepoint();
        Account acc = new Account(Name = 'Test Account');
        Database.insert(acc);
        Database.rollback(sp);
    }

    // Database.rollback
    public void doRollback(){
        Savepoint sp = Database.setSavepoint();
        Account acc = new Account(Name = 'Test Account');
        Database.insert(acc);
        Database.rollback(sp);
    }

    // Database.query
    public void doQuery(){
        String query = 'SELECT Id, Name FROM Account';
        List<Account> accounts = Database.query(query);
        System.debug(accounts);
    }
}