import { LightningElement, api, wire } from 'lwc';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';

export default class RelatedList extends LightningElement {
    @api recordId;
    @api objectName;
    @api fieldString;
    @api fields;
    @api relatedList = [];
    @api fieldColumns = [];

    connectedCallback() {
        this.fields = this.fieldString.split(',');
        let fieldCols = [];
        this.fields.forEach(element => {
            let elementName = element.substring(element.indexOf(".") + 1);
            let col = { label : elementName, fieldName : elementName};
            fieldCols.push(col);
            console.log(col);
        })
        this.fieldColumns = fieldCols;
    }

    @wire(getRelatedListRecords, {
        parentRecordId: '$recordId',
        relatedListId: '$objectName',
        fields: '$fields'
    }) listInfo({error, data}) {
        if(data) {
            let tempRecords = [];
            data.records.forEach(element => {
                let temp = {};
                temp.Id = element.fields.Id.value;
                temp.Name = element.fields.Name.value;
                tempRecords.push(temp);
            });
            this.relatedList = tempRecords;
        } else if(error) {
            console.log(error);
        }
    }
}