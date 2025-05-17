/**
 * @description       : Classe global System
 * @last modified on  : 05-16-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class SystemClass {
    // https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_system.htm#apex_System_System_enqueueJob
    public void doDebug(){
        // Exemplo com parâmetro de mensagem.
        System.debug('Debugging information');

        // Exemplo com parâmetro de mensagem e nível de log.
        System.debug(LoggingLevel.ERROR, 'Error message');
    }

    public void doCurrentPageReference(){
        System.debug('CurrentPageReference: ' + System.currentPageReference());
    }

    public void doNow(){
        System.debug('Now ' + System.now());
        System.debug('Date ' + System.today());
    }
}
