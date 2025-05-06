/**
 * @description       : Classe abstrata
 * @last modified on  : 05-05-2025
 * @last modified by  : Alessandro Souza
**/
public abstract class AbstractClass {
    private Integer numberOfFlavors;

    public AbstractClass(Integer numberOfFlavors) {
        this.numberOfFlavors = numberOfFlavors;
    }

    public abstract List<String> getIngredients();

    public void displayFlavors() {
        System.debug('Number of Flavors: ' + numberOfFlavors);
    }
    
}