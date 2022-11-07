
let x,y,h,s,sizeMap;
let generate = false;
let firstTime = true;
let showCursor = false;
let textToEncode = "";
let lastTime = 0;
var input;



function setup(){
	createCanvas(windowWidth, windowHeight);
   x = millis();
   colorMode(HSB);
    resetsketch();
  let generate = false;
  var button= createButton("reset");
  button.mousePressed(resetsketch);

}
function resetsketch(){
  input = createInput();
  input.position(20, 30);
  
  for (let i = 0; i < width; i++) {
    let redAmount = map(i, 0, width, 200, 300);
    stroke(redAmount, 50, 50);
    

	line(i, 0, i, height);
    
    
   
   }
  

    
 
 
 
   

    //DISPLAY USER INPUT
    fill(55);
    
      text(key, 10, 80, width - 40, height);
  
  generate=false;
}

function draw(){
  
if (generate===true) {
  
   
  {let y = map(noise(frameCount*0.01),0,1,0,height) ;

  
  h=map(noise(frameCount*0.01),0,1,120,300);
  s=map(noise(frameCount*0.01),0,1,50,100);
  
  
   noStroke();
   fill(h,s,100);   
   ellipse(x, y, 2);
   x+=1;
  if(x>width){x=0;}}

    
}
 
      
  
}

  
    
  

function keyTyped() {
  if (generate===true) { 
    // the image to save is created
    if (key==='s' || key==='S') { 
      // save the generated image with a filename that show the time of the it happened
       let timeStamp = year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-" + nf(millis(), 3, 0);
  	save(timeStamp + 'png');
    } else if (key==='r' || key==='R') { 
      
      createCanvas(windowWidth, windowHeight);
  
  for (let i = 0; i < width; i++) {
    let redAmount = map(i, 0, width, 200, 300);
    stroke(redAmount, 50, 50);
    

	line(i, 0, i, height);
    
    
    frameRate(100);
  
    
   x = millis();
    colorMode(HSB);}
      // restart the program to be available for the next user
      generate = false;
      textToEncode = "";
    }}
   else { 
    // WAITING FOR USER INPUT
    if(keyCode === ENTER) {
       textSize(30);
  var name = input.value();
  
    fill(random(255));
    text(name, random(width), random(height));
    
      
      

     

      generate = true;      
      firstTime = false;
   
      }
   }
  
} // keyPressed() 

