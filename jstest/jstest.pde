// import OSC libraries
import oscP5.*;
import netP5.*;
// importd Runway library
import com.runwayml.*;
// reference to runway instance
RunwayOSC runway;



boolean generated = false;//origin set 
boolean firstTime = true;//origin set

String  textToEncode = "";//import string for the text
boolean showCursor   = true;//origin set
int     lastTime     = 0;
ArrayList < Box > Boxs = new ArrayList < Box > ();//array for boxes 
float angle; // declare the angle of box rotation 
float leftWristY;
float leftWristX;
void setup() {
  fullScreen(P3D);//set the canvas for fullscreen and 3d
   runway = new RunwayOSC(this);// setup Runway

} 


void draw() {
  background(176, 218, 185);//background color

  if (generated) { 
 
    Boxs.add(new Box());//add boxes if generated

  for (int i = 0; i < Boxs.size(); i++) {
    Box Box = Boxs.get(i);
    Box.render();//introduce function of 'render'
    Box.move();//introduce function of 'move'
    
    //check if the box is touching the lefewrist
    //if the box is touched by the leftwrist
    //the box will be removed which means it will disappear from the screen
   
     if (Box.touchingMouse()){
      Boxs.remove(i);
    i--;
    }}
  } else {
    // a screen for users to input their own content
    // set the question on the screen:"Tell us the things that you want to forget in your life:"
    fill(255);
    text("Tell us the things that you want to forget in your life, click enter to start and use your left hand to erase them:", 10, 15, width - 40, height);
    rect(0, 65, width, height);
 
    // MAKE CURSOR BLINK
    int t = millis();
    if (t - lastTime > 500) {
      showCursor = !showCursor;
      lastTime = t;
    }

    //DISPLAY USER INPUT
    fill(0);
    if (showCursor)
     text(textToEncode + "_", 10, 80, width - 40, height);
   else
      text(textToEncode, 10, 80, width - 40, height);
      
  } 
} 

class Box { 
  //indicate the declaration of boxes
  PVector position = new PVector(0, 0);
 // float size = 0;
  PVector speed = new PVector(0, 0);
  float colour;

  Box() { 
    //define the initial location of the boxes
    //define the speed of the boxes' movement according the change of its Y values
    colorMode(RGB);
        position.x = random(width);
        position.y = 0;
        speed.y = map(position.y, 0, height, 4, 60);
      
  }

  void render() {
    
    
    push();
  
   translate(position.x,position.y,random(0,10));
    stroke(map(position.y, 0, height, 239, 21), map(position.y, 0, height, 100,64), map(position.y, 0, height, 37,166),map(position.y, 0, height, 200,0));
    //define the colours of the strokes of the boxes according to the Y value
    strokeWeight(map(position.y, 0, height, 0.5, 0));
    //define the strokeWeight of the boxes according to the Y value
    rotateX(map(position.x, 0, height, 0, PI));
    rotateY(map(position.y, 0, height, 0, PI*4));
    rotateZ(-map(position.y, 0, height, 0, PI*2));
    //define the rotation angle of the boxes according to the X and Y value
    fill(map(position.y, 0, height, 50, 255),map(position.y, 0, height, 200, 100));
    //define the colours of the boxes according to the Y value
    box(map(position.y, 0, height, 70, 1));
    //define the size of the boxes according to the Y value
    lights();
    ambientLight(random(255),random(255), random(255));
    //introduce ambientLight to make the boxes more colourful
    pop();
     
  }

  void move() {
    position.y += speed.y;
  }
  //boolean is a return type, that defines what information to be sent out
  boolean touchingMouse() {
    //detect if the position of the leftwrsit is within the defined range of the box
    if (dist(position.x, position.y, leftWristX, leftWristY) < width/10 ) {
      return true;
      //if it is within the defined range
    }
    return false;
    //if it is not within the defined range
  }

}

String timeStamp() {
 return year()+nf(month(), 2)+nf(day(), 2)+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2);
} // timeStamp()



void keyPressed() {
  if (generated) { 
    // the image to save is created
    if (key=='r' || key=='R') { 
      // restart the program to be available for the next user
      generated = false;
      textToEncode = "";
    }
  } else { 
    // WAITING FOR USER INPUT
    if ((key == ENTER) || (key == RETURN)) {
      // ENCODE THE TEXT INTO A QRCODE IMAGE
      // PImage p = ZXING4P.generateQRCode(String txt,int width,int height)
      // width and height is the size of the generated image


      if (firstTime) {
        println("Press 's' to save the image to disk");
        println("Press 'r' to start again");
      }
      generated = true;      
      firstTime = false;
    } else if ((key > 31) && (key != CODED)) {
      // REGULAR CHARACTER: ADD TO STRING
      textToEncode = textToEncode + key;
    } else if ((key == BACKSPACE) && (0 < textToEncode.length())) {
      textToEncode = textToEncode.substring(0, textToEncode.length() - 1);
    }
  }
} // keyPressed() 
  

// this is called each time Processing connects to Runway
// Runway sends information about the current model

// if anything goes wrong
public void runwayErrorEvent(String message){
  println(message);
}
