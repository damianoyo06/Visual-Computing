Graph graph;
float[] i, h, p;
int n;
String[] c, reg;
String hoveredRegion = ""; // Keeps track of the hovered region
String hoveredCountry = ""; // Stores the country name when hovering
Table table;

void setup()
{
  size(1200, 800);
  graph = new Graph();
  table = loadTable("health-income.csv", "header");
  background(255);
  rectMode(CENTER);
    
  n = table.getRowCount();
  i = new float[n];
  h = new float[n];
  p = new float[n];
  c = new String[n];
  reg = new String[n];
  

  for (int j = 0; j < n; j++) {
    TableRow row = table.getRow(j);
    c[j] = row.getString("country");
    reg[j] = row.getString("region");
    i[j] = row.getFloat("income");
    h[j] = row.getFloat("health");
    p[j] = row.getFloat("population");
  }
}

void draw()
{
  background(255);
  graph.legend();
  graph.display();
  hoveredCountry = ""; // Reset hovered country

  // Determine if hovering over legend items
  updateHoveredRegion();

  for (int j = 0; j < n; j++) 
  {
    float x = map(log(i[j]), log(300), log(128000), 100, 1150);
    float y = map(h[j], 0, 100, 600, 0);
    float radius = map(p[j], 500000, 1500000000, 5, 100); // Reduced max size

    // Determine bubble color
    setBubbleColor(reg[j]);

    // Draw only if hovering over the right region
    if (hoveredRegion.equals("") || reg[j].contains(hoveredRegion)) 
    {
      stroke(0);
      strokeWeight(1);
      ellipse(x, y, radius * 2, radius * 2); 

      // Check if mouse is inside the bubble
      float d = dist(mouseX, mouseY, x, y);
      if (d < radius)
      {
        hoveredCountry = c[j];
      }
    }
  }

  // Display hovered country near the cursor
  if (!hoveredCountry.equals("")) 
  {
    float textWidth = textWidth(hoveredCountry);
    fill(255);
    rect(mouseX, mouseY - 15, textWidth, 30);
    fill(0);
    textSize(16);

    text(hoveredCountry, mouseX, mouseY - 10);
  }
}

void updateHoveredRegion()
{
  if (mouseX >= 10 && mouseX <= 120 && mouseY >= 700 && mouseY <= 720)
  {
    hoveredRegion = "ASIA";
  } 
  else if (mouseX >= 10 && mouseX <= 120 && mouseY >= 740 && mouseY <= 760)
  {
    hoveredRegion = "EUROPE";
  } 
  else if (mouseX >= 150 && mouseX <= 340 && mouseY >= 700 && mouseY <= 720)
  {
    hoveredRegion = "AFRICA";
  }
  else if (mouseX >= 150 && mouseX <= 340 && mouseY >= 740 && mouseY <= 760)
  {
    hoveredRegion = "AMER";
  }
  else if (mouseX >= 370 && mouseX <= 590 && mouseY >= 700 && mouseY <= 720)
  {
    hoveredRegion = "OCEANIA";
  }
  else if (mouseX >= 370 && mouseX <= 590 && mouseY >= 740 && mouseY <= 760)
  {
    hoveredRegion = "STATES";
  }
  else
  {
    hoveredRegion = "";
  }
}

void setBubbleColor(String region)
{
 
  if (region.contains("NEAR EAST"))
  {
    fill(255, 223, 0, 123);
  } 
  else if (region.contains("EUROPE"))
  {
    fill(0, 0, 255, 123);
  }
  else if (region.contains("AFRICA"))
  {
    fill(139, 69, 19, 123);
  }
  else if (region.contains("AMER"))
  {
    fill(34, 139, 34, 123);
  }
  else if (region.contains("STATES"))
  {
    fill(128, 0, 128, 123);
  }
  else if (region.contains("OCEANIA"))
  {
    fill(30, 144, 255, 123);
  }
  else if (region.contains("ASIA"))
  {
    fill(255, 223, 0, 123);
  }
}
