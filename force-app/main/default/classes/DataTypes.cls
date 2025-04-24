public with sharing class DataTypes {
    public DataTypes() {
        // Variáveis
        String str = 'String Type'; // Cadeia de caracteres ou Texto.
        Boolean boo = true; //True or False.
        Integer itt = 123; //Número inteiro de 32bits.
        Long lon = 123123; //Número inteiro de 64bits.
        Decimal dec = 12.50; //Número com ponto flutuante (real) - com maior precisão no ponto flutuante, usado principalmente para operações financeiras.
        Double dou = 1232.323; //Número com ponto flutuante - com menor precisão no ponto flutuante, usado principalmente para operações cientificas.
        Blob blo = Blob.valueOf('123'); //Tipo de dado binário - base64
        Object obj =  'Any non-special type:  objeto'; //Objetivamente pode ser qualquer coisa dentro do SF - object pode ser utilizado para receber qualquer tipo de dado.
        Date dat = Date.today(); //Apenas Data.
        Datetime dtt = Datetime.now(); //Data e hora - Por padrão o SF salva com o GMT = 0, ou seja, sem timezone.
        Time tim = Time.newInstance(18, 30, 20, 20); //Hora
        Id id = null; //qualquer identificador de registros válido da plataforma lightning com 18 Caracteres.
    }

    // Além disso ainda temos o tipo de dados Enum
    public enum Season {WINTER, SPRING, SUMMER, FALL}
}