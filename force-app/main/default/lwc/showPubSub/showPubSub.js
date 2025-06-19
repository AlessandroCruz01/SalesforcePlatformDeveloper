import { LightningElement, track, wire } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader'
import pubSubLib from '@salesforce/resourceUrl/pubsub';
import { CurrentPageReference } from 'lightning/navigation'

export default class ShowPubSub extends LightningElement {
    @wire(CurrentPageReference) pageRef;
    @track variant;
    connectedCallback(){
        loadScript(this, pubSubLib)
            .then(() => {
                console.log('Success');

                window.pubsub.registerListener(
                    'selectedVariant',
                    this.handlerPubSubEvent,
                    this
                )

            }).catch(error  => {
                console.log('Error loading pubsub library: ', error);
                
            })
    }

    handlerPubSubEvent(event){
        this.variant = event.detail.variant;
        console.log('Received pubsub event with variant: ', this.variant);
    }
}