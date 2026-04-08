class Graph
{
  float x, y;
  Graph()
  {
    
  }
  
  void display()
  {
    fill(0, 50);
    textAlign(CENTER);
    textSize(300);
    text("2018", width/2, height/2 + 100);
    int health = 10;
    line(100, 0, 100, height-200);
    textSize(18);
    for(int i=0; i<10; i++)
    {
      
      y = map(health, 0, 100, 200, 780);
      fill(0);
      text(health, 60, height - y);
      health = health + 10;
      stroke(123, 50);
      line(100, height - y, width, height - y);
   
    }
    
  float xStart = 100; 
  float xEnd = width-50; 
  float minVal = 300; 
  float maxVal = 128000; 
  
  // Draw axis line
  stroke(0);
  line(xStart, height-200, width, height-200);

  // GDP per capita tick labels
  int[] gdpValues = {500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000};
  
  for (int i = 0; i < gdpValues.length; i++) {
    float x = map(log(gdpValues[i]), log(minVal), log(maxVal), xStart, xEnd);
    
    // Draw tick mark
    stroke(123, 50);
    line(x, 0, x, height - 200);
    
    // Draw label
    fill(0);
    textAlign(CENTER);
   
    text(gdpValues[i], x, height -180);
    
  }
  
    textSize(32);
      text("Gapminder", width/2, 50);
    pushMatrix();
      translate(40, height/2);
      rotate(-HALF_PI);
      text("Life Expectancy", 0, 0);
    popMatrix();
    
    text("Income per Capita", width/2, height-140);
    

  }
  void legend()
  {
    fill(0);
    textAlign(LEFT);
    textSize(23);
       text("Asia", 40, 720);
       text("Europe", 40, 760);
       text("Africa", 180, 720);
       text("America", 180, 760);
       text("Oceania", 400, 720);
       text("Independent States", 400, 760);
       text("Hover over a continent to display its countries", width/2 + 20, 730); 
     
       
  fill(255, 223, 0, 123);
  rect(20, 710, 20, 20); // Asia
  
  fill(0, 0, 255, 123);
  rect(20, 750, 20, 20); // Europe
  
  fill(139, 69, 19, 123);
  rect(160, 710, 20, 20); // Africa
  
  fill(34, 139, 34, 123);
  rect(160, 750, 20, 20); // Northern America
  
  fill(30, 144, 255, 123);
  rect(380, 710, 20, 20); // Oceania
  
  fill(128, 0, 128, 123);
  rect(380, 750, 20, 20); // Independent States
  

  }
  

  
 
  
}
