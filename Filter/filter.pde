//images
PImage selectedImage;
PImage[] images = new PImage[4];
PImage[] filteredImages = new PImage[7];
PImage save;

//integers
int selectedImageIndex = -1;
int hoveredFilterIndex = -1;
int j = 2;
int y= 100;

//boolean
boolean processingFilters = false;
boolean filteresGenerated = false;
boolean filterOn = false;
boolean cursorOn = false;
boolean sliderOn = false;
boolean saveTriggered = false;

//slider
float sliderX, sliderY, sliderHeight;
float handleY, handleSize;
boolean dragging = false;

//class
FilterClass filterClass;

void setup()
{
  size(700, 700);
  background(255);
  filterClass = new FilterClass();

  for (int i=0; i < images.length; i++)
  {
    images[i] = loadImage("images/image" + i + ".jpg");
  }
}

void draw()
{
 
  //redraw the background
  background(255);

//displays orange indicator which image is selected 
 if(hoveredFilterIndex >-1)
 {
   filterClass.selectedFilter(hoveredFilterIndex);
 }

//display the images on the left hand side
  filterClass.displayThumbnail(images);
 // filterClass.slider(y);
  filterClass.cursorState(cursorOn, filterOn);
 
   //display filter gallery when ready
   if(selectedImage !=null && !processingFilters)
   {
     filterClass.displayFilters(filteredImages);
     filterClass.displayText();
       //gallery at the bottom
       
    for (int i = 0; i < 7; i++)
    {
      int x = 100 + (i * 100); // Calculate x position with increments of 100
      stroke(123,123);
      strokeWeight(2);
      line(x, 550, x, 700); // Draw vertical line
    }
      //slider + apply button is shown
      filterClass.slider();
   }
 
   //display hovered filter or selected image
   if(hoveredFilterIndex >= 0 && !processingFilters)
   {
     image(filteredImages[hoveredFilterIndex], width/2 - 100, 0, 300, 500);
     filterClass.saveImage(filteredImages[hoveredFilterIndex]);
   }
   else if(selectedImage != null)
   {
     image(selectedImage, width/2 - 100, 0, 300, 500);
   }
 
  //prevents from the frame being applied at y=-137px
  if(selectedImageIndex > -1)
  {
   filterClass.selectedFrame(selectedImageIndex);
  }

}

//displays and refreshes filters
 void generateFilters()
    {
      for(int i=0; i<7; i++)
      {
        filteredImages[i] = filterClass.applyFilter(selectedImage.copy(), i); 
      }
      processingFilters = false;
      filteresGenerated = true;
    }


void mousePressed()
{
  //check if the user selected an image
  if((mouseX < 100) && (mouseY < 135))
  {
    selectedImage = images[0].copy();
      selectedImageIndex = 0;
      filteresGenerated = false;
      filterClass.applyFiltersToSelected();
  }
  else if((mouseX < 100) && (mouseY < 275))
  {
    selectedImage = images[1].copy();
      selectedImageIndex = 1;
      filteresGenerated = false;
      filterClass.applyFiltersToSelected();
  }
  else if((mouseX < 100) && (mouseY < 410))
  {
    selectedImage = images[2].copy();
      selectedImageIndex = 2;
      filteresGenerated = false;
      filterClass.applyFiltersToSelected();
  }
  else if((mouseX < 100) && (mouseY < 540))
  {
    selectedImage = images[3].copy();
      selectedImageIndex = 3;
      filteresGenerated = false;
      filterClass.applyFiltersToSelected();
  }
  
    //hovered image
    if(selectedImage != null)
    {
    if((0 <= mouseX && mouseX <= 100) && (mouseY > 500))
    {
      hoveredFilterIndex = 0;
    }
    else if((100 <= mouseX && mouseX <= 200) && (mouseY > 500))
    {
      hoveredFilterIndex = 1;
    }
    else if((200 <= mouseX && mouseX <= 300) && (mouseY > 500))
    {
      hoveredFilterIndex = 2;
    }
    else if((300 <= mouseX && mouseX <= 400) && (mouseY > 500))
    {
      hoveredFilterIndex = 3;
    }
    else if((400 <= mouseX && mouseX <= 500) && (mouseY > 500))
    {
      hoveredFilterIndex = 4;
    }
    else if((500 <= mouseX && mouseX <= 600) && (mouseY > 500))
    {
      hoveredFilterIndex = 5;
    }
    else if((600 <= mouseX && mouseX <= 700) && (mouseY > 500))
    {
      hoveredFilterIndex = 6;
    }
    //refereshes the image using the new filter options (input from the slider)
    if((mouseX > 575 && mouseX < 675) && (mouseY > 270 && mouseY < 300))
    {
        generateFilters();
    }
  }

 //dragging bool control
  if(dist(mouseX, mouseY, sliderX, handleY) < handleSize /2)
  {
    dragging = true;
  }
  
}

void mouseReleased()
{
     saveTriggered = false;
     dragging = false;
}
