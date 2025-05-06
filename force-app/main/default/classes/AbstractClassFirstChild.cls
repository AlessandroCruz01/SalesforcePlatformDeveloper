/**
 * @description       : Classe filha da classe abstrata
 * @last modified on  : 05-05-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class AbstractClassFirstChild extends AbstractClass {
    public AbstractClassFirstChild() {
        super(3);
    }

    public override List<String> getIngredients() {
        return new List<String>{'Vanilla', 'Chocolate', 'Strawberry'};
    }
}