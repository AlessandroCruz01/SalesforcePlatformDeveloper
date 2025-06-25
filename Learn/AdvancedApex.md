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

- ### DOM & Shadow DOM
  - **DOM**: *A DOM (Document Object Model) é uma interface de programação que representa a estrutura de um documento HTML ou XML como um objeto de árvore. Ele permite que os programadores manipulem e modifiquem essa estrutura, bem como o conteúdo e o estilo do documento, utilizando JavaScript ou outras linguagens.*
  - **Shadow DOM**: *Shadow DOM é um padrão que encapsula a estrutura interna do modelo de objeto de documento (DOM) de um componente web. O encapsulamento do DOM permite que os desenvolvedores compartilhem um componente e o protejam de manipulações arbitrárias por HTML, CSS e JavaScript. A estrutura interna do DOM é chamada de árvore de sombra. A árvore de sombra afeta a maneira como você trabalha com CSS, eventos e o DOM.*

- ### JavaScript do LWC
    - **Por que a Salesforce criou um “JavaScript LWC”?**
        *Embora o LWC use o JavaScript Moderno (ES6+), ele roda dentro de uma **arquitetura controlada pela Salesforce** com algumas regras próprias:*
            - **Segurança**: *Proteger os dados e a DOM com isolamento entre componentes.*
            - **Performance**: *LWC usa o **Shadow DOM** como vimos acima, para encapsulamento e renderização mais rápida.*
            - **Padronização**: *Para garantir que o código funcione em todos os navegadores suportados e siga as políticas de segurança do Salesforce.*
            **🚫 Exemplo de limitação intencional**: ** Você não pode usar o `document.querySelector()` livremente para acessar o DOM global. Você só pode acessar sua própria DOM.
    
    - **Estrutura Básica do JavaScript em LWC:**
        ```javascript
        import { LightningElement, api, track, wire } from 'lwc';

        export default class MeuComponente extends LightningElement {
            // PROPRIEDADES
            @api titulo; // pública
            @track lista = []; // reativa (nem sempre necessário hoje)
            
            // MÉTODOS
            connectedCallback() {
                // executa quando o componente é inserido no DOM
            }

            handleClick() {
                alert('Você clicou!');
            }
        }
        ```
    - **Detalhamento do JavaScript do LWC**
      - **LWC e Web Components**
        *Como é percebido na estrutura acima, o controlador do LWC é criado totalmente baseado em POO. Isso acontece porque o LWC é totalmente baseado em **[Web Components](https://developer.mozilla.org/en-US/docs/Web/API/Web_components) (W3C)** e sua especificação oficial indica que **requer classes** para criar elementos customizados*:
        ```javascript
        class MeuComponente extends HTMLElement {
            connectedCallback() {
                this.innerHTML = '<p>Hello</p>';
            }
        }
        customElements.define('meu-componente', MeuComponente);
        ```
        *Ou seja, o uso do paradigma POO **não é uma escolha filosófica da Salesforce, e sim técnica**. O LWC, sendo compatível e baseado com **Web Components nativos**, precisa obedecer **obrigatoriamente** esse padrão.*

    - **Benefícios do uso da POO**
        *Em sistemas complexos como o Salesforce:*
            - *Um componente pode ter **estado**, **ciclo de vida**, **métodos públicos**, **eventos**, **acesso seguro a DOM**, **controle de acesso**, etc.*
            - O paradigma de classes permite **encapsular** tudo isso de forma elegante, organizada e herdável.
            - POO é mais explícita e estruturada em aplicações empresariais com componentes muito complexos, como as da Salesforce.

        *Façamos um comparativo entre POO e Funcional, para exemplificar os modelos funcionais, usaremos a biblioteca ReactJs, onde tem o uso do paradigma funcional muito forte:*
            - **Estado**: *POO: Propriedades na instância `this`* • *Func: `useState()` retorna tuplas*
            - **Ciclo de vida**: *POO: Métodos como `connectedCallback()` * • *Func: `useEffect()` com deps*
            - **Reutilização**: *POO: Herdar de `LightningElement`* • *Func: Criar custom hooks*
            - **Encapsulamento da DOM**: *POO: Via `this.template.querySelector()`* • *Func: Refs e JSX*
            - **Visibilidade**: *POO: `@api`, `@track`* • *Func: Props + lifting state*

    - **Porque extender o `LightningElement`?**
        *Basicamente, assim como no uso do ReactJs é necessário importar a biblioteca React para poder usar seus recursos, no LWC é necessário usar o extends na classe **LightningElement** que é a classe base criada pela própria Salesforce, que encapsula:*
            - *Métodos de ciclo de vida. Exemplo: `connectedCallback`*
            - *Manipulação de eventos. Exemplo: `dispatchEvent`*
            - *Acesso ao template ( `this.template.querySelector` )*
            - *Integração com segurança do **Locker Service**.*
            - *Integração automática com o DOM do Salesforce.*
          ⚠️ *Sem o `extends LightningElement` o componente não teria acesso a NADA. Seria só uma classe JavaScript comum.*
          ```javascript
            // 🔄 Aqui você importa o "DNA LWC"
            import { LightningElement } from 'lwc';

            // 🧬 Aqui você cria seu componente com esse DNA
            export default class MeuComponente extends LightningElement {
                // 👇 Você agora tem acesso aos recursos do LWC
                connectedCallback() {
                    console.log('Componente inserido no DOM');
                }
            }
          ```

- ### HTML do LWC
    - **Template `if:true` & `if:false`:**
        *Esta é a forma que o LWC tem para tratar de renderização condicional. Ou seja, se uma condição for **verdadeira** através do **`if:true`** renderiza algo, ou, se uma condição for **falsa** através do **`if:false`** renderiza outra.*
        *Lembrando que o código `if:true` ou `if:false` é usado no front ( HTML ), porém a condição vem do back, ou seja, do arquivo **.js***.
        *Vamos a um novo LWC chamado:* [templatesTrueFalse](../force-app/main/default/lwc/templatesTrueFalse/).

    - **Template `for:each`:**
        *O for:each é uma das maneiras de iterar em cima de uma lista. Para renderizar uma lista de itens, use `for:each` diretiva ou a iterator diretiva para iterar sobre um array. Adicione a diretiva a uma <template>tag aninhada que contenha os elementos HTML que você deseja repetir.*
        *O template for:each nos dá acesso a dois atributos muito importantes:*
            - **`for:each`**: *Recebe a lista de itens que deve ser percorrido*
            - **`for:item`**: *Indica qual o item que estamos iterando*
            - **`for:index`**: *Indica a posição do item que estamos iterando*
        *Vamos a um novo LWC chamado:* [forEachLwc](../force-app/main/default/lwc/forEachLwc/).

    - **Template `iterator`:**
        *O iterator é uma forma de trabalhar com listas um pouco mais complexo porém com mais poder de tratativa dos dados.*
            - **`iterator:<Nome Customizado>`**: *Aposta para a lista de itens*
            - **`value`**: *O valor do item na lista, Use esta propriedade para acessar os elementos dentro da lista.*
            - **`index`**: *O índice do item na lista.*
            - **`first`**: *Um valor boolean que indica se este item é o primeiro item na lista.*
            - **`last`**: *Um valor boolean que indica se este item é o último item na lista.*

- ### Annotations do LWC ( Decorators )
    *O modelo de programação do Lightning Web Components tem três **[decorators](https://developer.salesforce.com/docs/platform/lwc/guide/reference-decorators.html)** que adicionam funcionalidade a uma propriedade ou função. A capacidade de criar decorators faz parte do ECMAScript, mas esses três decorators são exclusivos do Lightning Web Components. Vamos conhecer cada um deles:*

    - **`@api`**: *Os atributos definidos com este decorator, são capazes de receber dados externos ou, melhor dizendo, expor esse atributo de forma pública. Geralmente são definidos pelo componente pai. O que é semelhante ao modificador de acesso `Public` do Apex. Este decorator faz muito sentido no contexto de relacionamento entre componentes.*
        *O **api** tem duas propriedades publica padrão que podem ser usadas em LWC **que são inseridas em paginas de registros do App Builder**, como em **Record Page**. Quando o LWC é inserido nessas páginas a Salesforce **automaticamente** injeta os valores em esses dois atributos:*
            - `@api recordId`: ID do registro atual (ex: conta, contato, etc.)
            - `@api objectApiName`: Nome do objeto (ex: Account, Contact)
            - `@api name`: Nome do componente (usado em flexipages)
    - **`@track`**: *Serve para tornar um atributo **reativo**, porém a partir do Spring '20, todos os campos em uma classe LWC são reativos. Se o valor de um campo mudar e o campo for usado em um modelo ou em um getter de uma propriedade usada em um modelo, o componente renderiza novamente e exibe o novo valor. Se um campo for atribuído a um objeto ou a uma matriz, o framework observa algumas alterações nos componentes internos do objeto ou da matriz, como quando você atribui um novo valor.*
    - **`@wire`**: *O decorator @wire permite que componentes Lightning Web Components (LWC) se conectem de forma reativa a dados do Salesforce, seja por meio de adaptadores de dados (como UI API) ou por métodos Apex. Ele é usado para **buscar** ou **manipular** dados no backend (Salesforce) de forma automática. Quando os dados retornados pelo @wire mudam, o componente é re-renderizado automaticamente.Para isso, basta aplicar o @wire na classe JavaScript do componente, especificando o adaptador de dados ou o método Apex desejado. Porém para que o `@wire` funcione junto com o Apex, existe uma dependência de outro decorator, no caso o:*
    - **`@AuraEnabled(cacheable=true)`**: *Basicamente o **[AuraEnabled](https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/controllers_server_apex_auraenabled_annotation.htm)** permite que os componentes do Lightning acessem métodos e propriedades do Apex. O @AuraEnabled pode receber alguns atributos, sendo eles:*
      - **`@AuraEnabled(cacheable=true)`**: *Servem para os métodos que retornam dados e **não fazem alterações no servidor**. Esse atributo permite armazenar em **cache** (cache client-side) os dados no [Lightning Data Service](https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/data_service.htm). Um ponto de atenção muito importante para esses tipos de métodos: **O método deve obrigatoriamente `static` e NÃO pode alterar dados**.*
      - **`@AuraEnabled(getter=true)`** / **`@AuraEnabled(setter=true)`**: *Usada em propriedades (**get** e **set**) que é desejado que seja exposta separadamente como leitura ou escrita.*
        - `getter=true`: expõe a propriedade para leitura no componente.
        - `setter=true`: expõe a propriedade para escrita.
        *Útil principalmente para classes **wrapper** ou quando queremos ter um controle maior sobre o que é lido ou escrito em objetos complexos.*
      - **`@AuraEnabled` (Sem atributos)**: *Serve para expor o método sem o uso de cache e com **acesso total**. Usado para métodos que **realizam ações** no servidor ( Inserts, Updates, Deletes ou Logicas dinâmicas ).*

- ### Events
    *Vamos focar agora no modo de conversa entre pai - filho, ou seja, vamos focar totalmente nos [events](https://www.apexhours.com/events-in-lightning-web-components-lwc/).*
    *Eventos são usados ​​no LWC para comunicação entre componentes. Normalmente, existem três abordagens para comunicação entre os componentes usando eventos.*
        *1 - Comunicação de eventos de pai para filho no componente web Lightning*
        *2 - Comunicação de eventos personalizados no componente Web Lightning ( filho para pai  )*
        *3 - Publicar modelo de assinante no Lightning Web Component ou  **[LMS - Lightning Message Service](https://www.apexhours.com/lightning-message-service-lms-messagechannel/)** ( dois componentes que não têm relação direta  )*

    **1 - Comunicação de eventos de pai para filho no componente web Lightning**:
        *Nos componentes LWC podemos ter essa relação de pai para o filho de duas formas:*
          - *Métodos Públicos.*
          - *Propriedades públicas.*
        *Como vimos anteriormente, para tornar um método ou uma propriedade pública, precisamos fazer uso do decorator `@api`.*

    - **Método Público**:
        Podemos usar o `@api` em um método para permitir que o componente pai o chame diretamente usando a API do JavaScript. Por exemplo, digamos que temos um método público (que precisamos acessar diretamente a partir do componente pai) podemos definir o método dentro do componente filho da seguinte forma:

            ```javascript
            @api
            changeMessage(strString){
                this.Message = strString.toUpperCase();
            }
            ```
        Tendo o método acima no componente filho, que precisa receber um parâmetro String, podemos chamá-lo da seguinte forma a partir do componente pai:

            ```javascript
            this.template.querySelector('c-child-component').changeMessage(event.target.value);
            ```
            
        Perceba que o método `querySelector()` é uma API DOM padrão que retorna o primeiro elemento que corresponde ao seletor.
        Tendo a parte teórica bem esclarecida vamos para o nosso projeto, vamos criar dois componentes LWC, um deles chamado basicamente como **childComp** e o outro como **fatherComp**, e vamos ver na prática como eles se interagem.

    - **Propriedades Públicas**
        *Podemos também definir um atributo público, onde, ele pode ser atribuído externamente, por exemplo, digamos que no componente **childComp** tenhamos um atributo chamado **itemName** para fazer a atribuição é necessário indicar o valor deste parâmetro no momento da declaração do componente, por exemplo: `<c-child-comp item-name="Milk"></c-child-comp>`, propriedades públicas são ótimas soluções para passar valores primitivos, objetos simples e matrizes.*
    
    **2- Comunicação de eventos de Filho para o Pai (Custom Events)**
        *Os **eventos personalizados (Custom Events)** é usado para fazer a comunicação do componente filho para o componente pai. Com o LWC, podemos criar e despachar o evento personalizado.*
        *1 - Criar e Despachar um evento*:
            - **Criar um evento**: *Podemos usar o construtor **`customEvent()`** para criar um evento. No construtor, precisamos passar o **nome** do evento personalizado e os **detalhes** do evento: `new customEvent(eventName, props);`.*
            - **Evento de despacho**: *Temos que despachar um evento com o método **`EventTarget.dispatchEvent(new customEvent(eventName, props));`.***
        *2 - Lidar com um Evento*:
            *Existem duas maneiras de ouvir um evento:*
            - **Declarativo via HTML**: *Precisamos adicionar o prefixo **`on`**+**nome do evento** no nome do evento no Componente pai durante a chamada do componente filho para o ouvinte de eventos Declarativos: `<c-child-component oneventName={listenerHandler}></c-child-component >`. No caso do método declarativo, existem algumas convenções que devem ser seguidas:*
              - *Sem letras maiúsculas*
              - *Sem espaços*
              - *Use sublinhado para separar palavras*
                **Componente Pai** - [fatherComp](../force-app/main/default/lwc/fatherComp/)
            - **JavaScript usando o método padrão `addEventListener`**: *Podemos anexar explicitamente um ouvinte de eventos usando o método `addEventListener` no componente pai como o exemplo a seguir: **`this.template.addEventListener('eventName', this.handleNotification.bind(this));`***
        **Como funciona a propagação de Eventos:** *Quando um evento é disparado, ele é propagado para a DOM. A propagação de eventos normalmente envolve duas fases: O **event bubbling** (borbulhamento de eventos) e o **event capturing** (captura de eventos). A fase mais comum usada para manipular eventos é o borbulhamento de eventos. Nesse caso, o evento é disparado no nível de **filho** e propagado para a DOM. Já a captura de eventos se move de cima para baixo na DOM. Essa fase raramente é utilizada para manipulação de eventos.*
        *No LWC temos duas sinalizações que determinam o comportamento do evento na fase de bolhas:*
            - **1. bubbles (Bolhas)**: *Um valor boolean que indica se o evento aparece ou não na DOM. O padrão é **false**.*
            - **2. composed (Composto)**: *Um valor boolean que indica se o evento pode atravessar o limite da sombra. O padrão é **false**.*
            ![eventos componente](https://www.apexhours.com/wp-content/uploads/2022/02/image-3-768x611.png)

    **3 - Comunicação entre componentes sem relação Publish Subscriber model**  
        *Para comunicar duas sub arvores no DOM (e em alguns casos entre janelas de navegadores diferentes conectadas a mesma organização), é usado o **[Lightning Message Service (LMS)](https://trailhead.salesforce.com/pt-BR/content/learn/projects/communicate-between-lightning-web-components/communicate-between-unrelated-components)**. O LMS é um serviço de publicação de assinatura que facilita as comunicações entre componentes LWC, Aura e VisualForce.*
        *O LMS é usado para comunicação entre componentes sem relação quando não é possível controlar dois componentes em um pai comum. O LMS é potente, eficaz e fácil de usar.*
        *ma terceira unidade de negócios quer participar do projeto de manipulação de números. Ela precisa que Prior Count (Contador anterior) e Count (Contador) estejam juntos em seu próprio componente para poder exibi-los sempre que precisar. Vamos começar criando o canal de mensagens para que fique pronto para uso pelos componentes.*
        **Criar um canal de mensagem (messageChannels)**
            - 1. No Visual Studio Code, na pasta default (padrão), crie uma pasta chamada **messageChannels**.
            - 2. Na pasta messageChannels, crie um arquivo chamado `Count_Updated.messageChannel-meta.xml`.
            - 3. **[Count_Updated.messageChannel-meta.xml](../force-app/main/default/messageChannels/Count_Updated.messageChannel-meta.xml)**
        **Criar um componente Publisher**
            - 1. Crie um componente Web do Lightning chamado **remoteControl**.
            - 2. Substitua o conteúdo de **remoteControl.js** pelo que é indicado na documentação.
            *Perceba que existem algumas importações neste código, essas importações vem do **Lightning Message Service**, no caso o **`publish`** e **`MessageContext`**. Também é feito o import do canal que acabamos de criar, neste caso o **`Count_Updated__c`**. O payload de dados é enviado através do `publish`.*
            - 3. [remoteControl](../force-app/main/default/lwc/remoteControl/)
        **Criar um componente Subscriber**
            - 1. Crie um componente Web do Lightning chamado `counts`.
            - 2. Substitua o conteúdo de **counts.js** pelo que é indicado na documentação.
            - 3. [counts](../force-app/main/default/lwc/counts/)
            - *A referência a @wire(MessageContext) faz com que unsubscribe seja executado durante o ciclo de vida de destruição do componente.*

- ### Ciclo de vida de um Componente
    *Neste momento veremos o ciclo de vida de um componente, onde, resumidamente temos:*
    - 1. **Constructor**
    - 2. **connectedCallback**
    - 3. **disconnectedCallback**
    - 4. **errorCallback(error, stack)**
    - 5. **rende**
    - 6. **renderedCallback**:

    *Para melhor entendimento do Ciclo de vida de um LWC, vamos para a **[documentação oficial](https://developer.salesforce.com/docs/platform/lwc/guide/create-lifecycle-hooks.html)***

    *Os componentes web do Lightning têm um ciclo de vida gerenciado pelo framework. O framework cria componentes, os insere no DOM, os renderiza e os remove do DOM. Ele também monitora os componentes em busca de alterações de propriedades.*

    *Este diagrama mostra o fluxo do ciclo de vida do componente, desde a criação até a renderização.*
    ![Ciclo de vida](https://a.sfdcstatic.com/developer-website/sfdocs/lwc/media/render.png)

    *Este diagrama mostra o que acontece quando uma instância de componente é removida do DOM.*
    ![Ciclo de vida removendo da DOM](https://a.sfdcstatic.com/developer-website/sfdocs/lwc/media/disconnect.png)

    *Tendo a visão ampla sobre como funciona o ciclo de vida de um componente, vamos entender melhor cada ponto que foi citado acima:*

    - **`constructor()`**: 
        *Método que é acionado quando uma instância de componente é criada. Ou seja, quando o novo componente é criado, ele faz um extends de `LightningElement`. Essa classe por sua vez, tem seu próprio constructor que deve ser executado assim que uma nova instancia é criada.*
        *Como citado acima, a classe de `LightningElement` tem seu próprio constructor, ou seja, caso estejamos criando um constructor dentro do componente, a primeira linha de código dentro deste, tem que ser obrigatoriamente um método `super()` para executar o constructor do `LightningElement` e evitar possíveis erros.*
        ```javascript
        import { LightningElement } from "lwc";
        export default class Deprecated extends LightningElement {
            constructor() {
                super();
            }
        }
        ```
        *O construtor flui do pai para o filho, o que significa que ele dispara primeiro no pai. Você não pode acessar os elementos filhos porque eles ainda não existem. As propriedades também não são passadas ainda. As propriedades são atribuídas ao componente após a construção e antes do **connectedCallback**.*
        *As ações dentro do constructor vão ser executadas antes do envio do componente para a DOM*
    
    - **`connectedCallback()`**: 
        *Nesta etapa o componente **já esta na DOM** e podemos usar o método `connectedCallback()` para interagir com o ambiente de um componente.*
        *Exemplos de uso:*
            - *Estabeleça comunicação com o documento ou contêiner atual e coordene o comportamento com o ambiente.*
            - *Executar tarefas de inicialização, como **buscar dados**, **configurar caches** ou **ouvir eventos**.*
            - *Inscrever-se ou cancelar a inscrição de um canal de mensagem (Para os casos de eventos através do LMS como vimos anteriormente).*
            - *Navegar para diferentes tipos de página, como registros e exibição de lista, usando o `lightning/navigation`.*
            - *Trabalhar com componentes Web de terceiros.*
        *O `connectedCallback()` é invocado com as propriedades iniciais passadas ao componente. É possível ser disparado **mais de uma vez**. Por exemplo, se você remover um elemento e depois inseri-lo em outra posição, como ao reordenar uma lista, o `connectedCallback()` será disparado várias vezes.*
    - **`errorCallback(error, stack)`**:
        *Nessa etapa este método pode ou não acontecer, basicamente ele captura erros que podem acontecer durante o ciclo de vida de um componente.*
    - **`render()`**:
        *O método `render()` serve para atualizar a interface do usuário. Você pode chama-lo antes ou depois do `connectedCallback()`.*
        *É muito raro definir o `render()` em um componente. O principal caso de uso é renderizar um modelo condicionalmente. É possível definir a lógica de negócio para decidir para qual modelo HTML usar*
    - **`renderedCallback()`**:
        *Usado para executar após a renderização de um componente. Este método flui do componente filho para o componente pai.*
        *Devemos ter cuidado ao usar o `renderedCallback()` pois, caso a lógica existente dentro dele, alterar o HTML, entrará em um loop infinito.*
    - **`disconnectedCallback()`**:
        *É o ultimo método do ciclo de vida que é acionado quando o componente é removido ou ocultado da DOM.*

- ### Platform Show Toast Event
    *Toasts inform users about the success or failure of actions, warnings, or other transient messages.*
    *Os [toasts](https://www.lightningdesignsystem.com/2e1ef8501/p/216f79-toast) servem para os feedbacks visuais para o UI.*
    ```javascript
        const toast = new ShowToastEvent({
            title: 'Título do Toast',
            message: 'Mensagem do Toast',
            variant: this.variant,
            mode: this.mode
        })

        this.dispatchEvent(toast);
    ```
    *Vamos passar por cada ponto do corpo da declaração do Toast:*
        - **title**: *O título do toast, aparece no header do container.*
        - **message**: *Uma string com a mensagem para o usuário.*
        - **messageData**: *Valores de URL e rótulo que substituem os marcadores de posição {index} na sequência de caracteres da mensagem.*
        - **variant**: *O tema e o ícone no toast. Os valores válidos são:*
          - **info**: *(default) Uma caixa cinza com ícone de informação.*
          - **success**: *Uma caixa verde com o ícone de marca de seleção.*
          - **warning**: *Uma caixa amarela com o ícone de aviso.*
          - **error**: *Uma caixa vermelha com ícone de erro.*
        - **mode**: *Determina a persistência do toast. Os valores válidos são:*
          - **dismissible**: *(default) Permanece visível até que o usuário clique no botão de fechar ou 3 segundos tenham decorrido. O que acontecer primeiro.*
          - **pester**: *Permanece visível por 3 segundos*
          - **sticky**: *Permanece visível até que o usuário clique no botão fechar.*

- ### Detalhes do XML do LWC
    *No LWC temos por padrão o arquivo **<Nome_do_Componente>.js-meta.xml** que basicamente serve como configs do componente. Ou seja, definimos se ele é exposto ou não e onde ele será exposto. Por exemplo, em um dos componentes que criamos temos o seguinte xml [platformShowToast.js-meta.xml](../force-app/main/default/lwc/platformShowToast/platformShowToast.js-meta.xml). Vejamos cada ponto deste arquivo:*
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <LightningComponentBundle xmlns="http://soap.sforce.com/2006/04/metadata">
        <apiVersion>63.0</apiVersion>
        <isExposed>true</isExposed>
        <targets>
            <target>lightning__AppPage</target>
            <target>lightning__RecordPage</target>
            <target>lightning__HomePage</target>
        </targets>
    </LightningComponentBundle>
    ```
    - **isExposed**: *Basicamente serve para indicar se o componente está habilitado para estar visível dentro do Salesforce*
    - **description**: *Serve para fazer uma descrição básica sobre o componente*
    - **masterLabel**: *O nome do componente*
    - **targets**: *Serve para especificar onde o componente está disponível. O `isExposed` sozinho não expõe o componente para os locais onde vamos utilizar.*
      - **target**: *O target é o local onde o Componente vai estar visível. Existem vários targets para cenários distintos. Por isso é necessário sempre dar uma olhada na documentação oficial: [Targets](https://developer.salesforce.com/docs/platform/lwc/guide/reference-configuration-tags.html).*
    *Existe também a possibilidade de adicionar um ícone SVG para nosso componente da seguinte forma:*
        - *Pegue a imagem SVG e adicione dentro da pasta do componente nomeado com o mesmo nome do componente.svg*
        - *Deploy para a SF*
        - *Em seguida é só olhar no componente que verá o ícone salvo.*

- ### Permitindo configurações no AppBuilder
    *É possível passar valores de atributos através do AppBuilder diretamente para uma **property** definido dentro do XML.*
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <LightningComponentBundle xmlns="http://soap.sforce.com/2006/04/metadata">
        <apiVersion>63.0</apiVersion>
        <isExposed>true</isExposed>
        <description>Platform Show Toast Component</description>
        <masterLabel>Platform Show Toast - SouForce</masterLabel>
        <targets>
            <target>lightning__AppPage</target>
            <target>lightning__RecordPage</target>
            <target>lightning__HomePage</target>
        </targets>

        <targetConfigs>
            <targetConfig targets="lightning__AppPage, lightning__RecordPage, lightning__HomePage">
                <property label="Modo do Toast" name="mode" default="dismissible" type="String"
                    datasource="dismissible, pester, sticky" />
                <property label="Rótulo do Botão" name="buttonLabel" default="Click" type="String" />
            </targetConfig>
        </targetConfigs>
    </LightningComponentBundle>
    ```

- ### Platform Resource Loader (External Libraries)
    *É possível importar tanto uma estilização CSS quanto um ScriptJS, verifiquemos a documentação: [lightning-platform-resource-loader](https://developer.salesforce.com/docs/component-library/bundle/lightning-platform-resource-loader/documentation)*
    ```javascript
    import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
    Promise.all([
        loadStyle(this, leaflet + '/leaflet.css') // Primeiro parâmetro sempre é this
        loadScript(this, leaflet + '/leaflet.js')
    ]).then(() => {
        // Carregado com sucesso
    })
    ```
    *Para os casos de import de css usa-se o **loadStyle** e para os casos de import de script usa-se o **loadScript**.*

- ### Comunicação entre componentes irmãos (PubSub)
    *Como indicamos anteriormente, existe o modo de comunicação entre componentes "irmãos", ou seja, que não tem relação, utilizando o MessageChannel, porém, existe um **workaround** (Solução alternativa) da própria Salesforce que é o **[PubSub](https://developer.salesforce.com/docs/platform/pub-sub-api/guide/intro.html)**. A API Pub/Sub fornece uma interface única para publicação e assinatura de eventos da plataforma, incluindo monitoramento de eventos em tempo real e captura de dados alterados*
    *O pubsub funciona a partir da lib externa: [PubSub](../force-app/main/default/staticresources/pubsub.js)*
    ![pubSub](https://i0.wp.com/www.pantherschools.com/wp-content/uploads/2020/05/image-25.png?fit=1024%2C578&ssl=1)

## Capítulo 03 - Apex Assíncrono
*Neste capítulo, vamos explorar o [Apex Assíncrono](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_async_overview.htm), que é utilizado quando precisamos que determinados processos ou automações sejam executados fora do fluxo principal, ou seja, de forma assíncrona. Esse tipo de abordagem é essencial para lidar com operações complexas, demoradas ou que exigem maior capacidade de processamento sem comprometer a experiência do usuário ou exceder limites de execução síncrona.*

- ### `@Future`:
    *Um método [future](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_invoking_future_methods.htm) é executado em segundo plano, de forma assíncrona. Você pode chamar um método future para executar operações de longa duração, como chamadas para serviços Web externos ou qualquer operação que você queira executar em sua própria thread, em seu próprio ritmo. Você também pode usar métodos future para isolar operações DML em diferentes tipos de sObject para evitar o erro de DML misto. Cada método future é enfileirado e executado quando os recursos do sistema ficam disponíveis. Dessa forma, a execução do seu código não precisa aguardar a conclusão de uma operação de longa duração. Uma vantagem de usar métodos future é que alguns limites do governador são maiores, como os limites de consulta SOQL e os limites de tamanho de heap.*
    ```java
        global class FutureClass
        {
            @future
            public static void myFutureMethod()
            {   
                // Perform some operations
            }
        }
    ```
    *O decorator `@future(callout=false)` tem o parâmetro opcional **callout** serve para indicar a permissão para chamadas externas. Ou seja, caso seja desejável fazer uma chamada API utilizando o @future, o callout precisa ser indicado como true. Por default o callout é assinalado como **false**.*
    *Apesar de ser uma ótima forma de usar contexto assíncrono, o @future tem algumas limitações:*
        - *Máximo de 50 chamadas @future por transação*
        - *Não pode chamar outro método assíncrono (@future, queueable, batch, schedulable)*
        - *Aceita apenas tipos primitivos como parâmetros:*
          - *Ex: `String`, `Integer`, `Boolean`, `Date`, `Id`, e listas desses tipos*
        - *Não aceita objetos SObject ou custom types como parâmetro*
        - *Roda com permissões de sistema (ignora sharing rules)*
        - *Único tipo de assíncrono que permite callout=true*
        - *Sem controle de encadeamento (não dá para fazer fila como no Queueable)*
        - *Como o @future roda de forma assíncrona, não existe a possibilidade de usar o **return** em um método assíncrono.*
    *Vamos usar o exemplo de @future em um contexto de chamada de API, no caso, consumindo da api pública, VIA CEP:* [Future.cls](../force-app/main/default/classes/Future.cls)

- ### `Queueable`:
    O [Queueable](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_queueing_jobs.htm) é a evolução do **@future**, com a interface Queueable é permitido adicionar tarefas à fila e monitorá-las. Usar a interface é uma maneira aprimorada de executar seu código Apex assíncrono em comparação com o uso de métodos futuros.
    ```java
        public class AsyncExecutionExample implements Queueable {
            public void execute(QueueableContext context) {
                Account a = new Account(Name='Acme',Phone='(415) 555-1212');
                insert a;        
            }
        }
    ```
    [QueueableInterface](../force-app/main/default/classes/QueueableInterface.cls)

- ### `Scheduled`:
    O apex [Scheduled](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_scheduler.htm) é um "agendador", um Apex utilizado para permitir uma execução em um horário específico. Ideal para tarefas de manutenções diárias ou semanais utilizando o Batch Apex.
    Para habilitar o agendamento, basta usar o implements com a interface **Schedulable**.
    ```java
        global class ScheduledMerge implements Schedulable {
            global void execute(SchedulableContext SC) {
                MergeNumbers M = new MergeNumbers(); 
            }
        }
    ```
    Em seguida fazer o agendamento a partir da UI ou usando o script usando o **[CronTriggerExpression](https://crontab.cronhub.io/)**:
    ```java
        ScheduledMerge m = new ScheduledMerge();
        String sch = '20 30 8 10 2 ?';
        String jobID = System.schedule('Merge Job', sch, m);    
    ```
- ### `Batch`:
    As batches ou lotes, servem para os casos em que precisamos tratar uma grande quantidade de registros. O uso de [Batch ](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_batch_interface.htm) resolve os problemas que temos na execução comum, por exemplo, limites de queries ou o limite de 200 mil registros que é o limite da SOQL, usamos as batches para processar esses registros em forma de lotes.
    ```java
        public (Database.QueryLocator | Iterable<sObject>) start(Database.BatchableContext bc) {}
    ```
    Algo muito interessante das batches é que cada **lote roda isoladamente**, ou seja,  em uma execução de 30 lotes com 200 registros (**podendo ir até 2mil**), caso haja uma falha, aquele lote de 200 é dado rollback em todo o lote e continua os seguintes.
    ```java
        public class SearchAndReplace implements Database.Batchable<sObject>{

            public final String Query;
            public final String Entity;
            public final String Field;
            public final String Value;

            public SearchAndReplace(String q, String e, String f, String v){

                Query=q; Entity=e; Field=f;Value=v;
            }

            public Database.QueryLocator start(Database.BatchableContext bc){
                return Database.getQueryLocator(query);
            }

            public void execute(Database.BatchableContext bc, List<sObject> scope){
                for(sobject s : scope){
                s.put(Field,Value); 
                }
                update scope;
                }

            public void finish(Database.BatchableContext bc){
            }
        }
    ```
    Após o método criado é necessário rodar o seguinte script para execução da batch:
    ```java
        ID batchprocessid = Database.executeBatch(reassign);

        AsyncApexJob aaj = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors 
                        FROM AsyncApexJob WHERE ID =: batchprocessid ];
    ```