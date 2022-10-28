import { LightningElement, track, wire } from 'lwc';
import fetchAccounts from '@salesforce/apex/DeleteMultipleAccRecordHandler.fetchAccounts';
import fetchAccountList from '@salesforce/apex/MassAccDeleteHandler.fetchAccountList';
import deleteSelectedAccounts from '@salesforce/apex/MassAccDeleteHandler.deleteSelectedAccounts';
import deleteSingleAccount from '@salesforce/apex/MassAccDeleteHandler.deleteSingleAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from 'lightning/navigation';  
import {deleteRecord} from 'lightning/uiRecordApi';
const columns = [
    {
        label: 'Name',
        fieldName: 'Name'
    }, {
        label: 'Website',
        fieldName: 'Website'
    },
    {type: "button", typeAttributes: {  
        label: 'View',  
        name: 'View',  
        title: 'View',  
        disabled: false,  
        value: 'view',  
        iconPosition: 'left'  
    }},
    {type: "button", typeAttributes: {  
        label: 'Delete',  
        name: 'delete',  
        title: 'delete',  
        disabled: false,  
        value: 'delete',  
        iconPosition: 'left'  
    }}
 ];
export default class Project1 extends LightningElement {

    @track data;
    @track columns = columns;
    @track buttonLabel = 'Delete Records';
    @track isTrue = false;
    @track recordsCount = 0;
    @track columns = columns;  

    // non-reactive variables
    selectedRecords = [];
    refreshTable;
    error;
   
    @wire(fetchAccountList)
    accountss(result) {
        this.refreshTable = result;
        if (result.data) {
            this.data = result.data;
            this.error = undefined;

        } else if (result.error) {
            this.error = result.error;
            this.data = undefined;
        }
    }

    //Start search account code

    handleKeyChange( event ) {  
         
        const searchKey = event.target.value;  
 
        if ( searchKey ) {  
 
            fetchAccounts( { searchKey } )    
            .then(result => {  
 
                this.data = result;  
 
            })  
            .catch(error => {  
 
                this.error = error;  
 
            });  
 
        } else  
        this.data = undefined;  
 
    }      

    // End search account code

    //Start Single Delete Code

    callRowAction( event ) {  
        alert('Inside the Loop');
       
        const recId =  event.detail.row;
         const recId1 =  event.detail.row.Id; 
        const actionName = event.detail.action.name;  
        alert(recId);
        if(actionName==='Delete')
        {
           this.delAccount(recId);

        }
        /*if(recId)
        {
            alert('Inside the if loop');
            deleteSingleAccount({accounts: recId })
            .then(() =>{

        const toastEvent = new ShowToastEvent({
            title:'Record Deleted',
            message:'Record deleted successfully',
            variant:'success',
        })
        this.dispatchEvent(toastEvent);

        return refreshApex(this.refreshTable);
        
     })
     .catch(error =>{
         window.console.log('Unable to delete record due to ' + error.body.message);
     });
        }*/
    else if ( actionName === 'View') {  
  
            this[NavigationMixin.Navigate]({  
                type: 'standard__recordPage',  
                attributes: {  
                    recordId: recId1,  
                    objectApiName: 'Account',  
                    actionName: 'view'  
                }  
            })  
  
        } 
     
    }
    delAccount(recId) {
        if(recId)
        {
            alert('Inside the if loop');
            deleteSingleAccount({accounts: recId })
            .then(() =>{

        const toastEvent = new ShowToastEvent({
            title:'Record Deleted',
            message:'Record deleted successfully',
            variant:'success',
        })
        this.dispatchEvent(toastEvent);

        return refreshApex(this.refreshTable);
        
     })
     .catch(error =>{
         window.console.log('Unable to delete record due to ' + error.body.message);
     });
        }
    }

    //End Single Delete Code  

    getSelectedRecords(event) {        
        const selectedRows = event.detail.selectedRows;
        this.recordsCount = event.detail.selectedRows.length;
        this.selectedRecords=new Array();
        for (let i = 0; i < selectedRows.length; i++) {
            this.selectedRecords.push(selectedRows[i]);
        }        
    }

    deleteRecords() {
        var r = confirm("Are you sure you want to delete?");
            alert(r);
        if(r == true){
        if (this.selectedRecords) {
            this.buttonLabel = 'Processing....';
            this.isTrue = true;
            deleteSelectedAccounts({accountLst: this.selectedRecords }).then(result => {
                window.console.log('result ====> ' + result);
                this.buttonLabel = 'Delete Records';
                this.isTrue = false;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: this.recordsCount + ' records are deleted.',
                        variant: 'success'
                    }),
                );
                this.template.querySelector('lightning-datatable').selectedRows = [];
                this.recordsCount = 0;
                return refreshApex(this.refreshTable);
            }).catch(error => {
                this.buttonLabel = 'Delete Records';
                this.isTrue = false;                
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error while getting Contacts',
                        message: JSON.stringify(error),
                        variant: 'error'
                    }),
                );
            });
        }
    }
    }
 }
