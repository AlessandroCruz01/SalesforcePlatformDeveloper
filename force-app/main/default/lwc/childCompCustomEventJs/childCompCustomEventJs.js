import { LightningElement } from 'lwc';

export default class ChildCompCustomEventJs extends LightningElement {
    handleChange(event){
        event.preventDefault();
        const name = event.target.value;
        const selectEvent = new CustomEvent('mycustomevent', {
            detail: name,
            bubbles: true
        })

        this.dispatchEvent(selectEvent);
    }
}