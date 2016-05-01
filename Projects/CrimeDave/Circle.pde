

class Circle {
  float diameter;
  color c; // color
  int alpha = 255;
  
  PVector position;
  PVector velocity;
  
  Circle(float diameter_, color c_){
    diameter = diameter_;
    c = c_;
    position = new PVector(0,0);
    velocity = new PVector(0,0);
  }
  
  void update(){
      //println(bass.getNotes());

      //Preliminary BAR differences
      if (bass.hasPitch(0)){
        c = color(255,3,3,alpha);
      } else if (bass.hasPitch(1)){
        c = color(0,355,25,alpha);
      } else if (bass.hasPitch(2)){
        c = color(0,3,255,alpha);
      } else if (bass.hasPitch(3)){
        c = color(123,123,33,alpha);
      } else if (bass.hasPitch(4)){
        c = color(0,3,124,alpha); 
      }
      

      //Check for 5 and 6 and make it go up and down
      float down = bass.getEnvelopeByPitch(5); 
      float up = bass.getEnvelopeByPitch(6);
      float multiplier = 5;
      
      velocity.set(0,(down-up)*multiplier);
      
      position.add(velocity);
      //println(position);
      
      
      //Mockup
      if (bass.hasPitch(99)){
        moveLeft();
      }
      
      if (bass.hasPitch(100)){
        rotate();  
      }
  }
  
  void display(){
    pushMatrix();
    translate(width/2,height/2);
    fill(c);
    noStroke();
    
    ellipse(position.x,position.y,diameter,diameter);
    
    popMatrix();
  }
  
  //void setColor(float c_){
  //  c = c_;
  //}
}