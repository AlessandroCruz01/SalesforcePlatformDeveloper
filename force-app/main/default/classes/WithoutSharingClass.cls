/**
 * @description       : Without Sharing Class
 * @last modified on  : 05-01-2025
 * @last modified by  : Alessandro Souza
**/
public virtual without sharing class WithoutSharingClass {
    public WithoutSharingClass() {}

    public List<AggregateResult> getAllAccount(){
        return [SELECT Count(Id) FROM Account];
    }
}