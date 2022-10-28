public class invertedhalfpyramidnumbers {
    
public string val{get;set;}
   
      public invertedhalfpyramidnumbers() {
          
        val = ' ';    
          integer i,j ;
        integer rows = 1;
        for(i = 5; i >= rows; i--) 
        {
            for(j = 1; j <= i; j++)
            {
                
                val += j;
            }
            val = val + '<br/>';
        }
    }

}