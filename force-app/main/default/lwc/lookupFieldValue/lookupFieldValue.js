import { LightningElement, api, track } from 'lwc';
import getRecentRecords from '@salesforce/apex/lookupfieldController.GetRecentRecords';
import searchRecords from '@salesforce/apex/lookupfieldController.SearchRecords';
import getRecord from '@salesforce/apex/lookupfieldController.GetRecord';
import getObjectDetails from '@salesforce/apex/lookupfieldController.getObjectDetails';
import { NavigationMixin } from 'lightning/navigation';

export default class LookupFieldValue extends NavigationMixin(LightningElement) {
    @api label;
    @api name;
    @api objectApiName;
    @api variant = 'standard';
    @api showIcon;
    @api get returnFields() {
        if (!this.internalReturnFields) {
            return ["Name"];
        }
        return this.internalReturnFields;
    }
    set returnFields(value) {
        this.internalReturnFields = this.clearSplit(value);
    }

    @api get queryFields() {
        if (!this.internalqueryFields) {
            return ["Name"];
        }
        return this.internalqueryFields;
    }
    set queryFields(value) {
        this.internalqueryFields = this.clearSplit(value);
    }
    @api maxResults = 5;
    @api sortColumn = 'CreatedDate';
    @api sortOrder = 'DESC';
    @api showRecent;
    @api showAddNew;

    @api get disabled() {
        return this.internalDisabled;
    }
    set disabled(value) {
        this.internalDisabled = value;
    }
    @api get showError() {
        return this.internalshowError;
    }
    set showError(value) {
        this.internalshowError = value;
    }

    @api filter;
    @api required;
    @api errorMessage;
    @api get selectedId() {
        return this.internalSelectedId;
    }
    set selectedId(value) {
        if (this.objectApiName && value) {
            getRecord({ 'ObjectName': this.objectApiName, 'ReturnFields': this.returnFields, 'Id': value }).then(results => {
                results = this.processResults(results, this.returnFields);
                if (results.length > 0) {
                    this.selectedName = results[0].Field0;
                    this.isLoading = false;
                }
                this.internalSelectedId = value;
            }).catch(error => {
                this.internalSelectedId = value;
                window.console.error(error);
            });
        } else {
            this.internalSelectedId = value;
        }
    }

    @track internalDisabled;
    @track internalSelectedId;
    @track internalshowError;
    @track selectedName;
    @track isLoading;
    @track objectLabel = '';
    @track objectLabelPlural = '';
    @track searchResult = [];
    @track IconName;
    @track statusMessage;
    @track isSearching;

    get getElementStyle() {
        return 'slds-form-element' + (this.internalshowError ? ' slds-has-error' : '');
    }

    get getShowLabel() {
        return this.variant != 'label-hidden';
    }

    get getBoxStyle() {
        return 'slds-combobox_container' + (this.internalSelectedId ? ' slds-has-selection' : '');
    }

    get getInputPlaceholder() {
        return this.objectLabelPlural ? 'Search ' + this.objectLabelPlural + '...' : 'Search...';
    }

    connectedCallback() {
        getObjectDetails({ 'ObjectName': this.objectApiName }).then(details => {
            this.IconName = details.iconName;
            this.objectLabel = details.label;
            this.objectLabelPlural = details.pluralLabel;
            this.isLoading = !!this.internalSelectedId;
        });
        if (this.showAddNew) {
            getRecentRecords({ 'ObjectName': this.objectApiName, 'ReturnFields': null, 'MaxResults': 1 }).then(results => {
                if (results != null && results.length > 0) {
                    this.lastRecordId = results[0].Id;
                }
            });
        }
    }

    onFocus() {
        let inputBox = this.template.querySelector(".lookup-input-box");
        let searchText = this.searchText || '';
        inputBox.classList.add('slds-is-open');
        inputBox.classList.add('slds-has-focus');
        inputBox.classList.remove('slds-is-close');

        if (this.showRecent && searchText.trim() == '') {
            this.isSearching = true;
            getRecentRecords({
                'ObjectName': this.objectApiName,
                'ReturnFields': this.returnFields,
                'MaxResults': this.maxResults
            }).then(results => {
                if (results != null) {
                    this.statusMessage = results.length > 0 ? null : 'No recent records.';
                    this.searchResult = this.processResults(results, this.returnFields);
                } else {
                    this.statusMessage = "Search Error!";
                }
                this.isSearching = false;
            });
        }
    }

    onBlur() {
        let inputBox = this.template.querySelector(".lookup-input-box");
        inputBox.classList.add('slds-is-close');
        inputBox.classList.remove('slds-is-open');
        inputBox.classList.remove('slds-has-focus');
    }

    onChange(event) {
        let searchText = event.currentTarget.value;

        if (this.oldSearchText === searchText) {
            return;
        } else {
            this.oldSearchText = searchText;
        }

        if (searchText == null || searchText.trim().length < 3) {
            this.searchResult = [];
            this.statusMessage = undefined;
            return;
        }

        if (window.isSearching) {
            window.clearTimeout(window.isSearching);
        }

        window.isSearching = window.setTimeout(function (context) {
            context.isSearching = true;
            searchRecords({
                'ObjectName': context.objectApiName,
                'ReturnFields': context.returnFields,
                'QueryFields': context.queryFields,
                'SearchText': searchText,
                'SortColumn': context.sortColumn,
                'SortOrder': context.sortOrder,
                'MaxResults': context.maxResults,
                'Filter': context.filter
            }).then(results => {
                if (results != null) {
                    context.statusMessage = results.length > 0 ? null : 'No records found.';
                    context.searchResult = context.processResults(results, context.returnFields, searchText);
                } else {
                    context.statusMessage = 'Search Error!';
                }
                context.isSearching = false;
            });
        }, 700, this);
    }

    onSelectItem(event) {
        this.internalSelectedId = event.currentTarget.dataset.id;

        this.fireEvent();

        for (let i = 0; i < this.searchResult.length; i++) {
            if (this.searchResult[i].Id == this.internalSelectedId) {
                this.selectedName = this.searchResult[i].Field0.replace("<mark>", "").replace("</mark>", "");
                break;
            }
        }
        this.onBlur();
    }

    removeSelectedOption() {
        this.internalSelectedId = undefined;
        this.selectedName = undefined;

        this.fireEvent();
    }

    fireEvent() {
        const selectEvent = new CustomEvent('changed', {
            detail: {
                name: this.name,
                value: this.internalSelectedId
            }
        });
        this.dispatchEvent(selectEvent);
    }

    createNewRecord() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: this.objectApiName,
                actionName: 'new'
            }
        });
    }

    processResults(results, returnFields, searchText) {
        let regEx = null;

        if (searchText != null && searchText.length > 0) {
            regEx = new RegExp(searchText, 'gi');
        }
        let newResult = [];
        for (let i = 0; i < results.length; i++) {
            let rowItem = Object.assign({}, results[i]);

            rowItem['Field0'] = rowItem[returnFields[0]].replace(regEx, '<mark>$&</mark>');
            rowItem['Style'] = 'slds-media slds-listbox__option slds-listbox__option_entity slds-listbox__option_has-meta' + (rowItem.Id == this.internalSelectedId ? ' slds-has-focus' : '');

            for (let j = 1; j < returnFields.length; j++) {
                if (returnFields[j].indexOf('.') > 0) {
                    let fields = returnFields[j].split('.');
                    let fieldValue = rowItem[fields[0]];
                    if (fieldValue) {
                        rowItem['Field1'] = (rowItem['Field1'] || '') + ' • ' + fieldValue[fields[1]];
                    }
                } else {
                    let fieldValue = rowItem[returnFields[j]];
                    if (fieldValue) {
                        rowItem['Field1'] = (rowItem['Field1'] || '') + ' • ' + fieldValue;
                    }
                }
            }

            if (rowItem['Field1']) {
                rowItem['Field1'] = rowItem['Field1'].substring(3).replace(regEx, '<mark>$&</mark>');
            }
            newResult.push(rowItem);
        }

        return newResult;
    }

    clearSplit(value) {
        return value.replace(/\'/g, '').replace('[', '').replace(']', '').split(',');
    }
}