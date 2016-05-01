//Simple effect with lines

float t;
static final int NUM_LINES = 10;

float x1Freq = 31;
float x1Amp = 15;
float y1Amp = 15;
boolean inOutFlag = false;

//int[] functionsArray {

void setup() {
  background(125);
  size(500,500);
}

void draw() {
  background(200);

  translate(width/2,height/2);
  //point(x(t),y(t));
  
 
  for (int i=0; i<NUM_LINES;i++){
    stroke(i*10,0,122);
    alpha(255-(25*i));
    strokeWeight((i+1)/5);
    
    
    line(x1(t+i), y1(t+i), x2(t+i), y2(t+i));
  //point(x1(t),y1(t));
  //point(x2(t),y2(t));
  }
  
  for (int i=0; i<NUM_LINES;i++){
    stroke(i*10,0,122);
    alpha(255-(25*i));
    strokeWeight((i+1)/5);
    
    
    line(x1(-t-i), y1(-t-i), x2(-t-i), y2(-t-i));
  //point(x1(t),y1(t));
  //point(x2(t),y2(t));
  }
  
  
  
  println(x1Amp);
  if (x1Amp > 150 && inOutFlag==false){
    inOutFlag = true;
  } else if(inOutFlag==false) {
    x1Amp +=1.5;
    y1Amp +=1.5;    
  } else if (inOutFlag){
    x1Amp -=1.5;
    y1Amp -=1.5; 
  }
  
  t+=.10;
}

void mousePressed(){
  t = 0; 
}
float x1(float t){
  return sin(t/3)*x1Amp;
}

float y1(float t){
  return cos(t/3)*y1Amp;
}

float x2(float t){
  return sin(t/3)*250; 
}

float y2(float t){
  return cos(t/3)*250; 
}

float x3(float t){
   return cos(t/3.14)*34 + sin(t/2)*233; 
}

float y3(float t){
  return sin(t/33)*222 + sin(t/33);
}


void keyPressed() {

  if ((key == 'T') || (key == 't')) {
    x1Freq-=.01;
    println(x1Freq);
  }
  if ((key == 'R') || (key == 'r')) {
    x1Freq=31.0;
  }
}

//Shark movement towards the camera
//return sin(t/50)*1*t;  
//return cos(t/10)*1*t;  

//Spiral
//return sin(t/10)*1*t;  
//return cos(t/10)*1*t;  