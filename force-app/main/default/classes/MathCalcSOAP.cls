/**
 * @description       : Classe para consumo de serviço SOAP de cálculo.
 * @last modified on  : 06-04-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class MathCalcSOAP {
    public MathCalcSOAP() {
        calculator.CalculatorSoap calculatorSoap = new calculator.CalculatorSoap();

        Integer resultAdd = calculatorSoap.Add(5, 3);
        System.debug('Addition Result: ' + resultAdd);
    }
}