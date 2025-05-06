//* Vamos usar o exemplo do Carro como nosso objeto.
public with sharing class WhatIsObject {
    // Atributos
    public String color{get;set;}
    private Integer year{get;set;}
    private String brand{get;set;}
    private Integer km = 0;
    
    // Construtor
    public WhatIsObject(String color, Integer year, String brand) {
        this.color = color;
        this.brand = brand;
        this.year = year;
    }

    // Métodos
    public void setKm(Integer km){
        this.km = km;
    }

    public void getStatusCar(){
        System.debug('Veículo ' + this.brand + ' ' + this.color + ' do ano ' + this.year + ' de ' + this.km + ' km');
    }

    public void stop(){
        this.km = 0;
    }
}