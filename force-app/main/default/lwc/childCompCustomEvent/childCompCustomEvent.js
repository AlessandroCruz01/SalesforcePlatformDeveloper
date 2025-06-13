import { LightningElement } from 'lwc';

export default class ChildCompCustomEvent extends LightningElement {
    handleChange(){
        event.preventDefault();
        const name = event.target.value;
        const selectEvent = new CustomEvent('mycustomevent', {
            detail: name
        })
        this.dispatchEvent(selectEvent);
    }
}