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

- ### RestAPI
    *O [RestAPI](https://www.ibm.com/br-pt/think/topics/rest-apis) é o *Representational State Transfer API* que segue os princípios de design do estilo arquitetônico REST. REST é a abreviação de transferência de estado representacional e é um conjunto de regras e diretrizes sobre como você deve construir uma API web.*
    *Por padrão o Apex Rest API tem algumas Notations que fazem referência aos verbos do RestAPI e são usadas para declarar o tipo de método rest que está sendo disponibilizado para consumo externo:*
        - **`@RestResource(urlMapping='/Endpoint')`** - *Declara o endpoint que irá consumir desta classe.*
        - **`@HttpGet`** - *Busca Dados*
        - **`@HttpPost`** - *Insere Dados*
        - **`@HttpPut`** - *Altera Dados*
        - **`@HttpDelete`** - *Deleta Dados*
        - **`@HttpPatch`** - *Atualiza Dados*
    *Como exemplo, digamos que é necessário uma API para buscar todas as contas que tenham telefone celular do Salesforce, perceba, nas classes RestAPI, o modificador de acesso deve ser **obrigatoriamente** `Global`. Seguimos: * 

- ### Consumindo um Web Service
    *Para consumir um web service dentro do Salesforce através do apex, são usados três classes principais*:
        - **`http`** - *Responsável por fazer a requisição ao webService.*
        - **`httpRequest`** - *Responsável por montar a request, montando o body, setando.*
        - **`httpResponse`** - *Responsável por tratar as responses das requisições.*
    *Para usar os exemplos de uso de consumo de WebService através da api: https://docs.awesomeapi.com.br/api-de-moedas*.
    *Vamos seguir a regra de negócio para usar a api para buscar a cotação atual do dólar em relação ao real. Seguimos: [QuoteService.cls](../force-app/main/default/classes/QuoteService.cls)*

- ### Classes Wrapper
    *Algo muito interessante que devemos saber para as ocasiões de consumo de web Service, são as classes [Wrapper](https://www.apexhours.com/wrapper-class-in-salesforce/). Uma classe wrapper é uma classe com estrutura de dados ou um tipo de dado abstrato que contém diferentes objetos ou coleções de objetos como seus membros. Uma classe wrapper é um objeto personalizado definido por um programador, no qual ele define as propriedades da classe wrapper.*
    *Por exemplo:*
    ```java
    public class AccountWrapperDemo {
        public Account acc {get; set;}
        public Contact cont {get; set;}
        public Boolean isSelected {get; set;}
    }
    ```
    *O uso da classe Wrapper ajuda os desenvolvedores a organizar os dados em questão de forma eficiente, desde que os dados estejam devidamente aninhados. Vamos ver para que serve a classe Wrapper no Salesforce.*
    *Benefícios das classes Wrapper:*
        - *Agrupam dados diferentes: permitem juntar vários tipos de dados em uma só estrutura (ex: objeto + booleano de seleção).*
        - *Facilitam exibição em telas (Visualforce/LWC): ajudam a mostrar listas com checkboxes, botões etc.*
        - *Permitem lógica personalizada: você pode incluir métodos e regras dentro da wrapper.*
        - *Organizam melhor o código: deixam o código mais limpo e estruturado, facilitando a manutenção.*
        - *Facilitam o controle do estado dos dados: úteis para manter informações temporárias durante interações do usuário (como itens marcados).*