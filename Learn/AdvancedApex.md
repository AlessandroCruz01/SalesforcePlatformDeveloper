# Apex Avançado

## Capítulo 01 - Integração usando o Apex
*Neste capítulo iremos passar pelas integrações utilizando o Apex, no caso as 3 formas principais que são as integrações **SOAP**, **RestAPI** e **WEB Service**.*

- ### SOAP
    *O SOAP é abreviação de Simple Object Access Protocol,e é um protocolo baseado em XML para troca de informações estruturadas entre plataformas decentralizadas e distribuídas. Em suma, usa-se o SOAP para plataformas mais antigas sem a opção do uso de RestAPI.*
    *Para o exemplo de SOAP vamos utilizar uma calculadora exposto em SOAP*: [Calculator](http://www.dneonline.com/calculator.asmx)
    *Para importar um SOAP api, basicamente é necessário salvar o arquivo xml com o cabeçalho e assinatura da API, em seguida, existe uma limitação do Salesforce onde não é possível usar dois binds ao mesmo tempo. Ou seja, no xml tem que haver **apenas** um bind `wsdl:binding`.*
    *No Salesforce em settings > Apex Class > Generate from WSDL, é necessário importar o xml baixado previamente o que por sua vez irá gerar duas classes voltadas ao SOAP.*
    *Ao exemplo do xml de calculator, gerou duas classes, sendo elas:*
        - [Calculator.cls](../force-app/main/default/classes/calculator.cls)
        - [AsyncCalculator.cls](../force-app/main/default/classes/AsyncCalculator.cls)
    *Para consumir essas classes seguiremos para:*
        - [MathCalcSOAP.cls](../force-app/main/default/classes/MathCalcSOAP.cls)