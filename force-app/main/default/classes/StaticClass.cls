/**
 * @description       : 
 * @last modified on  : 05-01-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class StaticClass {
    // Variável estática
    public static Integer count = 0;

    // Método estático
    public static void increaseCount(){
        count++;
    }

    public void getCount() {
        System.debug(count) ;
    }

    // Bloco de inicialização estática
    static {
        System.debug('Bloco de inicialização estático executado');
    }
}