public class invertedhalfpyramid {

    
    public String str{get;set;}
    
    
    public invertedhalfpyramid()
    { 
        str = ' ';
        Integer rows = 5;
        integer i, j;  
        for(i=rows ; i> 0; i--) 
            {           
            for(j=0; j< i; j++) 
            {       
                str +='* ';
                            
            }  
              str = str+'<br/>';
                
            }
           
        }
                  
}