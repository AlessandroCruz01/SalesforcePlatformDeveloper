/**
 * @description       : Exemplo de Trigger
 * @last modified on  : 06-03-2025
 * @last modified by  : Alessandro Souza
**/
trigger ContactTrigger on Contact (before insert) {
    for(Contact c : (List<Contact>) Trigger.new){
        if(c.Phone == null){
            c.addError('Phone number is required.');
        }
    }
}