class Particle
{
  float  xPos, yPos, xVel, yVel, radius, lifespan, g;
  Particle()
  {
    xPos = mouseX;
    yPos = mouseY;
    yVel = random(-1, 1);
    xVel = random(-1, 1);
   
    radius = random(10, 30);
    g = random(0, 255);
    lifespan = 255;
  }

  void display()
  {
    
    stroke(0, lifespan);
    fill(0, g, 255, lifespan);
    circle(xPos, yPos, radius);

  }

  void update()
  {
    xPos = xPos + xVel;
    yPos = yPos + yVel;
    lifespan = lifespan - 1;
  
    if(xPos < 0 || xPos > width)
    {
      xVel = xVel *-1;
    }
    if(yPos < 0 || yPos > height)
    {
      yVel = yVel *-1;
    }

  }
  
  boolean isDead()
  {
    if(lifespan <=0)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}
