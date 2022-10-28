public class halfpyramid{
    
    public String val{get;set;} // declaration of string to recieve data from vfpage,to set data to the vf page
    
    public halfpyramid()        
    { 
        val = ' '; 
        Integer rows = 5; // intialization of rows
        
        integer i, j; // Declaration of i,j
        
        for(i=0; i< rows; i++)  // outer for loop to create new line
            {           
            for(j=0; j<=i; j++) // Inner for loop to print *
            {       
                val +='* ';     // assigning value using assignment operator
                            
            }  
              val = val+ '<br/>';   // concatinate break with the string
                
                
            }
           
        }
    }