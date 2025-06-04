/**
 * @description       : Classe RestAPI
 * @last modified on  : 06-04-2025
 * @last modified by  : Alessandro Souza
**/
@RestResource(urlMapping='/accountAPI')
global with sharing class AccountAPI {
    @HttpGet
    global static String doGet() {
        return JSON.serialize([
            SELECT
                Id,
                Name,
                Phone
            FROM Account
            WHERE
                Phone != null
        ]);  
    }
}