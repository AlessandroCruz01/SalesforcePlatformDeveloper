/**
 * @description       : Helper class for Travel Account operations
 * @last modified on  : 06-22-2025
 * @last modified by  : Alessandro Souza
**/
public class TravelAccountHelper {

    @future(callout=true)
    public static void fillAddress(String Id){
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
        }
    }

    public void createOpportunities(List<Id> ids){

        List<Account> accounts = [SELECT Id, TargetCountry__c FROM Account where id in: ids];

        Map<String,String> priceBookNames = new Map<String,String>();

        for(Account acc: accounts){
            priceBookNames.put(acc.Id, acc.TargetCountry__c + ' PriceBook');
        }

        Map<String,Pricebook2> priceBooksMap = new Map<String, PriceBook2> ();

        List<Pricebook2> priceBooks = [SELECT Id
                                        , Name
                                        , (
                                            SELECT Id
                                                    , Product2Id
                                                    , Product2.Name
                                                    , ProductCode
                                                    , UnitPrice
                                            FROM PricebookEntries
                                            WHERE IsActive = true
                                        )
                                        FROM Pricebook2
                                        WHERE Name in: priceBookNames.values()
                                    ];
        for(Pricebook2 priceBook : priceBooks){
            priceBooksMap.put(priceBook.Name, priceBook);
        }
        
        List<Opportunity> opps = new List<Opportunity>();

        for (String accId : priceBookNames.keySet()) {
            
            String priceBookName = priceBookNames.get(accId);
            Pricebook2 priceBook = priceBooksMap.get(priceBookName);

            for (PricebookEntry entry : priceBook.PriceBookEntries) {

                Opportunity opp = new Opportunity(Name='Opp '+entry.Product2.Name
                                                , AccountId = accId
                                                , CloseDate = System.today().addDays(30)
                                                , StageName = 'Prospecting'
                                                , Pricebook2Id = pricebook.Id
                                            );
                opps.add(opp);
            }
            
        }

        insert opps;

        List<OpportunityLineItem> oppItems = new List<OpportunityLineItem>();

        for (Opportunity opp : opps) {
            
            String priceBookName = priceBookNames.get(opp.accountId);
            Pricebook2 priceBook = priceBooksMap.get(priceBookName);

            for (PricebookEntry entry : priceBook.PriceBookEntries) {

                if(opp.Name.contains(entry.Product2.Name)){
                    oppItems.add(new OpportunityLineItem(OpportunityId = opp.Id
                                                                    , UnitPrice = entry.UnitPrice
                                                                    , Product2Id = entry.Product2Id
                                                                    , Quantity = 1
                                                            )
                    );
                }
                
            }
            
        }

        insert oppItems;

    }

}