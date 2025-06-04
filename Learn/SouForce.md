# SouForce - Developer

## Capítulo 00 - Ordem de execução do Salesforce
  ![Ordem de execução](https://ryanwingate.com/salesforce/other-projects-investigations/order-of-execution-graphic-from-salesforceben/order-of-execution-from-salesforceben.png)

  1. Pre-Validation:
    *Pre-validation (Before): Eventos como Before Insert, Before Update, Before Delete, são executados antes que o registro seja efetivamente alterado na base de dados. Isso permite a implementação de lógica de negócio que pode impedir uma operação antes que ela seja realizada. 
    Regras de validação: A Salesforce avalia as regras de validação antes de qualquer execução de código. Se uma regra de validação falhar, a operação é interrompida, e o usuário recebe uma mensagem de erro.*
  2. Execution:
    *Apex: A linguagem de programação Apex é usada para criar código customizado, como triggers, classes e funções. O código Apex pode ser executado dentro de eventos (antes ou depois) e também pode ser chamado diretamente.* 
    *Triggers: Os triggers são código Apex que é executado em resposta a eventos específicos de um objeto, como inserção, atualização, deleção, etc. Eles podem ser usados para executar lógica complexa, como atualizar outros registros, enviar e-mails, etc.* 
  3. Post-Validation:
    *Post-validation (After): Eventos como After Insert, After Update, After Delete, são executados após a operação de salvar ser concluída. Eles são úteis para tarefas que não podem ser interrompidas se o salvar falhar, como atualização de registros relacionados ou execução de tarefas em segundo plano. 
    Associação de campos: A Salesforce também pode executar lógica de validação no nível de campo individual.* 
  4. After Commit:
    *Depois do Commit: Este é o momento em que a transação é efetivamente concluída e a operação é escrita na base de dados. Algumas operações, como execução de processos em segundo plano, podem ser agendadas para serem executadas após o commit.* 

  ![Segundo exemplo](https://pbs.twimg.com/media/FT-VZ1jagAAD2Hb.jpg)

## Capítulo 01 - Além do Código
- ### Arquitetura Multi-Tenant
*A arquitetura Multi-Tenant é o equivalente a um condomínio com vários inquilinos no mesmo prédio. Essa analogia se refere aos servidores, onde temos várias ORGs no mesmo servidor.*
![Arquitetura Multi Tenant](https://res.cloudinary.com/hy4kyit2a/f_auto,fl_lossy,q_70/learn/modules/starting_force_com/starting_understanding_arch/images/pt-BR/42a9c0226fae35d3349c3402b399f47e_kix.iau1cgvb69op.jpg)

    Vantagens do Multi-tenant
    - Melhor Utilização dos recursos de Hardware;
    - Custo de Manutenção;
    - Atualizações com mais facilidades;

    Desvantagens do Multi-tenant
    - Alta complexidade;
    - Não permite isolar um único cliente;
    - Baixa flexibilidade ( Sempre deve-se ter cuidados para não afetar os outros clientes );

    Pontos de atenção
    - DML - Sempre montar as DMLs da melhor forma possível;
    - Queries - Limitações de Queries;
    - Performance;

## Capítulo 02 - Modelagem de dados (Admin)
- ### Introdução
    Modelagem de dados é uma forma de modelar a aparência das tabelas do banco de dados para poder ser entendida pelo ser humano. No Salesforce CRM, pensamos em *tabelas* como **objetos**, em *colunas* como **campos** e em *linhas* como **registros**
    O Salesforce dá suporte a vários tipos de objetos diferentes. Eles podem ser objetos **padrão**, **personalizados**, **externos**, **eventos de plataforma** e **BigObjects**.

- ### Introdução aos Objetos
    **Objetos Padrão** - São aqueles objetos que vêm incluídos no Salesforce. Objetos comerciais comuns, como **Conta**, **Contato**, **Lead** e **Oportunidade**, são todos objetos padrão.

    **Objetos Personalizados** - São objetos criados para armazenar informações específicas da sua empresa ou indústria.

- ### Introdução aos Campos
  Sempre há campos anexados a objetos padrões e personalizados. Seguem os diferentes tipos ( Obs: Estes campos são criados automaticamente para objetos personalizados, e já existem por padrão em objetos default ):

    - Tipo de campo **Identify / Identidade**: *Um campo de **quinze (15)** caracteres que **diferencia** maiúsculas de minúsculas, ou seja, é Camel Case, e é gerado de forma automática para cada registro. É possível encontrar um ID de algum registro em sua URL.*
      - Exemplo: *O Id de uma conta aparece da seguinte forma por exemplo: **001gK000003pStQQAU**. Onde, perceba que Id ao lado tem 18 caracteres e não somente 15 como indicado acima. Isso acontece por conta de um Checksum adicionado automaticamente pela SF que funciona para garantir a identificação do registro mesmo desconsiderando camel case. Para melhor entendimento de como funciona o Id podemos separar em blocos, da seguinte forma:*
        - **001**: *Prefixo = Tipo de Objeto, para conta sempre será 001 para esta ORG, cada objeto tem seu próprio prefixo.*
        - **gK000003pStQ**: *Id único deste registro dentro do objeto*
        - **QAU**: *Adicionado apenas para formar o Id de 18 Caracteres*
      - Observação: 
        - *A Salesforce criou o Id de 18 caracteres para garantir a segurança nas integrações. Se compar apenas o Id de 15 caracteres em sistemas que não são Camel Case, ou seja, sistemas que não conseguem diferenciar maiúsculos e minúsculos, existe o risco de conflito.*
        - *Existem ferramentas que convertem de 15 -> 18 e 18 -> 15 (Como fórmulas no Salesforce ou apps na AppExchange).*
  
    - Tipo de campo **Sistema / System**: *Campos ready only que fornecem informações sobre um registro do sistema, como a data de criação ou última alteração de um registro.*
      - Exemplo: *CreatedDate, LastModifiedById e LastModifiedByDate*.

    - Tipo de campo **Nome / Name**: *Todos os registros precisam de um nome, este campo é padrão e obrigatório tanto para objetos default quanto para objetos personalizados. E podem ter duas variações no caso de objetos personalizados. Onde podem ser um campo de texto ou auto number. Esse campo tem um limite  de **80 caracteres** e seu rótulo ( label ) é multilíngue, ou seja, tem tradução para outros idiomas. E se for auto number, não pode ser editado.*
  
    - Tipo de campo **Personalizado / Custom** - *Campos criados pelo admin para objetos padrão ou personalizados. Servem para armazenar informações personalizadas que não vem por padrão.*

  Outra informação importante sobre os campos são seus prefixos, ou seja, suas assinaturas, por exemplo, todos os objetos e campos personalizados, tem em seu nome de API **API Name** o prefixo ***__c***, que indica que é um objeto ou um campo ***Personalizado.***. Porém existem outros que são importantes serem conhecidos. Seguimos:

    - ***__c***: *Como já foi citado o **__c** serve para indicar tanto um campo personalizado, como um objeto personalizado.*
      - Exemplo: *FavoriteAnime__c*

    - ***__r***: *Serve para indicar que um campo é de relacionamento ( RelationShip ), este campo é usado nas consultas SOQL onde pode-se fazer uma busca relacionada no objeto. Este campo é associado aos campos de tipo **Lookup** ou **Master-Detail***
      - Exemplo: *Digamos que estou em um objeto personalizado Meta__c, dentro de Meta__c tem um campo de relacionamento com campo através do campo Conta__c. Na consulta SOQL quero resgatar informações desta conta relacionada ao objeto Meta__c, com o campo de relacionamento ficaria assim: SELECT id, **Conta__r.Name** FROM Meta__c*

    - ***__x***: *Serve para indicar Objetos Externos ( External Objects ), que são objetos conectados via Salesforce Connect. Ou seja, esses objetos não existem no Salesforce, são na verdade, objetos virtuais.*
      - Exemplo: *SAP_Orders__x*

    - ***__mdt***: *Custom Metadata Type, campos do tipo de metadados personalizados*
      - Exemplo: *Payment_Settings__mdt*

    - ***__e***: *Para indicar **Eventos de plataforma personalizados ( Platform Events )***
      - Exemplo:  *Order_Created__e*
  
    - ***__b***: *Para indicar os campos de objetos muito grandes ou **Big Objects***
      - Exemplo: *Archive_Log__b*

  Outros sufixos importantes são:
    - **History**:	Objeto de histórico de alterações (auditoria).
    - **Feed**:	Objeto de Chatter/feed relacionado ao objeto.
    - **Share**	Objeto de controle de compartilhamento manual.
    - **ChangeEvent**	Representação de evento de mudanças (CDC - Change Data Capture).
  
- ### Todos os tipos de campos (Admin)
  O Salesforce oferece uma variedade de tipos de campos com dados diferentes, vamos passar por todos eles para entender melhor cada um deles:

  ✨ *Campos automatizados:*
  - ***Formula***: *Campo somente leitura que deriva seu valor de uma fórmula definida por você. O campo de fórmula é atualizado quando qualquer um dos campos de origem é alterado.*
  - ***Numeração automática ( Auto Number )***: *Número sequencial gerado pelo sistema que usa o formato de exibição definido por você. Este número aumenta automaticamente a cada novo registro.*
  - ***Resumo de totalização ( Roll-Up Summary )***: *Campo somente leitura que exibe a soma, o valor mínimo ou máximo de um campo em uma lista relacionada ou o número de registros de todos os registros listados em uma lista relacionada. Obs: **Campo somente leitura que exibe a soma, o valor mínimo ou máximo de um campo em uma lista relacionada ou o número de registros de todos os registros listados em uma lista relacionada.***
  
  ✨ *Campos de relacionamento:*
  - ***Relacionamento de consulta externa ( External Lookup Relationship )***: *Cria um relacionamento que vincula este objeto a um objeto externo cujos dados são armazenados fora da organização do Salesforce.*
  - ***Relacionamento de pesquisa ( Lookup Relationship )***: *Cria um relacionamento que vincula este objeto a outro. No campo de relacionamento, os usuários podem clicar em um ícone de pesquisa para selecionar um valor de uma lista pop-up. O outro objeto é a origem dos valores na lista.*

  ✨ *Tipos de dados:*
  - ***Área de Texto rich text ( Text Area (Rich) )***: *Permitir que os usuários insiram um texto formatado, adicionem imagens e links. Até 131.072 caracteres em linhas separadas.*
  - ***Área de texto ( Text Area )***: *Permite que os usuários insiram até 255 caracteres em linhas separadas.*
  - ***Área de texto (longo) ( Text Area (Long) )***: *Permitir que os usuários insiram até 131.072 caracteres em linhas separadas.*
  - ***Caixa de seleção ( Checkbox )***: *Permite que os usuários selecionem um valor Verdadeiro (marcado) ou Falso (desmarcado).*
  - ***Data ( Date )***: *Permite que os usuários digitem ou selecionem uma data em um calendário pop-up.*
  - ***Data/Hora ( Date/Time )***: *Permite que os usuários insiram uma data e hora ou selecionem uma data em um calendário pop-up. Quando os usuários clicam em uma data no menu pop-up, a data e a hora atual são inseridas no campo Data/Hora.*
  - ***Email***: *Permite que os usuários insiram um endereço de email, que é validado para garantir o formato correto. Se este campo for especificado para um contato ou lead, os usuários podem escolher o endereço ao clicar em Enviar um email. Observe que endereços de email personalizados não podem ser usados para emails em massa*
  - ***Hora ( Time )***: *Permite aos usuários inserir um horário local. Por exemplo, "2:40 PM", "14:40", "14:40:00" e "14:40:50.600" são todos horários válidos para esse campo.*
  - ***Lista de opções ( Picklist )***: *Permite que os usuários selecionem um valor em uma lista definida por você.*
  - ***Lista de opções (seleção múltipla) ( Picklist (Multi-Select) )***: *Permite que os usuários selecionem vários valores de uma lista definida por você.*
  - ***Localização geográfica ( Geolocation )***: *Permite que os usuários definam localizações. Inclui componentes de latitude e longitude e pode ser usado para calcular distância.*
  - ***Moeda ( Currency )***: *Permite que os usuários insiram um valor em dólar ou em outra moeda, e formata automaticamente o campo como valor de moeda. Isso pode ser útil se você exportar dados para o Excel ou outra planilha*
  - ***Número***: *Permite que os usuários insiram qualquer número. Zeros iniciais são removidos.*
  - ***Porcentagem***: *Permite que os usuários insiram um número percentual, por exemplo '10', e adiciona automaticamente o sinal de porcentagem ao número.*
  - ***Telefone***: *Permite que os usuários insiram qualquer número de telefone. O número é automaticamente formatado como número de telefone.*
  - ***Texto***: *Permite que os usuários digitem qualquer combinação de letras e números.*
  - ***Texto (criptografado)***: *Permite que os usuários insiram qualquer combinação de letras e números e os armazenem em formato criptografado.*
  - ***URL***: *Permite que os usuários insiram qualquer endereço válido de site da Web. Quando os usuários clicam no campo, o URL é aberto em uma janela separada do navegador.*

- ### Relacionamento de Objetos
  Existe dois tipos principais de relacionamentos de objeto: *Pesquisa ( Lookup )* e *Mestre e Detalhes ( Mester Details )*.

  ***Relacionamento de Pesquisa***: Pensemos em um exemplo simples de relacionamento, no caso Conta para Contato. Um relacionamento de pesquisa basicamente vincula dois objetos para que seja possível "pesquisar" um dos objetos nos itens relacionados do outro objeto.
  O Relacionamento de pesquisa podem ser de *1-1* e *1-N*. No exemplo que citamos, uma conta pode ter vários contatos, ou seja, *1-N*.

  ***Relacionamento entre Mestre e Detalhes***: Os relacionamentos de pesquisa são bastantes casuais, já os **relacionamentos entre mestre e detalhes** são mais estritos. Nesse tipo de relacionamento, um objeto é o mestre e o outro, o detalhe. O Objeto mestre controla determinados comportamentos do objeto detalhe, por exemplo, quem pode ver os dados do detalhe.
  - Exemplo: *Suponha que o dono de uma propriedade deseja retirar seu imóvel do mercado. A empresa não desejaria manter as ofertas feitas pelo imóvel. Com um relacionamento entre mestre e detalhes entre Propriedades e Oferta, você pode excluir o imóvel e todas as ofertas associadas do sistema.*

  Normalmente, usa-se relacionamento de pesquisa quando os objetos só estão relacionados em algumas situações. ÁS vezes, o contato está associado a uma conta específica, mas, outras vezes, ele é apenas um contato. Os objetos nos relacionamentos de pesquisa funcionam como objetos independentes e têm suas guias próprias na interface do usuário.
  No Relacionamento de **Mestre e Detalhes**, o objeto detalhe não funciona independentemente. Ele depende bastante do mestre. Na verdade, se um registro mestre é excluído, todos os registros de detalhe também são excluídos.

  Existe ainda um terceiro tipo de relacionamento chamado *relacionamento hierárquico*. Os relacionamentos hierárquicos são um tipo especial de relacionamento de pesquisa. A principal diferença entre os dois é que os relacionamentos hierárquicos **somente estão disponíveis no objeto Usuário**. Você pode usá-los para criar cadeias de gerenciamento de usuários.

- ### Modelos de importação de dados
  - ***Data Import Wizard***: Ferramenta Default do Salesforce com certas limitações de objetos. A lista apresentada no momento da importação é basicamente tudo o que ele suporta.
  - ***Data loader UI***: O data loader é uma ferramenta de importação e exportação muito mais poderosa que o Data Import.
  - ***Inspector***: É uma extensão poderosa capaz de executar queries SOQL, imports, exports e muito mais.
  
## Capítulo 03 - POO com Apex
- ### O que é POO?
  - *A POO é mais muito mais que uum mero **paradigma** de programação, é uma filosofia que se infiltra na estrutura de cada software.*
    *Pense que estamos construindo um quebra-cabeças e, ao invés de peças aleatórias, cada peça é uma miniatura perfeitamente formada de uma parte do mundo real - um carro, uma casa, uma arvore... Essa é a essência da **Programação Orientada a Objetos (POO)**: uma maneira de programar que imita o mundo real.*
    *Na POO, cada "peça" do seu software é um objeto, um pacote autocontido de dados e os respectivos métodos responsáveis por manipular esses dados.*

  - ***Principais Fundamentos e paradigmas***: *Os pilares da POO incluem quatro conceitos-chave: **Encapsulamento**, **Herança**, **Abstração**, **Polimorfismo**. Vamos ver cada ponto e o que cada um significa:*
    - ***Encapsulamento***: *Protege os dados dentro de um objeto.*
    - ***Herança***: *É justamente através dela que um objeto herda as propriedades e métodos de outro, promovendo a reutilização de código e a criação de hierarquias de objetos.*
    - ***Abstração***: *Facilita a modelagem de objetos complexos ao expor apenas os detalhes relevantes e escondendo implementações específicas.*
    - ***Polimorfismo***: *Refere-se à capacidade de um método de assumir diferentes formas de comportamento, o que proporciona o tratamento de objetos de diferentes classes como objetos de uma classe.*

  - ***Benefícios da POO***: *A **Programação Orientada a Objetos** oferece uma série de benefícios e vantagens responsáveis por justificar seu reconhecimento e adoção em diversos setores da indústria de software:*
    - ***Reutilização de Código***: *A POO promove a reutilização de código de formas quue outros paradigmas não conseguem replicar ou igualar. Através do mecanismo de **herança**, por exemplo, novas classes criadas sobre as existentes, estendendo e customizando funcionalidades sem que o código existente precise ser reescrito.*
    - ***Modularidade***: *Cada POO é uma entidade autônoma com suas próprias propriedades e comportamentos.*
    - ***Colaboração Eficiente***: *Em grandes equipes, diferentes grupos podem trabalhar em módulos separados sem interferir no trabalho uns dos outros.*
  
  - ***Classes e objetos***: *As **classes** atuam como moldes para a criação de **objetos**, e cada classe define os atributos (propriedades) e comportamentos (métodos) que os objetos criados a partir dela possuirão.*

- ### Objetos, Modificadores, Apex Class e Sharing
  - ***O que é Orientação a objeto?***: *Um objeto é basicamente algo do mundo real com suas características, por exemplo: um carro. Um carro é um tipo de objeto, onde, cada carro tem suas características próprias, ou seja, tem uma cor, tem numero de portas, tem ano, modelo. No caso do mundo da programação, tornamos um objeto em uma classe, onde terá seus parâmetros (Atributos) e suas ações (Métodos), por exemplo, acelerar, frear. Toda classe tem um construtor que é basicamente o primeiro método chamado quando a classe é instanciada.*
    - ✨ *Siga para o arquivo - [WhatIsObject.cls](../force-app/main/default/classes/WhatIsObject.cls)*

  *Após o entendimento do que é um objeto e como é criada uma classe, seguimos para os demais pontos:*

  ![POO](https://dhg1h5j42swfq.cloudfront.net/2023/07/22122822/image-314.png)
  
  - ***Classes***:
    *uma classe é m plano, objetos são baseados em classes. Uma classe define um conjunto de características e comportamentos comuns a todos os objetos.*
    *Pense numa flor. Ela tem características, como: cor, altura e comportamentos, como: crescer e murchar.*
    *As classes são declaradas usando quatro partes: o **Modificador de acesso**, a palavra-chave **Class**, o nome da classe e o corpo da classe delimitado por **{}**.*
    ```java
    public class Flower {
      // Body of Class
    }
    ```
  - ***[Classes no Contexto do Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_defining.htm)***:
    *O Apex é uma linguagem de programação que usa sintaxe similar a do Java e funciona como procedimentos armazenados no banco de dados. O Apex permite que os desenvolvedores adicionem lógica de negócio a eventos de sistema, tais como cliques, botões, atualizações de registros.*
    *Assim como em Java, vocÇe pode criar classes no Apex. Uma classe é modelo ou projeto a partir do qual os objetos são criados. Um **objeto é uma instância da classe**.*

    ![Class](https://i.postimg.cc/CM7CDFsq/class-Struture.png)

    *Antes de seguirmos para os detalhamentos da estrutura da classe, vamos mostrar um exemplo de uma classe seguindo um objeto "Televisão", vamos para o arquivo:* ***[WhatIsClass.cls](../force-app/main/default/classes/WhatIsClass.cls)**.*

    ```java
    private | public | global // Modificador de Acesso
    [virtual | abstract] // Tipo da classe
    [with sharing | without sharing] // Regra de compartilhamento
    class ClassName [implements InterfaceNameList] [extends ClassName] 
    { 
    // The body of the class
    }
    ```

  - ***[Modificadores](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_access_modifiers.htm)***: *Um **modificador de acesso** é uma palavra-chave em uma declaração de método, atributo ou classe. O modificador de acesso determina qual outro código do apex pode ver e usar a classe ou o método. Seguimos para o detalhamento dos modificadores de acesso:*

    - ***Public***: *A classe, atributo ou método pode ser acessada de qualquer outra classe no mesmo namespace ou em namespaces diferente*
      - ✨ **[ClassPublic.cls](../force-app/main/default/classes/ClassPublic.cls)**

    - ***Private***: *A classe, atributo ou método só pode ser acessada por outras classes na mesma unidade de código (classe pai). Este modificador de acesso é o padrão e significa que o método ou variável é acessível apenas dentro da classe Apex na qual está definido. Se você não especificar um modificador de acesso, o método ou variável será **privado**. Também é importante citar que apenas a classe interna será definida como privada, já que a classe pai deve ser public.*
      - ✨ **[ClassPrivate.cls](../force-app/main/default/classes/ClassPrivate.cls)**

    - ***Global***: *A classe pode ser acessada de qualquer outro aplicativo no Salesforce ou por meio de chamadas RESTfull. Isso significa que o método ou variável pode ser usado por qualquer código Apex que tenha acesso à classe, não apenas o código Apex no mesmo aplicativo. Este modificador de acesso deve ser usado para qualquer método que precise ser referenciado fora do aplicativo, seja na API SOAP ou por outro código Apex. Se você declarar um método ou variável como **global**, você também deve declarar a classe que o contém como **global**. No caso da classe global pode ser definida na classe pai como global.*
      - ✨ **[ClassGlobal.cls](../force-app/main/default/classes/ClassGlobal.cls)**

    - ***Protected***: *A classe é acessível por outras classes na mesma unidade de código e por classes que estendem essa classe. Isso significa que o método ou variável é visível para quaisquer classes internas na classe Apex definidora e para as classes que estendem a classe Apex definidora. Você só pode usar este modificador de acesso para métodos de instância e variáveis ​​de membro. Esta configuração é estritamente mais permissiva do que a configuração padrão (privada), assim como em Java.*
      - ✨ **[ClassProtected.cls](../force-app/main/default/classes/ClassProtected.cls)**
      *Como entendemos, os métodos **protected** só podem ser acessíveis dentro da mesma unidade de código ou em classes que estendem essa classe. No caso temos o exemplo de uma classe filha que estende a classe criada acima:*
      ```java
      public class ClassProtectedChild extends ClassProtected {
        public ClassProtectedChild(){
          makeSound();
        }
      }
      ```
      *Perceba que já é possível chamar o método assinado como protected utilizando o extends.*
  
  - ***Tipos de Classes (Opcional)***: *Existem dois tipos de classes que tem propósitos diferentes das classes padrão. Sendo as classes **Virtual**, **Abstract** e **Interfaces**.*

  - ***[Sharing](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_bulk_sharing_creating_with_apex.htm)***: *O conceito de **"Sharing"** em classes do Apex do Salesforce refere-se ao controle de acesso ao dados em nível de código. Isso é particularmente importante em ambientes multiusuários, onde, diferentes usuários podem ter diferentes níveis de acesso aos dados. O Salesforce oferece três configurações de compartilhamento principais que podem ser aplicadas a classes do Apex, são respectivamente **"with sharing"**,**"without sharing"**,**"inherited sharing"**. Vejamos cada um deles:*

    - ***With Sharing***: *Este é o padrão quando uma classe nao declara o modificador de compartilhamento, no caso esta assinatura significa que o código **respeitará as configurações acesso de registros do Salesforce**, garantindo que o usuário que ativar a **trigger** e chamar esta classe, somente poderá acessar os dados os quais **tem permissão**.*
      - ✨ **[WithSharingClass.cls](../force-app/main/default/classes/WithSharingClass.cls)**

    - ***Without Sharing***: *Ao contrário do **With Sharing**, ao declarar uma classe com a assinatura **Without Sharing**, o código dentro dessa classe ignorará completamente as regras de compartilhamento do Salesforce a irá acessar todos os registros, independentemente das permissões do usuário que está executando o código.*
      - ✨ **[WithoutSharingClass.cls](../force-app/main/default/classes/WithoutSharingClass.cls)**

    - ***Inherited Sharing***: *Quando uma classe é declarada com essa assinatura, ela herda o compartilhamento da classe pai. Isso significa que se a classe pai for declarada com a assinatura **with sharing**, a classe filha herda a assinatura do pai.*
      - ✨ **[InheritedSharing.cls](../force-app/main/default/classes/InheritedSharingClass.cls)**

    - 🚦 ***Observação:***: *Existem ainda dois tipos de modificadores especiais, que veremos com mais detalhes mais a frente. No caso, as classes **Virtuais** e classes **Abstratas**.*
      - **Virtual**: *Declara que esta classe permite extensões e substituições. Você não pode substituir um método pela palavra-chave **Override**, a menos que a classe tenha sido definido como virtual.*
      - **Abstrata**: *Declara que esta classe contém métodos abstratos, ou seja, métodos que possuem **apenas** sua assinatura declarada e nenhum corpo definido.*

  - ***[Construtor](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_constructors.htm)***: *O construtor é o primeiro método invocado quando uma classe é instanciada, ou seja, quando um objeto é criado a partir do **blueprint** da classe. O construtor **pode ou não** ser declarado, quando uma classe é instanciada caso não haja um construtor declarado, o próprio apex cria um construtor público sem parâmetros e sem retorno. A sintaxe de um construtor é semelhante a um método, mas difere de uma definição de método pois não possui um tipo de retorno explícito e não é herdado pelo objeto criado a partir dele.*
    - ✨ **[Constructor.cls](../force-app/main/default/classes/Constructor.cls)**

  - ***[Métodos](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_defining_methods.htm)***: *Os métodos são definidos dentro de uma classe. Um método descreve os comportamentos herdados por objetos da classe. Uma classe pode ter um ou mais métodos. Voltando ao exemplo da flor, citada anteriormente, uma flor pode crescer (grow), Polinizar (pollinate), etc...*
    ![MethodStructure](https://i.postimg.cc/qv5GzrHT/Method.png)
  *Como indicado acima, um método tem a estrutura de **Modificador**, que vimos anteriormente, seguido pela palavra-chave opcional **static**, que torna o método possível de ser chamado a partir do operador ponto (.), seguido pelo tipo de retorno, o nome do método, em seguida entre () os parâmetros que podem ou não serem definidas, em seguida o corpo do método. Vejamos:*

    - ***Static***: *É utilizado para definir **variáveis**, **métodos** e **blocos de inicialização** de classe que pertencem à classe em sí, e não a uma instância especifica da classe (Um objeto). Isso significa que existe apenas uma cópia da variável ou método para toda a classe, independentemente de quantas instâncias da classe sejam criadas.*
      - ✨ **[StaticClass.cls](../force-app/main/default/classes/StaticClass.cls)**
      *No caso do **Método** quando definida como **static** significa que o método pertence á classe e não á instância. Ou seja, para ser executada, é necessário chamar a classe seguido . e o nome do método. `StaticClass.increaseCount();`.*
      *No caso de uma **Variável**, quando definida como **static** significa que a variável é **compartilhada** entre todas as instâncias da classe. Ou seja, é única para todas as instancias e todas apontam para o mesmo espaço de memória.*
      *No bloco de execução, um trecho de código é executado **automaticamente uma única vez quando a classe é carregada pela primeira vez** na execução do código. Ele executa uma única vez por transação.*

    - ***Retorno***: *Indica o tipo de retorno da classe. Quando indicado o tipo de retorno, a palavra-chave `return` se torna obrigatório a menos que o tipo de retorno seja `void`. Vejamos os tipos de retorno:* 
      - ***Void***: *Indica que o método não retorna nenhum valor. A palavra chave **Return** não precisa ser utilizada.*
      - ***Boolean***: *Retorna um valor true ou false*
      - ***Tipos primitivos***: *Retorna valores primitivos como **double**, **integer**,**long**, atc...*
      - ***Objetos Personalizados***: *Os métodos podem retornar instâncias de objetos personalizados definidos pelo usuário.*
      - ***Conjuntos de Elementos***: *Podem retornar **List**, **Set** ou **Map** de elementos.*
      - ***Registros Objetos Padrão***: *Podem retornar registros de objetos padrão ou personalizados.*
      - ***Enumeradores (Enums)***: *Pode retornar valores de um conjunto de valores Enums*
      - ***Instancias de Classes***: *Os métodos também podem retornar instancias de classes que podem encapsular dados e lógica.*
      - ***Tipos de Erro***: *Em casos onde um método pode falhar, ele pode retornar um tipo de erro personalizado.*
      ✨ **[MethodsReturnType.cls](../force-app/main/default/classes/MethodsReturnType.cls)**

      - ***Parâmetros***: *Um parâmetro é uma variável que serve como um espaço reservado na memória, esperando receber um valor. Esses parâmetros quando declarados pelo método, devem ser, obrigatoriamente repassados no momento em que o método é acionado. Lembrando que os métodos ficam dentro do corpo do método, ou seja entre as `{}`*
      ✨ **[MethodParams.cls](../force-app/main/default/classes/MethodParams.cls)**

- ### Interface, Virtual Class, Abstract Class
  - ***[Interface](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_interfaces.htm)***: *Uma interface é algo parecido com uma assinatura de contrato, ou seja, todas as classes que implementarem essa interface, são **Obrigatoriamente** impostas a aplicar esses métodos indicados pela interface. Normalmente uma interface é nomeada inicialmente com o I, ou seja, caso tenhamos uma interface de pagamento, o nome seria algo parecido com: IPayment. **Uma interface tem somente dois modificadores, sendo eles: Public ou Global** e sua sintaxe é um pouco diferente das classes convencionais:*

    ```java
    public interface IPayment{
      Decimal amount(Decimal value, Decimal valuePayment);
    }
    ```
    *Perceba também que uma interface por padrão não tem um construtor e os métodos são compostos **apenas** pela estrutura de **tipo de retorno**, **nome do método** e **parâmetros de entrada**. O responsável por implementar esses métodos é a classe que implementar essa interface. Vejamos o Exemplo na prática onde:* 
      - ✨ *Interface - [InterfaceClass.cls](../force-app/main/default/classes/InterfaceClass.cls)*
      - ✨ *Classe filha, que implementa a interface - [InterfaceChildClass.cls](../force-app/main/default/classes/InterfaceChildClass.cls)*

        - ***Obs sobre interface:***
        - **Não tem construtor**
        - **Não tem acesso a assinaturas de Sharing**
        - **Não implementa os métodos, apenas indica quais devem ser implementados**
        - **Perceba que as classes que implementam a interface, fazem uso da palavra-chave `implements`**
        - **Classes filhas podem ter seu construtor normalmente, porém, são Obrigados a implementar os métodos indicados na interface**
        - **A regra de negócio é definido pela filha, a Interface apenas obriga a existência daquele método, especificamente com o aquele retorno e aqueles atributos. O que será feito nas regras de negocio, nao interessa pra Interface**
        - **Como visto acima, uma mesma classe pode implementar mais de uma interface**
        - **Como uma interface apenas indica qual método deve ser implementado, é possível que existam diversas regras de negocio diferentes, se utilizando de uma mesma interface**
        - **O `override` é opcional, ou seja, reescrever aquele trecho de código é opcional.**

    - ***Métodos sem { e }***: *Como indicamos os métodos de uma interface não tem corpo, já que quem vai implementar as regras de negócio, são as filhas.*

    - ***Implements***: *O `implements` é a palavra reservada usada nas classes que implementam interfaces.*

  - ***Virtual Class***: *Uma virtual Class é semelhante a uma classe comum, porém com suas diferenças. No caso, uma classe virtual, permite que seus métodos sejam redefinidos.Esse tipo de classe **pode ou não** ter um construtor, e também pode ter assinatura de compartilhamento. Para este exemplo, vamos usar um objeto "Garrafa" para poder exemplificar o uso das classes virtuais. No caso das classes virtuais, os métodos das classes virtuais **tem obrigatoriamente que ser definido o corpo e regra de negócio**.*
    *Para este exemplo criamos 3 classes, a classe virtual e duas filhas:*
      - ✨ **[VirtualClass.cls](../force-app/main/default/classes/VirtualClass.cls)**
      - ✨ **[VirtualClassFirstChild.cls](../force-app/main/default/classes/VirtualClassFirstChild.cls)**
      - ✨ **[VirtualClassSecondChild.cls](../force-app/main/default/classes/VirtualClassSecondChild.cls)**
  
    - ***Extends***: *Serve para indicar que essa classe estende de uma classe virtual, ou seja, essa classe possui métodos que vem de uma classe virtual;*

    - ***Super***: *Serve para executar o construtor da classe virtual.*
  
    - ***Override***: *Serve para modificar uma classe que ja existe na classe virtual, ou seja, ele subscreve um método que já existe.*

    - ***Protected***: *O Atributo é acessível por outras classes na mesma unidade de código e por classes que estendem a classe a qual ele pertence.*

    - **OBS**:
      - *Os métodos devem ter corpo.*
      - *As classes filhas podem ou não utilizar esses métodos*
      - *As classes filhas podem ou não subscrever esses métodos*
      - *O método `super();` responsável por chamar o construtor da classe virtual pode ou não ser declarado*

  - ***Abstract Class***: *No Apex, uma classe abstrata é uma classe que **não pode ser instanciada diretamente** e que **serve como modelo base para outras classes**. Ela é usada quando você quer definir uma **estrutura comum**, mas deixar a implementação de certos métodos para as subclasses. Ela é ideal quando você tem um comportamento genérico que será especializado por outras classes. Para nosso exemplo, vamos pensar no objeto "Pizza".*

    - ***Métodos sem { e }***: *Assim como acontece nas interfaces, uma classe abstrata também pode determinar um "contrato" ou seja, métodos que sao definidos pela abstract mas que **devem** ser implementadas pelas classes que fizerem o extend da classe abstrata.*
    - ***Métodos Internos***: *Classes abstratas também podem ter métodos internos, que, diferente das classes virtuais, **nao podem** ser subscritas.*

        *Para este exemplo criamos 3 classes, a classe virtual e duas filhas:*
        - ✨ **[AbstractClass.cls](../force-app/main/default/classes/AbstractClass.cls)**
        - ✨ **[AbstractClassFirstChild.cls](../force-app/main/default/classes/AbstractClassFirstChild.cls)**

    - **OBS**:
      - *Os métodos podem ou não ter corpo.*
      - *As classes filhas podem ou não utilizar esses métodos.*
      - *As classes filhas não subscrever esses métodos.*
      - *As classes abstratas podem ou não utilizar a assinatura de compartilhamento*
      - *Essas classes não podem ser instanciadas, ou seja, não existe `new ` em uma classe abstrata.*
      - *Nas abstracts o `override` também é obrigatório, porém no contexto de implementação dos métodos indicados no abstract. Ou seja, caso haja um "contrato", a sub classe é **obrigada a reescrever aquele trecho de código, logo, usando o `override`***
      - *Caso a classe abstrata tenha um construtor, e esse construtor espere um atributo, o `super()` se torna **obrigatório**.*
  
  - ***Interface vs Abstract Class***
    - *Como vimos, uma interface tem alguns pontos muito parecidos com as classes abstratas, porém cada uma tem suas particularidades e motivos para uso:*

      - ***Interfaces***:
        - *As interfaces são usadas para obter abstração;*
        - *Projetado para oferecer suporte á solução dinâmica de métodos em tempo de execução;*
        - *Ajuda a conseguir um acoplamento solto;*
        - *Permite separar a definição de um método da hierarquia de herança;*

      - ***Classe abstrata***:
        - *As classes abstratas oferecem funcionalidades padrão para as subclasses;*
        - *Fornece um modelo para futuras classes específicas;*
        - *Ajuda a definir uma interface comum para suas subclasses;*
        - *A classe abstrata permite a reutilização de código;*
 
- ### Encapsulamento, Herança e Polimorfismo
  *Iremos agora rever todos estes conceitos, isso mesmo, **rever**. Pois todos os temas que passamos anteriormente era a aplicação destes conceitos na pratica. Vamos ver:*

  - ***Encapsulamento***: *Encapsulamento significa ocultar os detalhes internos de uma classe, expondo apenas o que for necessário através de métodos públicos (getters e setters). Isso protege os dados e melhora a segurança e manutenção do código. Ou seja, quando aprendemos sobre os **modificadores**, estávamos também aprendendo sobre o encapsulamento. Em resumo, o encapsulamento se resume no uso de **Public**, **Protected** e **Private**.*
    *Nós vimos esse tema na prática no exemplo da Pizza onde deixamos um dos atributos **private**, e também no exemplo da garrafa que deixamos o atributo **protected**. Ou seja, quem tinha uma instância da classe, não conseguia chegar ao atributo.*

  - ***Herança***: *Herança é o mecanismo que permite que uma classe herde comportamentos (métodos) e atributos (variáveis) de outra classe. Isso promove reutilização de código e extensibilidade, já que classes filhas podem:*
    - *Herdar código da classe pai*
    - *Adicionar novos comportamentos*
    - *Sobrescrever comportamentos existentes*
    *Ou seja, herança se trata no ato de estender uma classe e tem os seguintes detalhes:*
      - ***extends**: palavra-chave usada para herdar de outra classe*
      - ***virtual**: a classe ou método pai deve ser marcada como virtual para permitir herança/sobrescrita*
      - ***override**: indica que o método está sendo sobrescrito na classe filha*  

  - ***Polimorfismo***: *Polimorfismo significa "muitas formas". Em POO, é a capacidade de usar uma referência de classe base (pai) para apontar para objetos de classes derivadas (filhas) e executar o comportamento adequado dependendo da instância real. Vimos com mais detalhes o polimorfismo em ação no exemplo da Pizza, onde subscrevemos um método para que ele se encaixe na nossa necessidade.*
  
## Capítulo 04 - SOQL
- ### Entendendo o que é SOQL
  - ***[SOQL]([https://](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm))***
  
  *Salesforce Object Query Language - O SOQL é muito semelhante ao SQL com a principal diferença em que o **SOQL** está incorporado ao código Apex, ou seja, atrelado diretamente ao código para fazer chamadas no Bando de dados.*
  - ***Limites do SOQL***: 
    - **50.000 registros** retornados por consulta.
    - **100** consultas SOQL por transação síncrona (limite mais comum).
    - **200 consultas** SOQL por transação assíncrona (ex: batch Apex).
    - **35 relacionamentos** por consulta (quando se faz join com objetos relacionados).
    - **4 joins** por tipo de relacionamento (ex: 4 relacionamentos de tipo pai-filho).
    - **2.000 registros** exibidos no Developer Console por padrão (pode alterar).
    - **1 subquery por relacionamento filho** (cada subquery deve estar relacionada ao pai).
    - Não pode usar LIMIT diretamente em subqueries.
    - **100 mil caracteres** em uma string de consulta SOQL (o texto da consulta).
    - **20 mil caracteres** em filtros WHERE (para consultas dinâmicas).
    - SOQL não permite `SELECT *` – você deve listar os campos manualmente.
    - Não faz junção entre objetos não relacionados (sem lookup/master-detail).

    ![Limites do SOQL](https://i.postimg.cc/yN5BpBSy/Chat-GPT-Image-7-de-mai-de-2025-21-58-43.png)

  - ***Sintaxe do SOQL dentro do Apex***:
    ```java
    public class SOQL {
      public SOQL(){
        [ SELECT Id, Name FROM Account ];
      }
    }
    ```
  - ***[Métodos básicos do SOQL](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_select.htm)***:
    - **SELECT**: *Serve para buscar campos. - `SELECT fieldList [subquery][...]`* 
    - **FROM**: *Indica o Objeto de onde os campos serão extraídos.*
    - **WHERE**: *Filtra os registros com base nas condições.*
    - **ORDER BY**: *Ordena os resultados.*
    - **LIMIT**: *Limita o número de registros que devem ser retornados.*
    - **OFFSET**: *Pula um número específico de registros ( Ideal para paginação )*
    - **IN** / **NOT IN**: *Filtra valores dentro ou fora da lista.*
    - **LIKE**: *Busca padrões em campos de texto.*
    - **AND** / **OR**: *Combina muitas condições.*
    - **NOT**: *Inverte uma condição lógica.*
    - **GROUP BY**: *Agrupa os resultados por um campo ( Usados para funções agregadas ).*
    - **HAVING**: *Filtra os grupos após o **`GROUP BY`**.*
    - **ALL ROWS**: *Serve para buscar todos os registros mesmo os que foram deletados e estão na lixeira.*
    - **FOR UPDATE**: *Serve para travar o registro enquanto sofre a atualização.*
    - **FOR VIEW**: *Serve para **atualizar** objetos com informações sobre quando eles foram visualizados pela última vez (**LastViewedDate**).*
    - **FOR REFERENCE**: *Serve para notificar o Salesforce quando um registro é referenciado a partir de uma interface personalizada, como em um aplicativo móvel ou de uma página personalizada.*
    - **FORMAT()**: *This clause to apply localized formatting to standard and custom number, date, time, and currency fields.*
    - **toLabel()**: *Translate SOQL query results into the language of the user who submits the query using the toLabel function.*
  
  - ***Funções de Datas***:
    - **CALENDAR_MONTH()**: *Returns a number representing the calendar month of a date field.*
    - **CALENDAR_QUARTER()**: *Returns a number representing the calendar quarter of a date field.*
    - **CALENDAR_YEAR()**: *Returns a number representing the calendar year of a date field.*
    - **DAY_IN_MONTH()**: *Returns a number representing the day in the month of a date field.*
    - **DAY_IN_WEEK()**: *Returns a number representing the day of the week for a date field.*
    - **DAY_IN_YEAR()**: *Returns a number representing the day in the year for a date field.*
    - **DAY_ONLY()**: *Returns a date representing the date portion of a dateTime field.*
    - **FISCAL_MONTH()**: *Returns a number representing the fiscal month of a date field. This differs from CALENDAR_MONTH() if your organization uses a fiscal year that does not match the Gregorian calendar. This function is not supported if your organization has custom fiscal years enabled.*
    - **FISCAL_QUARTER()**: *Returns a number representing the fiscal quarter of a date field. This differs from CALENDAR_QUARTER() if your organization uses a fiscal year that does not match the Gregorian calendar. This function is not supported if your organization has custom fiscal years enabled.*
    - **FISCAL_YEAR()**: *Returns a number representing the fiscal year of a date field. This differs from CALENDAR_YEAR() if your organization uses a fiscal year that does not match the Gregorian calendar. This function is not supported if your organization has custom fiscal years enabled.*
    - **HOUR_IN_DAY()**: *Returns a number representing the hour in the day for a dateTime field.*
    - **WEEK_IN_MONTH()**: *Returns a number representing the week in the month for a date field.*
    - **WEEK_IN_YEAR()**: *Returns a number representing the week in the year for a date field.*

  - ***Funções Agregadas (Aggregate Functions)***:
    - **COUNT()**: *Retorna o número de registros.*
    - **COUNT_DISTINCT()**: *Conta valores únicos.*
    - **SUM()**: *Soma valores numéricos.*
    - **AVG()**: *Calcula média.*
    - **MIN()** / **MAX()**: *Encontra o maior valor e o menor.*
    - **GROUP BY ROLLUP**: *Cláusula opcional em uma consulta SOQL para adicionar subtotais para dados agregados nos resultados da consulta. Essa ação permite que a consulta calcule subtotais para que você não precise manter essa lógica no seu código.*
    - **GROUPING(fieldName)**: *função para determinar se uma linha é um subtotal ou campo é usado quando.*

  - ***Consultas de Relacionamentos***:
    - **Child-to-Parent (dot notation)**: `SELECT Account.Name FROM Contact`
    - **Parent-to-Child (subquery)**: `SELECT Name, (SELECT LastName FROM Contacts) FROM Account`

  - ***Consultas especiais para Knowledge__kav***:
    - **UPDATE TRACKING**: *Serve para gerar relatórios sobre pesquisas e visualizações de artigos (**Knowledge__kav**). Os desenvolvedores podem usar o UPDATE TRACKING para rastrear as palavras-chave usadas nas pesquisas de artigos do Salesforce Knowledge.*
    - **UPDATE VIEWSTAT**: *Você pode obter uma contagem de visualizações para cada artigo ao qual tem acesso online. Os desenvolvedores podem usar UPDATE VIEWSTAT para atualizar as estatísticas de visualização de um artigo.*

  *Seguimos para os exemplos práticos do que vimos acima:* ✨ *[SOQL.cls](../force-app/main/default/classes/SOQL.cls)*


- ### Entendendo o que é SOSL
  - ***[SOSL](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_sosl.htm)***
  
  *O Salesforce Object Search Language (SOSL) diferente do SOQL onde a busca é feita através de dados dos quais sabemos onde exatamente precisamos buscar o SOSL serve para os momentos em que **não sabemos exatamente onde o dado está**. Ou seja, eu sei o que quero, porém não sei onde está.*

  - ***Limites do SOSL***:
    - **Limite de registros retornados**: Máximo de 2.000 registros por consulta SOSL.
    - **Número de consultas por transação**: Até 20 consultas SOSL por transação Apex.
    - **Objetos pesquisados**: Máximo de 20 objetos diferentes por consulta.
    - **Campos retornados**: Apenas campos indexados são pesquisáveis no texto (ex: Name, Email).
    - **Tipos de campos**: Não é possível pesquisar em campos de tipo Long Text Area ou Rich Text Area.
    - **Ordem dos resultados**: Os resultados não são ordenados de forma garantida.
    - **Relacionamentos**: Não permite navegar em relacionamentos como o SOQL (Account.Name, por exemplo).
    - **Tradução e stemming**: Funcionalidades de busca podem ser limitadas em idiomas diferentes do inglês.

  - ***Sintaxe***:
    - `FIND 'SearchQuery' [IN SearchGroup] [RETURNING ObjectsAndFields]`
    - `FIND {Valor procurado} IN ALL FIELDS RETURNING Account(Id, Name, Type)` 
      - A busca deve ter mais que um caractere;
      - Suporta `Where` por exemplo: `FIND {Valor procurado} IN ALL FIELDS RETURNING Account(Id, Name, Type) WHERE Type = 'Customer - Channel'`

  - ***Sintaxe do SOSL dentro do apex***:
    ```java
    public class SOSL {
      public SOSL(){
        List<List<SObject>> searchList = [FIND 'SFDC' IN ALL FIELDS RETURNING Account(Name), Contact(FirstName,LastName)];
      }
    }
    ```

  - ***OBS***:
    - O SOSL sofre uma pequena diferença quando é usado dentro de um apex class e dentro do query editor:
      - **Query Editor**: `FIND {SearchQuery} [IN SearchGroup] [RETURNING ObjectsAndFields]`
      - **APEX**: `FIND {SearchQuery} [IN SearchGroup] [RETURNING ObjectsAndFields]`

  - ***Funções SOSL***
    - Existem caracteres **curinga** dentro do SOSL sendo eles:
      - [ ? ] - corresponde a apenas um caractere no meio ou no fim do termo de pesquisa.
      - [ * ] - corresponde a zero ou mais caracteres no meio ou no fim do termo de pesquisa.
    - O SOSL não diferenciam maiúsculas e minúsculas.
    - O escopo de campos a serem pesquisados é opcional, ou seja:
      - A query: `FIND {*uni*} IN ALL FIELDS RETURNING Account(Id, Name), Contact(Id, Name), Lead` pode ser escrita:
      - `FIND {*uni*} RETURNING Account(Id, Name), Contact(Id, Name), Lead` removendo o *"IN ALL FIELDS"*.
    - O escopo de pesquisa padrão é **all fields**, porém temos os seguintes métodos:
      - ***ALL FIELDS***: Todos os campos.
      - ***NAME FIELDS***: Campos de nome.
      - ***EMAIL FIELDS***: Campos de Email.
      - ***PHONE FIELDS***: Campos de telefone.
      - ***SIDEBAR FIELDS***: Campos de barra lateral.

  - *Seguimos para os exemplos práticos do que vimos acima:* ✨ *[SOSL.cls](../force-app/main/default/classes/SOSL.cls)*

- ### Entendendo o que é DML
  - ***[DML](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_dml_section.htm)***
  
  *O Data Manipulation Language ( DML ), serve para de fato manipular os dados dentro do Salesforce, o SOQL e SOSL servem para **resgatar e exibir os dados**, já o DML serve para **manipular os dados resgatados**, formando um CRUD do registro.*

   - ***Limites do DML***:
     - **Total de transações async ou sync**: 150
     - **Total de registros processados**: 10000
  
  - ***Transações DML***
    - **`Insert`**: *Serve para **inserir** um ou mais sObjects*
      - **Sintaxe**: `insert sObject` | `insert sObject[]`
    - **`Update`**: *Serve para **atualizar** um ou mais sObjects existentes*
      - **Sintaxe**: `update sObject` | `update sObject[]`
    - **`Upsert`**: *Serve para **criar e atualizar** um ou mais sObjects usando um campo específico para verificar sua existência ou o campo de Id, caso não exista, um novo registro será criado.*
      - **Sintaxe**: `upsert sObject​​[opt_field]` | `upsert sObject[]​​[opt_field]`
    - **`Delete`**: *Serve para **excluir** um ou mais sObjects existentes*
      - **Sintaxe**: `delete sObject` | `delete sObject[]`
    - **`Undelete `**: *Serve para **resgatar** um ou mais sObjects existentes na lixeira*
      - **Sintaxe**: `undelete sObject | ID` | `undelete sObject[] | ID[]`
    - **`Merge `**: *Serve para **mesclar até 3 registros do mesmo tipo** em apenas um dos registros, excluindo os outros e repaginando quaisquer registros relacionados*
      - **Sintaxe**: `merge sObject sObject` | `merge sObject sObject[]` | `merge sObject ID` | `merge sObject ID[]`
        - **Detalhes do Merge**: O primeiro parâmetro é sempre o registro mestre ou seja, o registro o qual o outros devem ser mesclados. O segundo parâmetro representa um ou dois registros que devem ser mesclados com o mestre e, em seguida, excluídos. Podendo ser passado por sObject único, Id ou uma lista de dois elementos.

  - *Seguimos para os exemplos práticos do que vimos acima:* ✨ *[DML.cls](../force-app/main/default/classes/DML.cls)*
  
## Capítulo Extra - Namespaces|Class globais
  *Antes de irmos para o próximo capítulo, vamos dar uma pausa e verificar algumas classes e namespaces padrão. Essas classes globais e namespaces possuem seus próprios métodos e utilidades  sendo os principais: **Database**, **Schema**, **System** entre outros. Seguimos:*

  - ### System Class
    - ***[System](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_system.htm)***
    - ***Os exemplos vão estar na classe: ✨ *[SystemClass.cls](../force-app/main/default/classes/SystemClass.cls)* ***

    *A classe **System** é uma das mais utilizadas e contém métodos para operações do sistema, como escrever mensagens de depuração e agendar tarefas. Observe a documentação pois existem vários métodos nessa classe global. Porém citaremos as mais utilizadas no dia a dia.*

    - **Debug - `System.debug`**: *Grava a mensagem especificada, em formato de string, no log de depuração de execução. O nível de log DEBUG é usado.*
      **Parâmetros**:
      - **`System.debug(msg);`**: ***msg** é um parâmetro do tipo String, por exemplo `System.debug('Hello World');`*
      - **`System.debug(logLevel, msg)`**: ***logLevel** é um parâmetro ENUM do tipo  [LoggingLevel](https://help.salesforce.com/s/articleView?id=platform.code_setting_debug_log_levels.htm&type=5) . Segue documentação dos tipos de logLevel. Exemplo de uso: `System.debug(LoggingLevel.Error, 'Hello World');`*
  
    - **CurrentPageReference - `System.PageReference()`**: *Retorna uma referência à página atual. Usado com páginas do Visualforce.*
      **Obs**:
        - **O pageReference também é um namespace padrão que será visto mais adiante. Podemos ver mais sobre essa classe na documentação: [PageReference](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_system_pagereference.htm)**
        - **Não tem necessidade de parâmetros.**
    
    - **Now / Today - `System.now()` | `System.today()`**: *Retorna o horário atual GMT e retorna a data atual*

  - ### Database Class
      - ***[Database](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_database.htm)***
      - **Os exemplos vão estar na classe: ✨ *[DatabaseClass.cls](../force-app/main/default/classes/DatabaseClass.cls)***

      *Classe com métodos estáticos usado para manipular dados de forma mais controlada do que os **DML** diretos como o **insert** ou **update**. Com o Database conseguimos ter um controle sobre uma DML com o adendo de **savepoints**, **partial success**, etc.*

      - **Database.insert(sObjects) | Database.update(sObjects) | Database.delete(sObjects)**: *Adiciona |Atualiza | Deleta um ou mais sObject, como uma conta ou contato individual, aos dados da sua organização.*
          **Parâmetros**: 
            - **sObjects - (List or Unique sObjects)** - *Pode ser adicionado um ou mais registros sObjects.*
            - **allOrNone - (Boolean)** - *Boolean é um parâmetro opcional que serve para indicar se essa DML aceita um sucesso parcial, por padrão vem setado como **true** o que indica que se o método não for bem-sucedido, uma exceção será lançada. Caso seja marcado como **false** e um registro falhar, o restante da operação DML ainda poderá ser bem sucedida. **allOrNone e dmlOptions não podem ser declaradas no mesmo método.***
            - **dmlOptions - (Database.DMLOptions)** - *O parâmetro opcional dmlOptions especifica dados adicionais para a transação, como informações de regras de atribuição ou comportamento de reversão quando ocorrem erros durante inserções de registros. **allOrNone e dmlOptions não podem ser declaradas no mesmo método.***
            - **accessLevel - (System.AccessLevel)** - *O parâmetro accessLevel especifica se o método é executado no modo de sistema `AccessLevel.SYSTEM_MODE` ou no modo de usuário `AccessLevel.USER_MODE`. No modo de **Sistema**: As permissões de objeto e de campo do usuário atual são ignoradas, e as regras de compartilhamento de registros são controladas pelas **assinaturas de compartilhamento** da classe. No modo de usuário, as permissões de objeto, a segurança em nível de campo e as regras de compartilhamento do usuário atual são aplicadas. O modo de sistema é o padrão. **O parâmetro de accessLevel pode ser atribuído junto do dmlOptions***

          **Retorno**:
            - **Database.SaveResult** - Ao utilizar um método com o **Database**, é retornado um [SaveResult]([https://](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_database_saveresult.htm)) que também é uma classe global.
      
      - **Database.setSavepoint()**: *Retorna uma variável de ponto de salvamento que pode ser armazenada como uma variável local e, em seguida, usada com o **rollback** método para restaurar o banco de dados até esse ponto.*
  
      - **Database.rollback(Savepoint)**: *Restaura o banco de dados para o estado especificado pela variável savepoint. Todos os e-mails enviados desde o último savepoint também são revertidos e não enviados.*

      - **Database.query(queryString)**: *Cria uma consulta SOQL dinâmica em tempo de execução.*

  - ### Schema Class
    - ***[Schema](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_schema.htm)***
    - **Os exemplos vão estar na classe: ✨ *[SchemaClass.cls](../force-app/main/default/classes/SchemaClass.cls)***

    *A classe global Schema é usado para metadados de modelo de dados ( Objetos, Campos, atc ). Os principal motivo para se utilizar a classe Schema era para a criação de código genérico e dinâmico.*

    - **GetGlobalDescribe - `Schema.getGlobalDescribe()`**: *Retorna um mapa de **todos os nomes de sObject** (keys) para tokens de sObject (values) para os objetos padrão e personalizados definidos na sua organização.*
    - **DescribeDataCategoryGroups - `Schema.getGlobalDescribe(sObjectNames)`**: *Retorna uma lista dos grupos de categorias associados aos objetos especificados.*
      - **Params**: *`List<String> sObjectNames`*
    - **DescribeSObjects - `Schema.describeSObjects(sObjectTypes)`**: *Descreve metadados (lista de campos e propriedades de objeto) para o sObject ou matriz de sObjects especificado.*
      - **Params**: *`List <String> sObjectTypes`*: *O argumento sObjectTypes é uma lista de nomes de tipos sObject que você deseja descrever.*
    - **SObjectField - `Schema.SObjectField`**: *Um objeto Schema.sObjectField é retornado do resultado de descrição do campo usando os métodos getController e getSObjectField.*

  *Temporariamente vamos ficar apenas nestas três classes globais e vamos seguir no estudo do Apex. Porém citaremos os próximos que veremos a seguir:*
    - **`Math`**: *Métodos matemáticos básicos.*
    - **`JSON`**: *Serialização e desserialização de dados JSON.*
    - **`Http`, `HttpRequest`, `HttpResponse`**: * Classes para chamadas externas (REST, SOAP)*
    - **`Crypto`**: *Métodos de criptografia e hashing.*
    - **`Messaging`**: *Envio de emails, notificações, etc.*
    - **`Test`**: *Namespace específico para testes em Apex.*
    - **`Limits`**: *Para ver consumo de recursos em tempo real.*
    - **`UserInfo`**: *Pega informações sobre o usuário atual.*
    - **`ApexPages`**: *Específico para Visualforce.*
    - **`EventBus`**: *Para publicar eventos de plataforma.*

## Capítulo 05 - Conceitos básicos do Apex
  *Tendo passado por alguns pontos básicos do apex, vamos seguir para um aprofundamento em algumas palavras chave ou **keywords** importantes para o uso diário do apex. Também veremos o tratamento de erros e os disparos de erros personalizados.*

  - ### `final`
    - [Final]([https://](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_keywords_final.htm))
    
    *A Keyword **final** serve para declarar um atributo que receberá um valor **uma única vez**, ou seja, uma vez que a variável for definida o valor dela não poderá mais ser alterada, ou seja, é uma variável **imutável**. Algo muito parecido ao **`const`** do JavaScript.*

    ```java
    public with sharing class KeywordFinal {
      private final String hello = 'Hello World';
      public KeywordFinal() {
        hello = 'Gera Erro'; //
      }
    }
    ```
  - ### `this`
    - [This]([https://](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_keywords_this.htm))

    *Existem duas maneiras de usar a keyword **this**:*

      - *O this pode ser usado em uma notação ponto, sem parênteses, para representar a instância atual da classe em que aparece, em resumo, o **this** acaba apontando para a minha própria classe. Use o **this** neste cenário para acessar variáveis e métodos de instância. No exemplo abaixo a classe myTestThis declara uma variável de instância **s**. O construtor por sua vez preenche esse atributo utilizando o **this**:*
        ```java
        public class myTestThis {
          string s;
            {
                this.s = 'TestString';
            }
        }
        ```

      - *Também é possível utilizar o **this** para fazer encadeamento de construtores, ou seja, em um construtor, chamar outro construtor. Neste exemplo o **this utilizar parênteses**. Quando se utiliza o **this** desta forma, ele **deve obrigatoriamente ser a primeira instrução no construtor**:*
        ```java
        public class testThis {
          // First constructor for the class. It requires a string parameter.
          public testThis(string s2) {
          }

          // Second constructor for the class. It does not require a parameter.
          // This constructor calls the first constructor using the this keyword.
          public testThis() {
              this('None');
          }
        }
        ```
  - ### `transient`
    - [Transient](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_keywords_transient.htm)

    *O **Transient** serve para ocultar um valor, onde o valor declarado dessa forma nunca poderá sair da classe, só pode ser visto pela própria classe. Ou seja, por mais que eu pegue uma variável do tipo **transient** e por exemplo mandar fazer um `JSON.Serialize()` esse parâmetro não será apresentado, pois ele **jamais** vai sair da classe.*
    ```java
    public transient Integer currentTotal;  
    ```
  - ### `super`
    - [Super](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_keywords_super.htm)

    *O super já foi citado anteriormente quando tratamos de heranças, onde ficou claro que o super é usado dentro de uma classe filha como forma de executar o construtor da classe pai.*

  - ### `instanceof`
    - [InstanceOf](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_keywords_instanceof.htm)

    *Se você precisar verificar em tempo de execução se um objeto é realmente uma instância de uma classe específica, use o **instanceof**. Essa keyword só pode ser usada para verificar se o tipo de destino na expressão à direita da keyword é uma alternativa viável para o tipo declarado da expressão à esquerda.*

    ```java
    if (Reports.get(0) instanceof CustomReport) {
    // Can safely cast it back to a custom report object
    CustomReport c = (CustomReport) Reports.get(0);
      } else {
      // Do something with the non-custom-report.
    }
    ```

    *Outro exemplo é usando o **instanceOf** no contexto de classes:*

    ```java
    public class BaseClass {}
    public class SubClass extends BaseClass {}

    List<SubClass> subClasses = new List<SubClass>();
    if(subClasses instanceof Iterable<BaseClass>) {
        //condition is always true since an instance of SubClass is always an instance of BaseClass
    }
    ```

    *Ou:*

    ```java
    Object o = null;
    Boolean result = o instanceof Account;
    System.assertEquals(false, result);
    ```
  - ### Revisão
    - *Todos os exemplos demonstrados acima, estão disponíveis em:* ✨ *[KeywordsApex.cls](../force-app/main/default/classes/KeywordsApex.cls)*

  - ### Tipos de Dados no Apex
    *Já passamos pelos tipos de dados e array no Readme. Nesse momento vamos apenas revisar cada tipo de dado do apex sem se aprofundar em cada um deles.*

    - **Variáveis e tipos de dados no Apex:**
      - *String*
      - *Boolean*
      - *Integer* - {32bits}
      - *Long* - {64bits}
      - *Decimal*
      - *Double*
      - *Blob*
      - *Object*
      - *Date*
      - *Datetime*
      - *Time*
      - *Enum*
      - *Id*
      
    - **Collections no Apex**
      - *Array*
      - *List*
      - *Set*
      - *Map*

