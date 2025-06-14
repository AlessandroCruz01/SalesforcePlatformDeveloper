import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class PlatformShowToast extends LightningElement {
    variants = [
        {label: "Info", value: "info"},
        {label: "Error", value: "error"},
        {label: "Warning", value:  "warning"},
        {label: "Success", value: "success"}
    ]

    modes = [
        {label: "Dismissable", value: "dismissable"},
         {label: "Pester", value: "pester"},
         {label: "Sticky", value: "sticky"},
    ]
    
    variant = 'info';
    mode = 'dismissable';

    handlerVariantChanged(event){
        this.variant = event.detail.value;
    }

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