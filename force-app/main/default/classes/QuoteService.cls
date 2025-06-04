/**
 * @description       : Classe para consumir Web Service
 * @last modified on  : 06-04-2025
 * @last modified by  : Alessandro Souza
**/

public with sharing class QuoteService {
    private final static String serviceUrl = 'https://economia.awesomeapi.com.br/json/daily/USD-BRL/1';

    public QuoteService() {
        HttpRequest request = new HttpRequest(); // * Instância do HttpRequest - Serve para montar a requisição
        request.setEndpoint(serviceUrl);
        request.setMethod('GET');

        Http http = new Http(); // * Instância do Http - Serve para enviar a requisição
        HttpResponse response = http.send(request); // * Envia a requisição e recebe a resposta
        String responseBody = response.getBody();

        System.debug(responseBody);

        List<QuoteWrapper> ex = (List<QuoteWrapper>)JSON.deserialize(responseBody, List<QuoteWrapper>.class);

        System.debug('InvoiceWrapper Response ' + ex);
    }

    class QuoteWrapper {
        public String code{get;set;}        // Código da Moeda
		public String codein{get;set;}      // Código da moeda
		public String name{get;set;}        // Nome da moeda
		public String high{get;set;}        // Maior valor do dia
		public String low{get;set;}         // Menor valor do dia
		public String varBid{get;set;}      // Variação monetária
		public String pctChange{get;set;}   // Percentual de Variação
		public String bid{get;set;}         // Valor de Compra
		public String ask{get;set;}         // Valor de Venda
		public String timestamp{get;set;}   // Data da Cotação em Timestamp
		public String create_date{get;set;} // Data da Cotação
    }
}