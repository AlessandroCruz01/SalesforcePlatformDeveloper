public with sharing class CollectionList {
    public CollectionList() {
        // Collection List
        String[] newArray = new List<String>{'String1', 'String2', 'String3', 'String5'};
        System.debug('New Array' + newArray);
        // - Apesar de ser possível ver arrays em apex, esse tipo propriamente dito não existe dentro do Sf, ou seja, não tem um construtor próprio. Apesar de ser possível receber parâmetros do tipo Array, por exemplo String[] o construtor de um Array no mundo Apex é o List;

        // Declaração de list simples
        List<String> myStrings = new List<String>();
        List<SObject> mysObjects = new List<SObject>();
        List<Boolean>  myBools = new List<Boolean>();
        List<Integer> myIntegers = new List<Integer>();
            // Perceba que é possível usando o construtor padrão "List" criar varias listas de diferentes tipos, sejam tipos primitivos ou, até mesmo, objetos do SF.

        //Existe outro modo de declaração de variável:
        Boolean[] listBools = new List<Boolean>();
        String[] listStr = new List<String>();
        Integer[] listInt = new List<Integer>{1,2,3,4};

        // List methods
         
            // public Void add(Object listElement)
            myIntegers.add(1); // Adicionando item a item no final da lista;
            System.debug('myIntegers.add(1) ' + myIntegers);

            // public Void addAll(List fromList) - public Void addAll(Set fromSet)
            myIntegers.addAll(listInt);  // Adicionando todos os elementos de uma lista de elementos;
            System.debug('myIntegers.addAll(listInt) ' + myIntegers);

            // public Void add(Integer index, Object listElement)
            myIntegers.add(4, 7); // Adiciona um elemento em um index específico e re-ordena todos os outros elementos para a direita.;
            System.debug('myIntegers.add(4, 7) ' + myIntegers);
        
            // public Void clear()
            myIntegers.clear(); // Remove todos os elementos da lista;
            System.debug('myIntegers.clear() ' + myIntegers);

            // public List<Object> clone()
            System.debug('Lista myIntegers Antes do Clone' + myIntegers);
            myIntegers = listInt.clone(); // Serve para clonar uma lista;
            System.debug('myIntegers = listInt.clone(); ' + myIntegers);

            // public Boolean contains(Object listElement)
            Boolean result = myIntegers.contains(1); // Serve para verificar se um elemento existe dentro de uma lista e retorna um boolean.
            System.debug('myIntegers.contains(1) ' + result);

            // public List<Object> deepClone(Boolean preserveId, Boolean preserveReadonlyTimestamps, Boolean preserveAutonumber)
            Account[] a1 = new Account[]{
                new Account(Name='acc1', BillingCity='Rio Branco'),
                new Account(Name='acc2')
            };

            Account[] a2 = a1.deepClone(); // Clona os registros de forma total.

            // public Boolean equals(List list2)
            Boolean isEqual = a1.equals(a2); // Serve para avaliar duas listas parar verificar se são iguais, retornando true ou false.
            System.debug('Lista a1 ' + a1);
            System.debug('Lista a2 ' + a2);
            System.debug('É igual? ' + isEqual);

            // public Object get(Integer index)
            System.debug(a1.get(0)); // Serve para retornar o valor do item no indicie.

            // public Schema.SObjectType getSObjectType()
            System.debug('SObjectType' + a1.getSObjectType()); // Retorna o SObjectType de uma lista.;

            // public Integer hashCode()
            System.debug('HashCode ' + a1.hashCode()); // Retorna o HashCode de uma lista.

            // public Integer indexOf(Object listElement)
            System.debug('IndexOf ' + listInt.indexOf(2)); // Retorna o primeiro index de um elemento.

            // public Boolean isEmpty()
            System.debug(listInt.isEmpty()); // Retorna true se a lista estiver vazia.

            // public Object remove(Integer index)
            listInt.remove(0);

            // public Void set(Integer index, Object listElement)
            listInt.set(0, 1); // Define o index informado com o elemento informado.;
            System.debug('listInt ' + listInt);

            // public Integer size()
            System.debug('Tamanho da lista ' + listInt.size());

            // public Void sort()
            listInt.sort();
            System.debug('Sort ' + listInt);

            // public String toString()
            System.debug('toString ' + listInt.toString());

    }

    // public Iterator iterator()
    public class CustomIterator implements Iterator<Account>{
        private List<Account> lAccount;
        private Integer currentIndex;

        public CustomIterator(List<Account> lAccount){
            this.lAccount = lAccount;
            this.currentIndex = 0;
        }

        public Boolean hasNext(){
            return currentIndex < lAccount.size();
        }

        public Account next(){
            if(currentIndex < lAccount.size()){
                return lAccount[currentIndex++];
            }else{
                throw new NoSuchElementException('Iterator has no more elements.');
            }
        }
    }
}