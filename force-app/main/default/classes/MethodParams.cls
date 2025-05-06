/**
 * @description       : Parâmetros dos métodos
 * @last modified on  : 05-03-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class MethodParams {
    // Atributos
    public String color{get;set;}
    private Integer year{get;set;}
    private String brand{get;set;}

    public MethodParams( String color, Integer year, String brand, String name ) {
        this.color = color;
        this.year = year;
        this.brand = brand; 

        sayHello(Name);
    }

    // Name é o parâmetro deste método:
    public void sayHello(String Name){
        System.debug('Hello ' + Name + ' ' + this.color + '!!!!');
    }
}