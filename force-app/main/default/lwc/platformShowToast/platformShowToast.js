import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { loadScript } from 'lightning/platformResourceLoader'
import pubSubLib from '@salesforce/resourceUrl/pubsub';
import { CurrentPageReference } from 'lightning/navigation'

export default class PlatformShowToast extends LightningElement {

    @api mode;
    @api buttonLabel;
    variant = 'info';

    variants = [
        {label: "Info", value: "info"},
        {label: "Error", value: "error"},
        {label: "Warning", value:  "warning"},
        {label: "Success", value: "success"}
    ]

    connectedCallback(){
        loadScript(this, pubSubLib)
            .then(() => {
                console.log('Success');
            }).catch(error  => {
                console.log('Error loading pubsub library: ', error);
                
            })
    }

    @wire(CurrentPageReference) pageRef;
    
    handlerVariantChanged(event){
        this.variant = event.detail.value;

        window.pubsub.fireEvent(this.pageRef, 'selectedVariant', {
            detail: {
                variant: this.variant
            }
        })
    }

    // disconnectedCallback(){
    //     window.pubsub.unregisterAllListeners(this);
    // }

    handlerModeChanged(event){
        this.mode = event.detail.value;
    }

    handlerToastEvent(event){
        const toast = new ShowToastEvent({
            title: 'Título do Toast',
            message: 'Mensagem do Toast',
            variant: this.variant,
            mode: this.mode
        })

        this.dispatchEvent(toast);
    }
}