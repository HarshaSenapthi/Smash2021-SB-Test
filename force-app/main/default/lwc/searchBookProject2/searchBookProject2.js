import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import searchBooks from '@salesforce/apex/BookController.searchBooks';
import deleteBook from '@salesforce/apex/BookController.deleteBook';
import addBook from '@salesforce/apex/BookController.addBook';

const actions = [
    { label: 'Show details', name: 'show_details' },
    { label: 'Delete', name: 'delete' }
];

const columns = [
    { label: 'Label', fieldName: 'Name' },
    { label: 'Published Date', fieldName: 'PublishedDate__c'},
    { label: 'Description', fieldName: 'BookDescription__c'},
    { label: 'PDF Available', fieldName: 'PDF_Available__c'},
    { label: 'Author', fieldName: 'Author__c'},
];



export default class SearchBookProject2 extends LightningElement {
    columns = columns;
    booksLst
    bookLstApi
    searchKey
    finalBookLst
    recordId
    record

    constructor() {
        super();
        //alert('constructor')
        console.log('Columns'+JSON.stringify(this.columns))
        var col = { type: 'action', typeAttributes: { rowActions: this.getRowActions } }
        this.columns.push(col)
        console.log('Columns2'+JSON.stringify(this.columns))
    }

    getRowActions(row, doneCallback) {
        const actions = [];
        console.log('row'+JSON.stringify(row))
        console.log(row.Id)
            if (row.Id !=='') {
                console.log('Not E')
                actions.push({
                    'label': 'Delete',
                    'name': 'delete'
                });
            } else {
                actions.push({
                    'label': 'Add',
                    'name': 'add'
                });
            }

            doneCallback(actions);
            // simulate a trip to the server
           /**setTimeout(() => {
                doneCallback(actions);
            }),200);**/
    }


    handleSearchTermChange(event) {
		this.searchKey = event.target.value;
		this.delayTimeout = setTimeout(() => {
			this.searchKey = searchKey;
		}, 300);
    }
    handleClick(){
        searchBooks({searchKey: this.searchKey})
                .then(result => {
                   this.booksLst = result;
                    console.log('this.booksLst'+this.booksLst)
                   // console.log(JSON.stringify(this.booksLst))
                })
                .catch(error => {
                    this.error = error;
                });
                this.fetchBookData()
    }

    fetchBookData(){
        let arr = [];
       // console.log('booksLst Entered')
        fetch('https://www.googleapis.com/books/v1/volumes?langRestrict=en&q='+this.searchKey).then(response=>response.json())
        .then(data=>{
            this.bookLstApi = data
            //this.bookLstApiItems =data.items
            data.items.forEach(element => {
                //console.log('element'+JSON.stringify(element))
               var ele = {
                    "Name":element.volumeInfo.title,
                    "PublishedDate__c": element.volumeInfo.publishedDate,
                    "BookDescription__c": element.volumeInfo.description,
                    "PDF_Available__c": element.accessInfo.pdf.isAvailable,
                    "Author__c": element.volumeInfo.authors[0],
                    "Id":''
                }
               // console.log('ele'+JSON.stringify(ele))
                arr.push(ele)
            });
            //console.log('arr Result'+JSON.stringify(arr))
            this.finalBookLst = [...this.booksLst, ...arr]
            
            //console.log('this.finalBookLst'+this.finalBookLst)
        })
        .catch(error=>console.log(error))
    }


    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        this.record = JSON.stringify(event.detail.row)
        this.recordId = event.detail.row.Id;
        var name = event.detail.row.Name
        if(actionName == 'delete') {
            console.log('Entered Delete')
            deleteBook({recordId: this.recordId})
            .then(result => {
                    const event = new ShowToastEvent({
                        title: 'Success',
                        message: 'You have deleted the book Successfully',
                        variant: 'success',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(event);
             })
             .catch(error => {
                 this.error = error;
             });
        }

        if(actionName == 'add') {
            console.log('Entered add')
            addBook({record: this.record})
            .then(result => {
                const event = new ShowToastEvent({
                    title: 'Success!',
                    message: 'You have added the book Successfully',
                    variant: 'success',
                    mode: 'dismissable'
                });
                this.dispatchEvent(event);
             })
             .catch(error => {
                 this.error = error;
             });
        }
    }
}