/**
 * @description       : Tipos de Retorno dos Métodos
 * @last modified on  : 05-01-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class MethodsReturnType {
    public String name{get;set;}
    public MethodsReturnType(String name) {    
        this.name = name;
    }

    // Void
    public void sayHello(){
        System.debug('Hello ' + this.name + '!!!!');
    }

    // Boolean
    public Boolean isEven(Integer num){
        return Math.mod(num, 2) == 0;
    }

    // Tipos Primitivos
    public Integer sum(Integer num){
        return num + 5;
    }

    // Objetos Personalizados
    // public CustomObject__c createCustomObject(){
    //     CustomObject__c obj = new CustomObject__c(Name = 'Example');
    //     insert obj;
    //     return obj;
    // }

    // List & Set
    public List<String> getNames(){
        List<String> names = new List<String>();
        names.add('Alice');
        names.add('Bob');
        names.add('Charlie');
        return names;
    }

    // Maps
    public Map<String, Integer> getFruits(){
        Map<String, Integer> fruits = new Map<String, Integer>();
        fruits.put('Apple', 10);
        fruits.put('Orange', 15);
        fruits.put('Grape', 20);
        return fruits;
    }

    // sObject
    public SObject getSObjectById(String objectType, Id recordId) {
        return Database.query('SELECT Id, Name FROM ' + objectType + ' WHERE Id = :recordId LIMIT 1');
    }

    // Enumeradores
    private enum Season {WINTER, SPRING, SUMMER, FALL}
    public Season getSeason(){
        return Season.SUMMER;
    }

    // Instância de Classe
    public MethodsReturnType getInstance(){
        return new MethodsReturnType('Instance');
    }

    // Tipos de Erro
    public class MyCustomException extends Exception {}
    public void throwError() {
        if (true) {
            throw new MyCustomException('Something went wrong.');
        }
    }
    
}