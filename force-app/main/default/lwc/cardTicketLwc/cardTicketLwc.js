import { LightningElement, api } from 'lwc';

export default class CardTicketLwc extends LightningElement {
    @api vooIda;
    @api vooVolta;
    @api moeda;

    reservaHandler(){
       
        let compEvent = new CustomEvent('ticketEventClick', {
            detail: {
                "IdVooIda": this.vooIda.Id,
                "IdVooVolta": this.vooVolta.Id
            }
        })

        this.dispatchEvent(compEvent);
    }

    get vooDeIdaDiferente(){
        return this.vooIda.Data_Partida__c !== this.vooIda.Data_Chegada__c;
    }

    get vooDeVoltaDiferente(){
        return this.vooVolta.Data_Partida__c !== this.vooVolta.Data_Chegada__c;
    }

    get valorTotal(){
        return this.vooIda.Valor__c + this.vooVolta.Valor__c;
    }
}