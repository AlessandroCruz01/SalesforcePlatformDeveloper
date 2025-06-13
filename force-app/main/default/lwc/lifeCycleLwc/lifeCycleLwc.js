import { LightningElement } from 'lwc';

export default class LifeCycleLwc extends LightningElement {
    error;
    stack;
    
    constructor(){ // Bastante comum, é chamado quando o componente é instanciado
        super();
        console.log('Constructor called');
    }

    connectedCallback(){ // Bem mais utilizado, é chamado quando o componente é adicionado ao DOM
        console.log('Connected Callback called');
    }

    errorCallback(error, stack){ // Não é muito usual, mas é chamado quando há um erro não tratado
        console.error('Error Callback called', error, stack);
        this.error = error;
        this.stack = stack;
    }

    render(){ // Não é muito comum, mas pode ser usado para retornar um template diferente
        console.log('Render called');
    }

    renderedCallback(){ // Pouco usual, é chamado após o componente ser renderizado no DOM
        if(this.hasLoaded){
            console.log('Rendered Callback called');
        }
    }

    disconnectedCallback(){ // Pouco usual, é chamado quando o componente é removido do DOM
        console.log('Disconnected Callback called');
    }
    
}