import { LightningElement } from 'lwc';

export default class Paginator extends LightningElement {

    previousHandler() {

        const previousEvent=new CustomEvent('previous');
        this.dispatchEvent(previousEvent);
    }
  

    nextHandler() {
        const nextEvent=new CustomEvent('next');
        this.dispatchEvent(nextEvent);
    }
}