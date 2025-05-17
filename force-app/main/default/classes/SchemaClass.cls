/**
 * @description       : Classe global Schema
 * @last modified on  : 05-17-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class SchemaClass {
    // GetGlobalDescribe()
    public void doGetGlobalDescribe(){
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        System.debug('Global Describe: ' + gd);
    }

    // DescribeDataCategoryGroups(sObjectNames)
    // public void doDescribeDataCategoryGroups(){
    //     List<String> sObjectNames = new List<String>{'Account', 'Contact'};
    //     Map<String, Schema.DescribeDataCategoryGroup> dcg = Schema.describeDataCategoryGroups(sObjectNames);
    //     System.debug('Describe Data Category Groups: ' + dcg);
    // }

    // DescribeSObjects(sObjectTypes)
    // public void doDescribeSObjects(){
    //     Schema.DescribeSObjectResult[] descResult = Schema.describeSObjects(new String[]{'Account','Contact'});
    //     System.debug('Describe SObjects: ' + descResult);
    // }

    // Schema.SObjectField.getDescribe()
    public void doGetDescribe(){
        Schema.SObjectField field = Account.Name;
        Schema.DescribeFieldResult df = field.getDescribe();
        System.debug('Describe Field: ' + df);
    }
}