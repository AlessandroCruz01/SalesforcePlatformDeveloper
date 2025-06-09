import { LightningElement, track } from 'lwc';

export default class FatherCompCustomEvent extends LightningElement {
    @track msg;

    handleCustomEvent(event) {
        const textVal = event.detail;
        this.msg = `Received from child: ${textVal}`;
    }
}