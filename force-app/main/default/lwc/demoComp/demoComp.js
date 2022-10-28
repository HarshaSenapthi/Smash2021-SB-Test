import { LightningElement } from 'lwc';

export default class DemoComp extends LightningElement {

   name = 'Harsha S';
   amount= 10000;
   website='https://www.google.com';

   ready = false;
   connectedCallback() {
       setTimeout(() => {
           this.ready = true;
       }, 6000);
   }


}