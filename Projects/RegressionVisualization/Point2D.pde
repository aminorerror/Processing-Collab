
class Point2D {
  //A Graph point, not a data point
  
  int x, y, size, offsetX, offsetY, CaseNo; //Note offsets are the Graph origin offsets
  String label ="";
  boolean selected = false;
  boolean hover=false; // checks if mouse hover
  Point2D(int CaseNo_, int x_, int y_, int size_, int offsetX_, int offsetY_){
    x = x_;
    y = y_;
    size = size_;
    offsetX = offsetX_;
    offsetY = offsetY_;
    CaseNo = CaseNo_;
    
  }
  
  void update(){
  }
  
  void setSelected(boolean selected_){
    selected = selected_;
  }
  
  
  boolean getHover(){
    return checkHover(mouseX,mouseY,size);
  }
 
  //Deconstruct this code (I DIDNT WRITE IT)
  boolean checkHover(int x_, int y_, int diameter) {
    float disX = ( x + offsetX ) - x_ ;
    float disY = (y+offsetY) - (height-y_) ;
    if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    //if (height-y_>y+offsetY){
      return true;
    } else {
      return false;
    }
  }
  
  
  
  void display(){
   
    //Point
        //show name
    if (selected){
      fill(255,0,0); //Change to red
      label = CountryList.get(CaseNo).COUNTRY;  ///TODO: labels are not always drawn on top
    } else{
      label = "";
      fill(255);
    }

    ellipseMode(CENTER);
    ellipse(x,-y,size,size); //Draw point
    
    
    //Labels
    fill(0);
    textSize(10);
    textAlign(LEFT,CENTER);
    text(label,x+size,-y);
  }
}