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
        Makes a duplicate copy of a list of sObject records, including the sObject records themselves.
        # Sintaxe: public List<Object> deepClone(Boolean preserveId, Boolean preserveReadonlyTimestamps, Boolean preserveAutonumber)
        # Parâmetros:   * preserveId - Parâmetro boolean opcional que é marcado por padrão como "false". Esse parâmetro serve para indicar se o Id dos elementos da lista clonada vão ser preservadas, ou seja, quando marcada como "true" o Id será mantido na lista copiada.
                        * preserveReadonlyTimestamps - Parâmetro boolean opcional marcado por padrão como "false". Indica para que os campos read-only, por exemplo "CreatedDate" sejam preservados nos itens duplicados.
                        * preserveAutonumber - Parâmetro boolean opcional marcado por padrão como como "false". Que serve para indicar se os campos de numeração automática serão preservados.
    
    9 - equals(list2)
        Compares this list with the specified list and returns true if both lists are equal; otherwise, returns false.
        # Sintaxe: public Boolean equals(List list2)
        # Parâmetros:   * list2 - Parâmetro do tipo List obrigatório.

    10 - get(index)
        Returns the list element stored at the specified index
        # Sintaxe: public Object get(Integer index)
        # Parâmetros:   * index - Parâmetro do tipo inteiro que serve para referenciar uma indicie da lista e retorna o valor.

    11 - getSObjectType()
        Returns the token of the sObject type that makes up a list of sObjects.
        # Sintaxe: public Schema.SObjectType getSObjectType()

    12 - hashCode()
        Returns the hashcode corresponding to this list and its contents.
        # Sintaxe: public Integer hashCode()

    13 - indexOf(listElement)
        Returns the index of the first occurrence of the specified element in this list. If this list does not contain the element, returns -1.
        # Sintaxe: public Integer indexOf(Object listElement)
        # Parâmetros: Elemento Any que será buscado dentro da lista de destino.

    14 - isEmpty()
        Returns true if the list has zero elements.
        # Sintaxe: public Boolean isEmpty()

    15 - iterator()
        Returns an instance of an iterator for this list.
        # Sintaxe: public Iterator iterator()
        ## Important: From the returned iterator, you can use the iterable methods hasNext and next to iterate through the list. Você não precisa implementar o iterável interface para usar o iterável métodos 

    16 - remove(index)
        Removes the list element stored at the specified index, returning the element that was removed.
        # Sintaxe: public Object remove(Integer index)
        # Parâmetros:   * Index da lista para remover o elemento.

    17 - set(index, listElement)
        Sets the specified value for the element at the given index.
        # Sintaxe: public Void set(Integer index, Object listElement)
        # Parâmetros:   * index da lista para adicionar o elemento.
                        * listElement elemento para ser adicionado no indicie acima.
    
    18 - size()
        Returns the number of elements in the list.
        # Sintaxe: public Integer size()

    19 - sort()
        Sorts the items in the list in ascending order.
        # Sintaxe: public Void sort()

    20 - toString()
        Returns the string representation of the list.
        # Sintaxe: public String toString()

 **Seguimos para o arquivo** [CollectionList.cls](./force-app/main/default/classes/CollectionList.cls)

 ***-[Conjuntos (Set):](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_set.htm)***
*Um conjunto é uma coleção desordenada de elementos que NÃO contém dados duplicados. Um conjunto geralmente é utilizado para armazenar valores de Id, porque esses valores são sempre únicos. Então é comum o uso do SET como parte de uma cláusula WHERE de uma consulta SOQL. Veremos agora os principais métodos do SET, os quais vários acabam sendo iguais aos métodos da lista:*

    1 - add(setElement)
        Adds an element to the set if it is not already present.
        - public Boolean add(Object setElement)
        - Parâmetros:   * Elemento do tipo Object ( Any ) que ainda nao exista no conjunto;
    
    2 - addAll(fromList)
        Adds all of the elements in the specified list to the set if they are not already present.
        - public Boolean addAll(List<Object> fromList)
        - Parâmetros:   * Elemento do tipo List de elementos, será salvo apenas os itens que ainda nao existem no conjunto;

    3 - addAll(fromSet)
        Adds all of the elements in the specified set to the set that calls the method if they are not already present.
        - public Boolean addAll(Set<Object> fromSet)
        - Parâmetros:   * Elemento do tipo Set de elementos, será salvo apenas os itens que ainda não existem no conjunto;

    4 - clear()
        Removes all of the elements from the set.
        - public Void clear()

    5 - clone()
        Makes a duplicate copy of the set. No caso do Set, tem uma diferença com relação a List, onde aqui, de fato, são clonados todos os elementos independentes em outro espaço de memória. Ou seja, um não afeta o outro.
        - public Set<Object> clone()
    
    6 - contains(setElement)
        Returns true if the set contains the specified element.
        - public Boolean contains(Object setElement)
        - Parâmetros: Elemento qualquer (Object) para buscar dentro do Set;
    
    7 - containsAll(toCompare)
        Returns true if the set contains all of the elements in the specified list. The list must be of the same type as the set that calls the method.
        - public Boolean containsAll(List<Object> listToCompare)
        - Parâmetros: Elemento do Tipo List ou Set de elementos.
    
    8 - equals(set2)
        Compares this set with the specified set and returns true if both sets are equal; otherwise, returns false.
        - public Boolean equals(Set<Object> set2)
        - Parâmetros: Set de elementos

    9 - hashCode()
        Returns the hashcode corresponding to this set and its contents.
        - public Integer hashCode()

    10 - isEmpty()
        Returns true if the set has zero elements.
        - public Boolean isEmpty()
    
    11 - remove(setElement)
        Removes the specified element from the set if it is present.
        - public Boolean remove(Object setElement)
    
    12 - removeAll(offElementsToRemove)
        Removes the elements in the specified list from the set if they are present.
        - public Boolean removeAll(List<Object> listOfElementsToRemove)
        - Parâmetros: list de elementos ou Set de elementos.
    
    13 - retainAll(listOfElementsToRetain)
        Retains only the elements in the original set / list that are contained in the specified set.
        - public Boolean retainAll(List<Object> listOfElementsToRetain)

    14 - size()
        Returns the number of elements in the set (its cardinality).
        - public Integer size()

    15 - toString()
        Returns the string representation of the set.
        - public String toString()

 **Seguimos para o arquivo** [CollectionSet.cls](./force-app/main/default/classes/CollectionSet.cls)