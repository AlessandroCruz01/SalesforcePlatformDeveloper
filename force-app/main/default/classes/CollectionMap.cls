public with sharing class CollectionMap {
    public CollectionMap() {
    // Map Constructors:

        // Map<T1,T2>() - Creates a new instance of the Map class. T1 is the data type of the keys and T2 is the data type of the values.
        Map<Integer, String> m1 = new Map<Integer, String>();
        m1.put(1, 'First');
        m1.put(2, 'Second');

        // Map<T1,T2>(mapToCopy) - Creates a new instance of the Map class and initializes it by copying the entries from the specified map. T1 is the data type of the keys and T2 is the data type of the values.
        Map<Integer, String> m2 = new Map<Integer, String>(m1);

        // Map<ID,sObject>(recordList) - Creates a new instance of the Map class and populates it with the passed-in list of sObject records. The keys are populated with the sObject IDs and the values are the sObjects.
        List<Account> accts = [SELECT Id, Name FROM Account LIMIT 5];
        Map<Id , Account> m3 = new Map<Id, Account>(accts);

    // Map Methods
        
        // clear()
        m1.clear();
        System.debug('map pós clear: ' + m1);

        // clone()
        Map<Id,Account> m4 = m3.clone();
        System.debug('Clone : ' + m3);
        System.debug('Clone : ' + m4);

        // containsKey(key)
        Boolean k = m2.containsKey(1);
        System.debug('Contains key? ' + k);

        // deepClone()
        Account a = new Account(
            Name='Acme', 
            BillingCity='New York'
        );

        Map<Integer, Account> m5 = new Map<Integer, Account> {};
        m5.put(1, a);
        Map<Integer, Account> m6 = m5.deepClone();
        m5.get(1).BillingCity = 'San Francisco';

        // equals(map2)
        Boolean isEqual = m5.equals(m6);
        System.debug('M5 equals M6? ' + isEqual);

        // get(key)
        Map<String, String> colorCodes = new Map<String, String>();
        colorCodes.put('Red', 'FF0000');
        colorCodes.put('Blue', '0000A0');
        String code = colorCodes.get('Blue');
        System.assertEquals('0000A0', code);
        String code2 = colorCodes.get('Magenta');
        System.assertEquals(null, code2);

        // getSObjectType()
        System.debug('getSObjectType: ' + m3.getSObjectType());

        // hashCode()
        System.debug('HashCode: ' + m3.hashCode());

        // isEmpty()
        System.debug('Map is empty? ' + m3.isEmpty());

        // keySet()
        Set<Integer> keys = m2.keySet();
        System.debug('KeySet: ' + keys);

        // put(key, value)
        colorCodes.put('White', 'FFFFFF');
        System.debug('Map depois de put: ' + colorCodes);

        // putAll(fromMap)
        Map<String, String> colorNames = new Map<String, String>();
        colorNames.putAll(colorCodes);

        // putAll(sobjectArray)
        List<Account> lAccts = new List<Account>();
        lAccts.add(new Account(Name='Account1'));
        lAccts.add(new Account(Name='Account2'));
        insert lAccts;
        Map<Id, Account> m = new Map<Id, Account>();
        m.putAll(lAccts);
        System.assertEquals(2, m.size());

        // remove(key)
        String removed = colorCodes.remove('Red');
        System.debug('Removed: ' + removed);

        // size()
        System.debug('Map size: ' + m.size());

        // toString()
        System.debug('toString: ' + m.toString());

        // values()
        List<String> values = colorCodes.values();
        System.debug('Values: ' + values);
    }
}