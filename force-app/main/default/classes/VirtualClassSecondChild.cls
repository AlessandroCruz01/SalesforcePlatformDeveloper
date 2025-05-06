/**
 * @description       : Classe filha de uma classe virtual
 * @last modified on  : 05-05-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class VirtualClassSecondChild extends VirtualClass {

    public override void setOpening() {
        this.bottleStatus = 'open';
        System.debug('Opening the bottle of type: ' + this.bottleType);
    }
}