import { LightningElement } from 'lwc';
//import lwcStyleResource from '@salesforce/resourceUrl/LWCCommonCSS';
import {loadStyle} from 'lightning/platformResourceLoader';
export default class ShareStyleResource extends LightningElement {
    contacts=[
        {
            Id:'0035j00000ORn8VAAY',
            Name:'Harsha Vardhan',
            Title:'Developer'
        },
        {
            Id:'0035j00000M45YOAAW',
            Name:'Martin',
            Title:'VP'
        },
        {
            Id:'0035j00000M45YUAAQ',
            Name:'David',
            Title:'Director'
        }
    ];
    /*connectedCallback()
    {
        Promise.all(
            [
                loadStyle(this,lwcStyleResource)
            ]
        ).then(()=>{
            alert('files Loaded.');
        })
        .catch(error => {
            alert(error.body.message);
        })
    }*/
}