# Salesforce Platform Developer I Credential

***Developer Fundamentals - (23%)***
- **[Módulo: Noções básicas de Apex de .Net](https://trailhead.salesforce.com/pt-BR/content/learn/modules/apex_basics_dotnet?trailmix_creator_id=strailhead&trailmix_slug=prepare-for-your-salesforce-platform-developer-i-credential)**
----------
***Tipos de dados***
*O Apex é compatível com os dados que ja seriam esperados. Há tipos primitivo, como números inteiros, números decimais, data, data/hora, string ( cadeia de caracteres ) e boolean. Também há um tipo de dados ID, que é usado com qualquer identificador de registros válido da plataforma lightning com **18 Caracteres**, que é atribuído pelo sistema.*
*Os tipos de dados de **referência** funcionam do mesmo jeito, mas, no Apex, todas as variáveis são inicializadas como nulas por padrão.*
*Além dos primitivos, também há compatibilidade com os tipos de dados **sObject**, sejam genéricos, sejam específicos, como uma conta ou um contato. **Lembre-se: sObject é, simplesmente, um objeto do Salesforce**.*
*Além disso, um tipo de dados pode ser uma lista tipificada de valores ou **enums**.*
**Seguimos para o arquivo** [DataTypes.cls](./force-app/main/default/classes/DataTypes.cls)

***Collections / Coleções***
*O .NET trabalha com uma biblioteca de grandes coleções, com vários tipos e métodos de extensão. Porém o apex sem tem três coleções.*

***-[Listas:](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_list.htm#apex_System_List_deepClone)***
*Uma lista é uma coleção ordenada de elementos que funciona quase do mesmo jeito qeu uma matriz tradicional. No entanto, o Apex não oferece suporte a matrizes como coleções, apenas listas. Você pode entretanto usar o qe é conhecido como "**Notação de matriz**" para fazer referência a itens específicos em uma lista usando colchetes, [].*
*Vamos passar pelos principais métodos do List:*

    1 - add(listElement)
        Adds an element to the end of the list.
        # Sintaxe: public Void add(Object listElement)
        # Parâmetros:   * listElement - Elemento do mesmo tipo da lista;

    2 - add(index, listElement)
        Inserts an element into the list at the specified index position and shifts all subsequent elements one index position to the right.
        # Sintaxe: public Void add(Integer index, Object listElement)
        # Parâmetros:   * index - Número inteiro que faz referência ao indicie da Lista;
                        * listElement - Elemento do mesmo tipo da lista;
  
    3 - addAll(fromList)
        Adds all of the elements in the specified list to the list that calls the method. Both lists must be of the same type.
        # Sintaxe: public Void addAll(List fromList)
        # Parâmetros:   * fromList - Uma lista de elementos do tipo List;

    4 - addAll(fromSet)
        Add all of the elements in specified set to the list that calls the method. The set and the list must be of the same type.
        # Sintaxe: public Void addAll(Set fromSet)
        # Parâmetros:   * fromSet - Um conjunto de elementos do tipo "Set";

    5 - clear()
        Removes all elements from a list, consequently setting the list's length to zero.
        # Sintaxe: public Void clear()

    6 - clone()
        Makes a duplicate copy of a list.        
        # Sintaxe: public List<Object> clone()
        ## Important: No método de clone não e feito uma cópia total da lista raiz, em outras palavras, quando é declarada uma lista ela é armazenada em um espaço da memória. Esse espaço de memória tem uma referência a qual é armazenada pela variável, porém, quando o método clone é chamado, ele copia a referência da memória, ou seja, se na lista cópia, for alterado algum elemento da lista, será alterada em ambas as variáveis. Por exemplo, digamos que tenho uma lista "Lista1" de contas, faço um clone para uma segunda variável lista chamada "Lista2". Digamos que na "Lista2" acontecerá uma alteração em algum elemento, tanto a "Lista2" quanto a "Lista1" sofrerá alterações.

    7 - contains(listElement)
        Returns true if the list contains the specified element.
        # Sintaxe: public Boolean contains(Object listElement)
        # Parâmetros: Um elemento qualquer (Object);

    8 - deepClone(preserveId, preserveReadonlyTimestamps, preserveAutonumber)


 **Seguimos para o arquivo** [CollectionList.cls](./force-app/main/default/classes/CollectionList.cls)
    
