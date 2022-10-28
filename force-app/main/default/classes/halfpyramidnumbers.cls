public class halfpyramidnumbers {
    
    public string val{get;set;}
   
      public halfpyramidnumbers() {
          
        val = ' ';    
          integer i ,j;
        integer rows = 5;
        for(i = 1; i <= rows; i++) 
        {
            for(j = 1; j <= i; j++)
            {
                
                val += j ;
            }
            val = val + '<br/>';
        }
    }

}