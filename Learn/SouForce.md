# SouForce - Developer

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
  
- ### Todos os tipos de campos
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
    - Siga para o arquivo - [WhatIsObject.cls](../force-app/main/default/classes/WhatIsObject.cls)****
