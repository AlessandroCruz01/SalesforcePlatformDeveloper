public with sharing class CollectionSet {
    public CollectionSet() {
        Set<Id> accountIds = new Set<Id>{'001gK000003pStOQAU','001gK000003pStQQAU'};
        List<Account> accounts = [SELECT Name FROM Account WHERE Id IN :accountIds];


        // add(setElement)
        Set<String> myString = new Set<String>{'a', 'b', 'c'};
        Boolean result = myString.add('d');
        System.assertEquals(true, result);
        
        // addAll(fromList) & addAll(fromSet)
        Set<String> myString2 = new Set<String>{'a', 'b'};
        Set<String> sString = new Set<String>{'c'};

        Boolean result1 = myString2.addAll(sString);
        System.assertEquals(true, result1);

        // contains(setElement)
        Set<String> myString3 = new Set<String>{'a', 'b'};
        Boolean result2 = myString3.contains('z');
        System.assertEquals(false, result2);

        // containsAll(setToCompare)
        Set<String> myString4 = new Set<String>{'a', 'b'};
        Set<String> sString1 = new Set<String>{'c'};
        Set<String> rString2 = new Set<String>{'a', 'b', 'c'};

        Boolean result3, result4;
        result3 = myString4.addAll(sString);
        system.assertEquals(true, result3);

        result4 = myString4.containsAll(rString2);
        System.assertEquals(true, result4);

    }
}