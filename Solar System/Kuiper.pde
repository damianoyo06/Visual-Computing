class KuiperBelt
{
    float radius;
    float angle;
    float distance;
    PShape globe;
    float orbitSpeed;
    KuiperBelt[] asteroids;
 
  //creating asteroid system
  KuiperBelt(float r, float d, float o)
  {
    radius = r;
    distance = d;
    orbitSpeed = o;
    angle = random(TWO_PI);
    
    noStroke();
    fill(random(120, 180), random(90, 220), random(60, 255));
    globe = createShape(SPHERE, radius);
  
  }
  
  //creaiting spinning function
  void spin()
  {
    angle += orbitSpeed * 0.0001;
    if(asteroids != null)
    {
      for(int i=0; i<asteroids.length; i++)
      {
        asteroids[i].spin();
      }
    }
  }
  
  //creating individual asteroids
  void spawnAsteroids(int total)
  {
    asteroids = new KuiperBelt[total];
    float[] distances = new float[total];
    for(int k=0; k < distances.length; k++)
    {
      distances[k] = random(1400, 1600);
    }
    
      for (int i = 0; i < asteroids.length; i++) 
      {
        float r = 20;  
        float o = random(0.0001, 0.001); 
        float d = distances[i];  
        asteroids[i] = new KuiperBelt(r, d, o);
      }
    }
  

  //visualising asteroids
  void update()
  {
    pushMatrix();
      noStroke();
      rotate(angle);
      translate(distance, 0, 0);
      shape(globe);
      
      if(asteroids != null)
      {
        for(int i=0; i<asteroids.length; i++)
        {
          asteroids[i].update();
        }
      }
    popMatrix();
  }
}
