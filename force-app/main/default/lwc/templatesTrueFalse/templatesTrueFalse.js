import { LightningElement } from 'lwc';

export default class TemplatesTrueFalse extends LightningElement {
    connectedCallback(){ // Lifecycle hook to run when the component is inserted into the DOM
        this.verdadeiro = true;
        this.falso = false;
    }
}