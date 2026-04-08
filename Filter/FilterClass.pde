class FilterClass
{ 
  String folderPath = sketchPath("savedImage");
  File folder = new File(folderPath);

    FilterClass()
    { 
      save = loadImage("images/save.png");
      //slider variables
      sliderX = 620;
      sliderY = 45;
      sliderHeight = 200;
      handleSize = 20;
      handleY = sliderY; 
    }
   
    void displayThumbnail(PImage images[])
    {
      for (int i=0; i < images.length; i++)
      {
        image(images[i], 0, i * 137, 136, 137);
      }
    }
    
    void displayFilters(PImage filteredImages[])
    {
      for(int i=0; i<7; i++)
      {
        image(filteredImages[i], 10 + i * 100, height - 100, 80, 80);
      }
    }
    
    void applyFiltersToSelected()
    {
      processingFilters = true;
      thread("generateFilters");
    }
    
    void displayText()
    {
      fill(0);
      textSize(18);
      textAlign(CENTER);
      text("Original", 50, 580);
      text("Invert", 150, 580);
      text("Treshold", 250, 580);
      text("Posterize", 350, 580);
      text("Blur", 450, 580);
      text("Colour Shift", 550, 580);
      text("Pixel Shift", 650, 580);
    }
 
    void selectedFrame(int i)
    {
      strokeWeight(2);
      stroke(255, 0, 0);
      fill(255, 0);
      rect(0, i * 137, 136, 137);
    }
    
    void selectedFilter(int i)
    {
      noStroke();
      fill(255, 123, 0);
      rect(i*100, 550, 100, 150);
    }
    
    void cursorState(boolean saveOn, boolean filterOn)
    {
      //images on the left
      if(( 0 < mouseX && mouseX < 136) && (0 < mouseY && mouseY < 548))
      {
        cursor(HAND);
      }
      //save
      else if ((mouseX > 575 && mouseX < 675) && (mouseY > 350 && mouseY < 450))
      {
        if(saveOn)
        {
          cursor(HAND);
        }
      }
      //filters
      else if((0 < mouseX && mouseX < width) && (548 < mouseY && mouseY < height))
      {
        if(filterOn)
        {
          cursor(HAND);
        }
      }
      //aply button
      else if((mouseX > 575 && mouseX < 675) && (mouseY > 270 && mouseY < 300))
      {    
        if(sliderOn)
        {
          cursor(HAND);
        }
      }
      else
      {
        cursor(ARROW);
      }
    }
    
    void saveImage(PImage img)
    { 
     if(filterOn)
     {
      cursorOn = true;
      save.resize(100, 100);
      image(save, 575, 350);
      text("Save", 620, 480);
      
      if((mouseX > 575 && mouseX < 675) && (mouseY > 350 && mouseY < 450))
      {      
       if(mousePressed && !saveTriggered)
       {   
         if(folder.exists() && folder.isDirectory())
         {
           File[] files = folder.listFiles();
           img.resize(300, 500);
          
           // Ensure files.length is treated as an integer before incrementing
           int count = files.length + 1;  
          
           // Save the image with the correct numbering
           img.save("savedImage/image" + count + ".jpg");
         }
        saveTriggered = true;
       }
      }
     }   
    }
    
    void slider()
    {
      stroke(0);
      strokeWeight(2);
      line(sliderX, sliderY, sliderX, sliderY + sliderHeight);
      
      //move handle on drag
      if(dragging)
      {
        handleY = constrain(mouseY, sliderY, sliderY + sliderHeight);
      }
      
      //handle
      fill(100);
      ellipse(sliderX, handleY, handleSize, handleSize);
     
     //apply button
      fill(255, 0, 0);
      strokeWeight(1);
      rect(575, 270, 100, 30);
      fill(0);
      text("Apply", 625, 290);
      
      sliderOn = true;
    }
    
    
    PImage applyFilter(PImage img, int filterType)
    {
      filterOn = true;     
      img.resize(200, 200);
      
      switch(filterType)
      {
        case 0: break;
        case 1: img.filter(INVERT); break;
        
        case 2:
          float treshVal = (map(handleY, sliderY + sliderHeight, sliderY, 0.99, 0.1));   
          img.filter(THRESHOLD, treshVal);        
        break;
       
        case 3: 
          int posVal = int(map(handleY, sliderY + sliderHeight, sliderY, 40, 2));   
          img.filter(POSTERIZE, posVal);     
        break;
    
        case 4: 
          int blurVal = int(map(handleY, sliderY + sliderHeight, sliderY, 5, 0));   
          img.filter(BLUR, blurVal);   
        break;
        
        case 5:       
           for(int y = 0; y <img.height; y++)
           {
             for(int x = 0; x < img.width; x++)
             {
               int loc = x + y * img.width;
               color c = img.pixels[loc];
               
               int r = int(map(handleY, sliderY + sliderHeight, sliderY, 255, 0));
               float g = green(c);
               float b = blue(c);
               
               img.pixels[loc] = color(r, g, b);
             }
           }
        break;
         
        case 6: 
          for(int y=0; y <img.height; y++)
          {
            for(int x =0; x <img.width; x++)
            {
              int loc = x + y * img.width;
              color c = img.pixels[loc];
              
              int val = int(map(handleY, sliderY + sliderHeight, sliderY, 0, 30));
              float r = red(c) + random(-30, val);
              float g = green(c) + random(-30, val);
              float b = blue(c) + random(-30, val);
              
              img.pixels[loc] = color(constrain(r, 0, 255), constrain(g, 0, 255), constrain(b, 0, 255));
            }
          }
          img.updatePixels();
            
        break;
      }
      return img;
    }   
}
