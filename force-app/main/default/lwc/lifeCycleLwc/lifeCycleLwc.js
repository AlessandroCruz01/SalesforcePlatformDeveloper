import { LightningElement } from 'lwc';

export default class LifeCycleLwc extends LightningElement {
    constructor(){
        super();
        console.log('Constructor called');
    }

    connectedCallback(){
        console.log('Connected Callback called');
    }
}