/**
 * @description       : Classe que Implementa a Interface
 * @last modified on  : 05-03-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class InterfaceChildClass implements InterfaceClass,InterfaceClassSecondExample {
    // Na classe que implementa, o construtor é opcional.
    public InterfaceChildClass() { }

    public Decimal payment(Decimal amount, Decimal pay) {
        // Toda a regra de negócio
        return amount - pay;
    }

    public String sayHello(String Name){
        return 'Hello ' + name + '!!!!';
    }


}