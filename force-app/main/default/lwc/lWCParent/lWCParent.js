import { LightningElement,wire,track } from 'lwc';
import getAccountList from '@salesforce/apex/AccountController.getAccountList';

export default class LwcParent extends LightningElement {
    @track selectedAccountId;
   // @wire(getAccountList) accountList;  
   

   accountList = [
        {
        Name : 'vizda',
        Amount :500,
        Website :'wwwd.cube84.com',
    },
    {
        Name : 'Cube84',
        Amount : 5000,
        Website : 'www.cube84.com'
    }
    ]

    onAccountSelection(event){
        this.selectedAccountId = event.detail.recordId;
       
    }
}
