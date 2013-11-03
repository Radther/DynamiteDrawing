import controlP5.*;

PFont font; 
PImage canvasImage;
PImage sidebarImage;
PImage imgload;

color brushcolor;

int load = 0; 
int loadnumber = 0; 

float brushWeight = 25;
int brushRed = 0;
int brushGreen = 0;
int brushBlue = 0;

float a = 1;
float b = 2;
float c = .00001;
int Brush = 0;
int Pencil = 0;
int Eraser = 0;
int tool = 1;
int Clear = 0;
String save = "";
int Save = 0;
int savenumber = 0;
int brushsizeopen = 0;
int brushpressed = 0;

ControlP5 controlP5;
ControlFont controlFont;

void setup()
{
  initialise();
  initialiseInterface();
}

void initialise()
{
  // Initialise fonts.
  font = createFont("Georgia", 12, true);
  controlFont = new ControlFont(font, 241);
  
  // Initialise display.
  size(1280, 800);
  background(255);
  
  // Load images.
  canvasImage = loadImage("canvas.png");
  sidebarImage = loadImage("wood.png");
  
  // Render canvas.
  image(canvasImage, 0, 0);
}

void draw()
{
  pollInput();
  update();
  render();
}

void initialiseInterface()
{
  controlP5 = new ControlP5(this);
  
  controlP5.addSlider("brushWeight")
    .setPosition(1080, 720)
    .setRange(1, 100)
    .setSize(200, 80)
    .setValueLabel("size")
    .setColorBackground(color(0))
    .setColorForeground(color(200))
    .getCaptionLabel()
    .setFont(font)
    .toUpperCase(false)
  ;
  
  controlP5.addSlider("brushRed")
    .setPosition(1080,480)
    .setRange(0,255)
    .setSize(200,80)
    .setColorBackground(color(150,0,0))
    .setColorForeground(color(255,0,0))
    .setColorActive(color(255,0,0))
  ;
  
  controlP5.addSlider("brushGreen")
    .setPosition(1080,560)
    .setRange(0,255)
    .setSize(200,80)
    .setColorBackground(color(0,150,0))
    .setColorForeground(color(0,255,0))
    .setColorActive(color(0,255,0))
  ;
  
  controlP5.addSlider("brushBlue")
    .setPosition(1080,640)
    .setRange(0,255)
    .setSize(200,80)
    .setColorBackground(color(0,0,150))
    .setColorForeground(color(0,0,255))
    .setColorActive(color(0,0,255))
  ;
  
  controlP5.addButton("Clear")
    .setValue(0)
    .setPosition(1080,0)
    .setSize(200,80)
    .setColorBackground(color(0,0,0,0))
    .getCaptionLabel()
    .setFont(font)
    .toUpperCase(false)
    .setSize(24)
  ;
  ;
  
  controlP5.addButton("Brush")
    .setValue(0)
    .setPosition(1080,80)
    .setSize(200,80)
    .setColorBackground(color(0,0,0,0))
    .getCaptionLabel()
    .setFont(font)
    .toUpperCase(false)
    .setSize(24)
  ;
  ;
  
  controlP5.addButton("Pencil")
    .setValue(0)
    .setPosition(1080,160)
    .setSize(200,80)
    .setColorBackground(color(0,0,0,0))
    .getCaptionLabel()
    .setFont(font)
    .toUpperCase(false)
    .setSize(24)
  ;
  ;
  
  controlP5.addButton("Eraser")
    .setValue(0)
    .setPosition(1080,240)
    .setSize(200,80)
    .setColorBackground(color(0,0,0,0))
    .getCaptionLabel()
    .setFont(font)
    .toUpperCase(false)
    .setSize(24)
  ;
  ;
  
  controlP5.addButton("Save")
    .setValue(0)
    .setPosition(1080,320)
    .setSize(100,80)
    .setColorBackground(color(0,0,0,0))
    .getCaptionLabel()
    .setFont(font)
    .toUpperCase(false)
    .setSize(24)
  ;
  
  controlP5.addButton("Load")
    .setValue(0)
    .setPosition(1180,320)
    .setSize(100,80)
    .setColorBackground(color(0,0,0,0))
    .getCaptionLabel()
    .setFont(font)
    .toUpperCase(false)
    .setSize(24)
  ;
}

void pollInput()
{
  // If mouse pressed.
  if(mousePressed)
  {
    // If canvas pressed.
    if(mouseX > 0 && mouseX < 1080 && mouseY > 0 && mouseY < 800)
    {
      // If brush selected.
      if(tool == 1)
      {
        brushpressed = 1;
        
        smooth();
        stroke(brushcolor);
        strokeWeight(a);
        line(mouseX, mouseY, pmouseX, pmouseY);
        
        if(a < brushWeight)
        {
          a += b; 
        }
      }
      
      // If pencil selected.
      else if(tool == 2)
      {
        brushpressed = 1;
        
        smooth();
        stroke(brushcolor);
        strokeWeight(brushWeight);
        line(mouseX, mouseY, pmouseX, pmouseY);
      }
      
      // If eraser selected.
      else if(tool == 3)
      {
        brushpressed = 1;
        
        smooth();
        stroke(255, 255, 255, 100);
        strokeWeight(brushWeight);
        line(mouseX, mouseY, pmouseX, pmouseY);
      }
    }
    
    // If clear pressed.
    else if(mouseX > 1080 && mouseX < 1280 && mouseY > 0 && mouseY < 80)
    {
      fill(255);
      stroke(0);
      strokeWeight(1);
      image(canvasImage, 0, 0);
    }
    
    // If brush pressed.
    else if(mouseX > 1080 && mouseX < 1280 && mouseY > 80 && mouseY < 160)
    {
      tool = 1;
    }
    
    // If pencil pressed.
    else if(mouseX > 1080 && mouseX < 1280 && mouseY > 160 && mouseY < 240)
    {
      tool = 2;
    }
    
    // If eraser pressed.
    else if(mouseX > 1080 && mouseX < 1280 && mouseY > 240 && mouseY < 320)
    {
      tool = 3;
    }
    
    // If save pressed.
    else if(mouseX > 1080 && mouseX < 1280 && mouseY > 320 && mouseY < 400)
    {
      savenumber = savenumber + 1;
      
      fill(255);
      rect(1080,0,1000,1000);
      save("/sdcard/DCIM/"+savenumber+".png");
    }
    
    // If load pressed.
    else if(mouseX > 1080 && mouseX < 1280 && mouseY > 400 && mouseY < 480)
    {
      if(loadnumber == savenumber)
      {
        loadnumber = 0;
      }
      
      loadnumber = loadnumber + 1;
      imgload = loadImage("/sdcard/DCIM/"+loadnumber+".png");
      
      image(imgload, 0, 0);
    }
  }
  
  // If mouse not pressed.
  else
  {
    brushpressed = 0;
    a = 1;
  }
}

void update()
{
  brushcolor = color(brushRed, brushGreen, brushBlue);
}


void render()
{
  // Limit frame rate.
  frameRate(60);
  
  // Render canvas.
  noStroke();
  fill(255);
  rect(1080, 400, 1000, 1000);
  
  // Render sidebar.
  image(sidebarImage, 1200, 0);
  text("Clear", 1220, 20);
  text("Brush", 1220, 60);
  text("Pencil", 1220, 100);
  text("Eraser", 1220, 140);
  text("Save", 1220, 180);
  
  // Render colour square.
  noStroke();
  fill(brushcolor);
  rect(1080, 400, 200, 80);
}
