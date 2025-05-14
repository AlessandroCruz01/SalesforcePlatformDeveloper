public with sharing class SOSL {
    public List<List<SObject>> search(String searchString) {
        List<List<SObject>> searchResults = [FIND :searchString IN ALL FIELDS RETURNING Account, Contact, Lead];

        return searchResults;
    }

    public List<Account> searchAccount(String searchString) {
        List<List<SObject>> searchResults = [FIND :searchString IN NAME FIELDS RETURNING Account, Contact, Lead];
    
        return (Account[])searchResults[0];
    }
}