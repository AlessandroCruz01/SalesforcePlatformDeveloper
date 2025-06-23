/**
 * @description       : Trigger Handler for Account
 * @last modified on  : 06-22-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class AccountTriggerHandler extends TriggerHandler {

    public override void beforeInsert() {

        for(Account newAccount : (List<Account>) Trigger.new) {
            if(newAccount.Phone == null){
                newAccount.addError('Phone number is required.');
            } else if (newAccount.Phone.length() < 11 ) {
                newAccount.addError('Phone number must be 10 digits.');
            } else {
                // Call the helper method to format the phone number
                AccountTriggerHelper.formatPhoneNumber(Trigger.new);
            }
        }
    }

    public override void afterInsert() {
        List<String> travelAccounts = new List<String>();

        for(Account acct : (List<Account>) Trigger.new){
            if(acct.RecordTypeId == Schema.SObjectType.Account.getRecordTypeInfosByName().get('Travel Detail').getRecordTypeId()) {
                travelAccounts.add(acct.Id);

                if(!System.isBatch() && !System.isFuture()) {
                    // Call the helper method to fill address asynchronously
                    TravelAccountHelper.fillAddress(acct.Id);
                }
            }
        }

        if(!System.isBatch() && !System.isFuture()) {
            (new TravelAccountHelper()).createOpportunities(travelAccounts);
        }

    }
}