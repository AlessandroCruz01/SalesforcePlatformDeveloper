import { LightningElement, api, track, wire } from 'lwc';
import getDado from '@salesforce/apex/lookupfieldController.getObjectDetails'

export default class CardTicketLwc extends LightningElement {
    @api recordId;
    @api objectApiName;
    @api name;

    @track hello;

    @wire(getDado, {ObjectName: '$objectApiName'})
    record;

    
    connectedCallback(){
        console.log(this.record);
        console.log(this.objectApiName)
        console.log(this.name)
        this.hello = 'Hello World';
        console.log(this.hello); // O this é obrigatório!
        console.log('Record ID:', this.recordId);
    }

    handleClick(event){
        this.hello = 'Hello World Updated';
    }
}