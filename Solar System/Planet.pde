class Planet
{
  float radius;
  float angle;
  float distance;
  Planet[] planets;
  float orbitSpeed;
  
  PShape globe;
  
  float planetRadius[] = {2439, 6051, 6378, 3389, 69911, 58232, 25362, 24622};
  float planetDistance[] = {0.39, 0.72, 1, 1.52, 5.2, 9.54, 19.2, 30};
  float planetSpeed[] = {47, 35, 29, 24, 13, 9, 6, 5};
  
  Planet moon = null;
  float selfRotationAngle=0;

  
   //creating planets (and sun)
   Planet(float r, float d, float o, PImage img)
   {
     radius = r;
     distance = d;  
     angle = 0;
     orbitSpeed = o * 4;
      
     noStroke();
     noFill();
     globe = createShape(SPHERE, radius);
     globe.setTexture(img);
   }
   
  
   
   
   //creating orbit lines
   void orbitLines()
   {
     //distances of the lines
     for(int i = 0; i<planets.length; i++)
     {
        float[] d = {250, 350, 450, 550, 750, 1050, 1300, 1500};
         noFill();
           
       //cyan-ish lines
       for (int b = 2; b > 0; b--)
       {
         stroke(86, 175, 184, 10 * b);
         strokeWeight(b * 2);
         float dis = d[i]*2;
         circle(0, 0, dis);
       }    
     }
   }

  //creating orbiting for plantes and moon
   void orbit()
   {
     angle = angle + orbitSpeed;
     selfRotationAngle+=0.02;
      
     if(planets !=null)
       {
         for(int i=0; i<planets.length; i++)
         {
           planets[i].orbit();
         }
       }
       if(moon !=null)
       {
         moon.orbit();
       }
   }
   
  //spawning planets
  void spawnPlanets(int total)
  {
    planets = new Planet[total];
    for(int i=0; i<planets.length; i++)
    {
      float r;
      float o;
     
      r = map(planetRadius[i], 2439, 69911, 20, 150);
      o = map(planetSpeed[i], 5, 47, 0.001, 0.01);     
      float[] d = {250, 350, 450, 550, 750, 1050, 1300, 1500};
      
      planets[i] = new Planet(r, d[i], o, textures[i]);
    

    //spawning around the earth
       if(i==2)
       {
         planets[i].spawnMoon();
       }
    }
  }
  
  //spawning moon
  void spawnMoon()
  {
    float moonDistance = radius *2.5;
    float moonSpeed = 0.02;
    moon = new Planet(radius/3, moonDistance, moonSpeed, moonTexture); 
  }

  void show()
  {
    pushMatrix();
      noStroke();
      rotate(angle);
      translate(distance, 0);
      shape(globe);
       
      
       
       //visualising moon
        if (moon != null) 
        {
          pushMatrix();
            rotateY(moon.angle);
            translate(moon.distance, 0);
            rotateX(moon.selfRotationAngle);
            shape(moon.globe);
          popMatrix();
        }
        //visualising planets
        if(planets != null)
        {
           for(int i=0; i<planets.length; i++)
           {
              if(mousePressed)
              {
                    float x = cos(angle) * distance;
    float y = sin(angle) * distance;
    cam.lookAt(x, y, 0);
              }
               planets[i].show();
           }
        }
      
    popMatrix();
  }
}
