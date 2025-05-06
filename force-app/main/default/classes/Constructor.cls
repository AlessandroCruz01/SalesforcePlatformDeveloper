/**
 * @description       : Constructor
 * @last modified on  : 05-01-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class Constructor {
    
    private String Name;
    private Integer YearsOld;
    private String City;

    public Constructor(String name, Integer yearsOld, String city){
        this.City = city;
        this.Name = name;
        this.YearsOld = yearsOld;

        printPerson();
    }

    private void printPerson(){
        System.debug('Olá ' + this.Name + ', sei que você tem ' + this.YearsOld + ' anos. E mora na cidade de ' + this.City + ' - Construtor Executado.');
    }
}