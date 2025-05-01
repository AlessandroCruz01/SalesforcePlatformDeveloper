/*
    Uma classe é um plano. Objetos são baseados em classes. 
    Uma classe define um conjunto de características e comportamentos 
    que são comuns a todos os objetos dessa classe.
    Neste exemplo - Televisão
*/

// Declaração da classe
public with sharing class WhatIsClass {
    // Atributos
    private String brand{get;set;}
    private String size{get;set;}
    private Integer volume = 0;
    private Boolean power = false;

    // Construtor
    public WhatIsClass(String brand, String size) {
        this.brand = brand;
        this.size = size;
    }

    // Métodos
    public void setVolume(Integer volume) {
        this.volume = (volume <= 100 ? volume : 100);
    }

    public void setPower(Boolean power) {
        this.power = power;
    }

    public String getTv() {
        return 'Televisão ' + '\n' + 'Marca '+ this.brand + '\n' + 'Tamanho '+ this.size +' Polegadas '+ '\n' + 'Volume '+ this.volume + '\n' + 'Power '+ this.power;
    }
}