ArrayList<Particle> particles;

void setup()
{
  size(600 , 600);
  particles = new ArrayList<Particle>();

}

void draw()
{
  background(0);

  for (int i=0; i < particles.size(); i++)
  {
    Particle p = particles.get(i);
    p.display();
    p.update();



    if (p.isDead())
    {
      particles.remove(i);
    }
  }
}


void mouseMoved()
{
  particles.add(new Particle());

}
