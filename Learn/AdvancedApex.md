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
        - *Agrupam dados diferentes: permitem juntar vários tipos de dados em uma só estrutura (ex: objeto + boolean de seleção).*
        - *Facilitam exibição em telas (Visualforce/LWC): ajudam a mostrar listas com checkboxes, botões etc.*
        - *Permitem lógica personalizada: você pode incluir métodos e regras dentro da wrapper.*
        - *Organizam melhor o código: deixam o código mais limpo e estruturado, facilitando a manutenção.*
        - *Facilitam o controle do estado dos dados: úteis para manter informações temporárias durante interações do usuário (como itens marcados).*

## Capítulo 02 - LWC
*O [LWC](https://developer.salesforce.com/docs/platform/lwc/overview) é um framework ou estrutura para a criação de interfaces de usuário modernas na web, aplicativos móveis e experiências digitais na plataforma Salesforce. Com o LWC, os desenvolvedores podem usar os padrões web do W3C para criar elementos HTML personalizados com JavaScript e HTML, aplicando conceitos fundamentais como modelos HTML e shadow DOM, enquanto trabalham perfeitamente com os dados do Salesforce. O LWC é compatível com versões anteriores dos componentes do Aura; eles podem coexistir e interoperar em uma página.*

- ### Por que o LWC veio pra substituir o Aura?
    *LWC (Lightning Web Components) é o framework moderno da Salesforce para criar interfaces usando JavaScript moderno e padrões da web. Ele veio para substituir o Aura que é mais antigo, mais lento, usa JavaScript antigo e é mais difícil de manter. O LWC é mais rápido, mais leve, mais fácil de escrever e usar.*

- ### Estrutura de um LWC 
    *Quando criamos um novo LWC temos por padrão alguns arquivos criados montando a sua estrutura padrão. Sendo eles:*
        - .js
        - .html
        - meta.xml
      - *Tendo ainda os opcionais*:
        - .css
        - others.js
    *Exemplo prático:*
    ```markdown
    /meuComponente/
        ├── meuComponente.html
        ├── meuComponente.js
        ├── meuComponente.js-meta.xml
    ```
    *Seguimos para o exemplo de estrutura padrão na pasta criada a partir do momento em que criamos o LWC: [HelloWordLWC](../force-app/main/default/lwc/helloWorldLWC/)*
        *Uma observação importante: **caso queira criar um CSS personalizado para este componente. É obrigatório que o arquivo.css tenha o mesmo nome da pasta, no exemplo acima, ficaria HelloWorldLWC.css*** 
    *Veremos a seguir cada um dos arquivos que são criados por padrão na criação de um novo LWC:*

    - **.html**: *Referente a parte visual, usa HTML comum com adição de uma sintaxe especial como veremos mais a frente. Porém no exemplo abaixo perceba que temos alguns `template`, `if:true` e `for:each`.*
        ```html
        <template>
            <lightning-card title="Contatos">
                <template for:each={contatos} for:item="contato">
                <p key={contato.Id}>{contato.Name}</p>
                </template>
            </lightning-card>
        </template>
        ```
    - **.js**: *Refere-se a parte lógica ou backend do LWC, por padrão, é um arquivo que define uma **classe** que estende **`LightningElement`** e tem algumas propriedades como o `@api`, `@track` e alguns decorators como o `@wire`*
        ```javascript
        import { LightningElement, api } from 'lwc';

        export default class MeuComponente extends LightningElement {
        @api titulo; // propriedade pública
        }
        ```
        - **`@api`**: *Torna uma propriedade pública, pode ser passada por outro componente (geralmente o pai)*
          - `@api nome; // visível para o componente pai`

        - **`@track`**: *Marca uma propriedade como **Reativa**, hoje em dia, propriedades simples já são reativas por padrão. Portanto o @track não é sempre necessário.*
          - `@track dados = []; // útil quando é um objeto ou array modificado diretamente`

        - **`@wire`**: *Decorator que liga a propriedade a uma **fonte de dados automática**, geralmente de uma chamada Apex.*
          - `@wire(pegarContas) contas;`
            *Também pode ser utilizada como método:*
          - ```javascript
                @wire(pegarContas)
                    carregarContas({ data, error }) {
                    if (data) {...}
                    else if (error) {...}
                }
          ```  
    - **js-meta.xml**: *Define se o componente é exposto ao App Builder, Flow, Etc.*
        ```xml
        <targets>
            <target>lightning__AppPage</target>
            <target>lightning__RecordPage</target>
            <target>lightning__HomePage</target>
        </targets>
        ```

- ### Shadow DOM
  - **DOM**: *A DOM (Document Object Model) é uma interface de programação que representa a estrutura de um documento HTML ou XML como um objeto de árvore. Ele permite que os programadores manipulem e modifiquem essa estrutura, bem como o conteúdo e o estilo do documento, utilizando JavaScript ou outras linguagens.*
  - **Shadow DOM**: *Shadow DOM é um padrão que encapsula a estrutura interna do modelo de objeto de documento (DOM) de um componente web. O encapsulamento do DOM permite que os desenvolvedores compartilhem um componente e o protejam de manipulações arbitrárias por HTML, CSS e JavaScript. A estrutura interna do DOM é chamada de árvore de sombra. A árvore de sombra afeta a maneira como você trabalha com CSS, eventos e o DOM.*

- ### Template If
    *Esta é a forma que o LWC tem para tratar de renderização condicional. Ou seja, se uma condição for **verdadeira** através do **`if:true`** renderiza algo, ou, se uma condição for **falsa** através do **`if:false`** renderiza outra.*
    *Vamos a um novo LWC chamado:* [templatesTrueFalse](../force-app/main/default/lwc/templatesTrueFalse/).
    *Lembrando que o código `if:true` ou `if:false` é usado no front ( HTML ), porém a condição vem do back, ou seja, do arquivo **.js***.