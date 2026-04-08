import peasy.*;

PeasyCam cam;

PImage sunTexture;
PImage moonTexture;
PImage stars;
PImage[] textures = new PImage[8];

Planet sun;
KuiperBelt kuiperBelt; 


Planet selectedPlanet = null;

void setup()
{
  size(600, 600, P3D);
  
  //textures
  stars = loadImage("texture/stars.jpg");
  
  sunTexture = loadImage("texture/sun.jpg");
  moonTexture = loadImage("texture/moon.jpg");
  
  textures[0] = loadImage("texture/mercury.jpg");
  textures[1] = loadImage("texture/venus.jpg");
  textures[2] = loadImage("texture/earth.jpg");
  textures[3] = loadImage("texture/mars.jpg");
  textures[4] = loadImage("texture/jupiter.jpg");
  textures[5] = loadImage("texture/saturn.jpg");
  textures[6] = loadImage("texture/uranus.jpg");
  textures[7] = loadImage("texture/neptune.jpg");
  
  //camera
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(400);
  cam.setMaximumDistance(4000);

  //sun + planets (and moon)
  sun = new Planet(200, 0, 0, sunTexture);
  sun.spawnPlanets(7);

  //asteroids
  kuiperBelt = new KuiperBelt(20, 0, 500);  
  kuiperBelt.spawnAsteroids(175);
  

}

void draw()
{

  //background image
  background(stars);

  // lights
  pointLight(255, 200, 100,  0,  0,  500); 
  pointLight(255, 200, 100,  0,  0, -500);  
  pointLight(255, 200, 100,  500, 0, 0);   
  pointLight(255, 200, 100, -500, 0, 0);    
  pointLight(255, 200, 100, 0, 500, 0);     
  pointLight(255, 200, 100, 0, -500, 0);  

  ambientLight(80, 60, 40); 


  //plantens with sun and moon visualised with the orbiting and rotation lines
  sun.show();
  sun.orbit();
  sun.orbitLines();

  //visualisation of asteroids
  kuiperBelt.update();
  kuiperBelt.spin();
  
}
