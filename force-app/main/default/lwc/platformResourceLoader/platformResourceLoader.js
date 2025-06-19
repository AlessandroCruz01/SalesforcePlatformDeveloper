import { LightningElement, track } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import formatterLibrary from '@salesforce/resourceUrl/formatter'
import animationButtonCSS from '@salesforce/resourceUrl/animationButtonCSS'

export default class PlatformResourceLoader extends LightningElement {
    @track isLoaded = false;
    @track valueToFormat = Date.now();
    @track formattedValue = '';

    connectedCallback() {
        Promise.all([
            loadScript(this, formatterLibrary)
            , loadStyle(this, animationButtonCSS) // Carrega o CSS do botão de animação
        ]).then(() => {
                // Library loaded successfully
                console.log('Formatter library loaded successfully!!');
                this.isLoaded = true;

                const input = document.createElement('input');

                // 2. Adiciona um valor como string
                const dateObj = new Date(this.valueToFormat);
                const value = `${dateObj.getFullYear()}${String(dateObj.getMonth() + 1).padStart(2, '0')}${String(dateObj.getDate()).padStart(2, '0')}`;
                input.value = value; // exemplo: '20250619'

                new window.Formatter(input, {
                    pattern: '9999-99-99', // aplica yyyy-MM-dd
                    persistent: true
                });

                // 4. Força o valor a ser formatado
                input.dispatchEvent(new Event('keypress')); // força reprocessamento
                this.formattedValue = input.value;

                console.log('Formatted Value:', this.formattedValue);

            })
            .catch(error => {
                // Handle loading error
                console.error('Error loading formatter library:', error);
            });

        
    }

    

}