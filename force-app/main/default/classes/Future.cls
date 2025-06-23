/**
 * @description       : Class to handle future callouts for address retrieval
 * @last modified on  : 06-22-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class Future {
    @future(callout=true)
    public static void getAddress(String Id){
        Account acc =  [SELECT Id, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry FROM Account WHERE Id = :Id LIMIT 1];

        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://viacep.com.br/ws/' + acc.BillingPostalCode + '/json/');

        HttpResponse res = (new Http()).send(req);

        if(res.getStatusCode() == 200){
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());

            if(responseMap.containsKey('logradouro')){
                acc.BillingStreet = (String) responseMap.get('logradouro');
            }
            if(responseMap.containsKey('localidade')){
                acc.BillingCity = (String) responseMap.get('localidade');
            }
            if(responseMap.containsKey('uf')){
                acc.BillingState = (String) responseMap.get('uf');
            }
            if(responseMap.containsKey('cep')){
                acc.BillingPostalCode = (String) responseMap.get('cep');
            }
            acc.BillingCountry = 'Brazil';

            update acc;
            
        } else {
            throw new CalloutException('Failed to retrieve address: ' + res.getStatus());
        }
    }
}