

class Graph2D {
  int xPos, yPos;  
  int xMin, xMax; //Min and max values for the range of data
  int yMin, yMax;
  int size; // actual size of the graph
  int pointSize; // size of points
  boolean PLOT_CHANGE = true; // flags a plot change
  //boolean HOVER_FLAG = true;
  boolean pointHover;
  boolean pointSelected = false; // checks if a point was selected yet
  int selectedIndex;
   // makes sure only one point can be hovered over at a time
  
  int xSteps = 10; // For Axis scaling
  int ySteps = 10;
  
  ArrayList<Point2D> Points;
  
  Point2D selectedPoint;
  
  Graph2D(int xPos_, int yPos_, int size_, int xMin_, int xMax_, int yMin_, int yMax_, int pointSize_){
    xPos = xPos_;
    yPos = yPos_;
    //xAxisLength = xAxisLength_;
    //yAxisLength = yAxisLength_;
    xMin = xMin_;
    xMax = xMax_;
    yMin = yMin_;
    yMax = yMax_;
    size = size_;
    pointSize = pointSize_;
    
    Points = new ArrayList<Point2D>();
  }
  


  void update(){
    
    //PLOTTING
     // Flawed; the graph should have all the points already, it just needs to decide how to draw them
     if (PLOT_CHANGE){
         for (int i=0;i<CountryList.size();i++){
            Country country = CountryList.get(i);
            xPlot = country.PCI;
            yPlot = country.INF_MORT;
            
            //xPlot = variable3[i];
            //yPlot = variable2[i];
            
            graph2D.plot(i,xPlot,yPlot);
          }  
          
        PLOT_CHANGE = false;
     }
     
     
     //POINT SELECTION / INTERACTION
     //Checks for hover, takes the last one hovered and updates it as "selected"
     pointSelected = false;
     for (Point2D point: Points){
       if((point.getHover()) && (pointSelected==false)){
         point.setSelected(true); //update point to be selected
         pointSelected = true;
         
         infoBox.update(point.CaseNo); //Bases
       }  else {
         point.setSelected(false);
       }
     }

     //Clear   
     

       
  }
  
  void drawLine(float p1, float p2, float p3, float p4){
    pushMatrix();
    translate(xPos,height-yPos);
    
    stroke(0);
    line(p1,-p2,p3,-p4);
    println(p1,p2,p3,p4);
    popMatrix();
  }
  
  float convertToGraphScale(int axis, float n){
    if (axis==0){
      n = map(n,xMin,xMax,0,size);
    } else if (axis==1){
      n = map(n,yMin,yMax,0,size);
    }
    
    return n;
    
    
  }
  
  void regressionLine(float b0, float b1){
    
    IntList xList = new IntList();
    IntList yList = new IntList();
    
    // Find x0 and x(-1) to plot regression line
    for (int i=0;i<CountryList.size();i++){
        Country country = CountryList.get(i);
        xList.append(country.PCI);                 ///Specific
        yList.append(country.INF_MORT);
    }
    
    xList.sort();
    yList.sort();
    
    //println(xList);
    
    //Plug in x1 and x2 to get predicted values of y
    float x1 = xList.get(0);
    float x2 = xList.get(xList.size()-1);
    float y1 = b1*x1+b0;
    float y2 = b1*x2+b0;
    
    //println(x1,x2, "   ",y1,y2);
    
    //Convert to Pixel space and Graph Location
    x1 = convertToGraphScale(0, x1);
    x2 = convertToGraphScale(0, x2);
    y1 = convertToGraphScale(1, y1);
    y2 = convertToGraphScale(1, y2);
    
    
    //println(x1,x2, "   ",y1,y2);
    
    drawLine(x1,y1,x2,y2);
    
    
  }
  void display(){
    pushMatrix();
    translate(xPos,height-yPos);
    textAlign(CENTER, CENTER);
    textSize(12);
    
    //DRAW AXES
      //ellipse(0,0,10,10); // Origin
    fill(255);
    line(0,0,size,0); // X Axis
    line(0,0,0,-size); // Y Axis
    axisPopulate(0,xSteps); //Draw x axis Steps
    axisPopulate(1,ySteps); //Draw y axis

    //DRAW DATA POINTS
    for (int i=0; i<Points.size(); i++){
      Point2D point = Points.get(i);
      
      point.display();
      
    }

    popMatrix();
    
  }
  
  void setRange(int axis, int min_, int max_, int steps_){
    if (axis==0){
      xMin = min_;
      xMax = max_;
      xSteps = steps_;
    } else if (axis==1){
      yMin = min_;
      yMax = max_;
      ySteps = steps_;
    }
    
    
    
  }
  
  void plot(int CaseNo, int x_,int y_){
     //Plots using Default Point size 
     plot(CaseNo, x_, y_, pointSize);
  } 

  void plot(int CaseNo, int x_,int y_, int pointSize_){
  //Adds point to Graph
  
  //Convert x to graph Size
    float tempX = map(x_,xMin,xMax,0,size);
    float tempY = map(y_,yMin,yMax,0,size);
    
    //Round
    int rX = round(tempX);
    int rY = round(tempY);
    
    Points.add(new Point2D(CaseNo,rX,rY,pointSize_,xPos,yPos));
  }
  
  void axisLine(int axis, int pos, int label, int lineSize){
    if (axis == 0){ 
      //x Axis
      line(pos,-lineSize,pos,lineSize);
      text(label, pos, 20);
      
    } else if (axis == 1){
      //y Axis
      line(-lineSize,-pos,lineSize,-pos);
      text(label, -20, -pos);
    }
  }
  
  void axisLine(int axis, int pos, int label){
    axisLine(axis,pos,label,5);
  }
  
  void axisPopulate(int axis, int steps){
   // Draws axis lines for every X steps between two given points on an axis
   // Note, 2 steps will draw only 1 line in between the boundaries; 10 steps will draw 9 etc.
    int tempMin = 0;
    int tempMax = 0;
    
    //Set Axis
    if (axis == 0){ 
      tempMin = xMin;
      tempMax = xMax;
    } else if (axis == 1){
      //y Axis
      tempMin = yMin;
      tempMax = yMax;
    }
    
      // Draw Axis Boundaries first
      axisLine(axis,0,tempMin,10);
      axisLine(axis,size,tempMax,10); //Larger line height
      
      //Individual steps for DATA (used for labels)
      int rangeData = tempMax-tempMin;
      int stepData = rangeData/steps;
      
      //The actual step size to draw
      int stepGraph = size/steps;

      int tempData = 0;
      int tempGraph = 0;
      
      //Draw
      for (int i=0; i<steps-1; i++){
        tempGraph += stepGraph; // Increment position to draw
        tempData += stepData; // Increment label
        
        axisLine(axis,tempGraph,tempData);
      }
  }
  
}