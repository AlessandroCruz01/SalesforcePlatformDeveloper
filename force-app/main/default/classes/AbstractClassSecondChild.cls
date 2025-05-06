/**
 * @description       : Classe filha de uma classe abstrata
 * @last modified on  : 05-05-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class AbstractClassSecondChild extends AbstractClass {
    public AbstractClassSecondChild() {
        super(5);
    }

    public override List<String> getIngredients() {
        return new List<String>{'Vanilla', 'Chocolate', 'Strawberry'};
    }
}