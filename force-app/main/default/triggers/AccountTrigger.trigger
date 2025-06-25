/**
 * @description       : This is a trigger for the Account object.
 * @last modified on  : 06-22-2025
 * @last modified by  : Alessandro Souza
**/
trigger AccountTrigger on Account (before insert, after insert) {
    new AccountTriggerHandler().run();
}