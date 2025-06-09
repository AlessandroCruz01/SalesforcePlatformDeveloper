import { api, LightningElement, track } from 'lwc';

export default class ChildComp extends LightningElement {

    @track Message;

    @api itemName;

    @api
    changeMessage(newMessage){
        this.Message = newMessage;
        console.log('Mensagem do pai', this.Message);
    }
}