/**
 * @description       : With Sharing Class
 * @last modified on  : 05-01-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class WithSharingClass {
    public WithSharingClass() {}

    public List<AggregateResult> getAllAccount(){
        return [SELECT Count(Id) FROM Account];
    }
}