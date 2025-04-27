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