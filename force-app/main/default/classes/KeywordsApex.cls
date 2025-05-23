/**
 * @description       : Principais Keywords do Apex
 * @last modified on  : 05-23-2025
 * @last modified by  : Alessandro Souza
**/
public with sharing class KeywordsApex {
    // final
    private final String KEY = 'keywords';
    private final String KEYWORD = 'keyword';

    // this
    String thisKeyword;

    // transient
    transient String transientKeyword;

    public KeywordsApex(String thisKeyword) {
        // Constructor

        // this.KEY = 'new KEYwords'; // Gera error: Cannot assign to final variable

        this.thisKeyword = thisKeyword;
        System.debug('this.KEY: ' + this.thisKeyword);

        this.transientKeyword = 'transient keyword';
    }

    // This usado para referenciar o próprio construtor
    public KeywordsApex(){
        this('keyword usado no construtor');
    }

    public String getKeywordTransient() {
        System.debug('this.transient: ' + this.transientKeyword);
        return JSON.serialize(this.transientKeyword);
    }
}