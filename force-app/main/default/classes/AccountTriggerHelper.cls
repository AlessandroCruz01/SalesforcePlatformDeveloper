/**
 * @description       : Classe de Helper para o Trigger de Account
 * @last modified on  : 06-22-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class AccountTriggerHelper {
    public static void formatPhoneNumber(List<Account> newAccounts) {
        for (Account newAccount : newAccounts) {
            if (newAccount.Phone != null) {
                // Example formatting logic, adjust as needed
                newAccount.Phone = newAccount.Phone.replaceAll('[^\\d]', '');
                if (newAccount.Phone.length() == 10) {
                    newAccount.Phone = '(' + newAccount.Phone.substring(0, 3) + ') ' +
                                       newAccount.Phone.substring(3, 6) + '-' +
                                       newAccount.Phone.substring(6);
                }
            }
        }
    }
}