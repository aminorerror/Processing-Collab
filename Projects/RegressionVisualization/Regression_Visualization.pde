import g4p_controls.*;

// Next step, coordinate system issue
// it is really annoying that the coordinate system is inconsistent, 
// there should be ONE place that the graph is transformed.... OR do the translation for multiple entities

// make a proximity sensor for dots

// Make the Dataset more generalizable

// When selecting over a data point and there is a regression line, have the predicted value be available


Table InfantMort;

ArrayList<Country> CountryList;

Graph2D graph2D;
InfoBox infoBox;
int xPlot;
int yPlot;

int[] variable2;
int[] variable3;

float B0; //Regression coefficients
float B1;

boolean REGRESSION;

void setup(){
  size(1000,800); 
  InfantMort = loadTable("data/InfantMortality.csv");
  
  CountryList = new ArrayList<Country>();
  variable2 = new int[InfantMort.getRowCount()]; 
  variable3 = new int[InfantMort.getRowCount()]; 
  
  for (int i=0; i<InfantMort.getRowCount();i++){
    TableRow row = InfantMort.getRow(i);
    
    CountryList.add(new Country(row.getInt(0),
              row.getString(1),
              row.getInt(2),
              row.getInt(3),
              row.getInt(4),
              row.getInt(5),
              row.getInt(6)));    
              
   //variable2[i] = row.getInt(2);
   //variable3[i] = row.getInt(3);
  }
  
  
  println(CountryList.get(48).COUNTRY);
  
  
  graph2D = new Graph2D(300,100,600,0,500,0,300,10);
  
  graph2D.setRange(1, 0, 150,15);
  graph2D.setRange(0, 0, 8000,8);
  
  
  //GButton button = new GButton(this, 0,0,50,50);
  //GWindow window;
  //window =  GWindow.getWindow(this, "My Window", 100, 50, 480, 320, JAVA2D);
  
  infoBox = new InfoBox();
  
  float[] results = SimpleLinearRegression(CountryList, 0, 1);
  B0 = results[0];
  B1 = results[1];
  
  println(results);
  REGRESSION = true;
}


void draw(){
  background(125);
  

 
  //To add: automatic min and max according to VARIABLES
  // Just like SPSS, you choose the VARIABLES
  graph2D.update();

  if (REGRESSION){
    graph2D.regressionLine(B0, B1);
  }
  
  graph2D.display();
  
  infoBox.display();

  }


class InfoBox {
  
  String name = "";
  int[] msg = new int[2];
  
  InfoBox(){
    
  }
  
  void update(int id_){
    
    
    //updates based on the selected country ID
    //println(CountryList.get(id_).COUNTRY);
    
    Country country = CountryList.get(id_);
    name = country.COUNTRY;
    
    
    msg[0] = country.PCI;
    msg[1] = country.INF_MORT;

  }
  
  
  
  void display(){
    //Coordinate system
    pushMatrix();
    translate(25,100);
    
    //Draw Box
    fill(145);
    rect(0,0,200,300);
    textAlign(LEFT, TOP);
    
    
    //String label = graph2D.getSelected().label; //gets the selected thing
    
    //Fill Text
    textSize(20);
    fill(255);
    text(name,5,5);
    
    
    for (int i = 0; i<msg.length; i++){
     text(msg[i],5, 25*i+30);
    }
    
    popMatrix(); 
  }
}



class Country {
  
    int ID;
    String COUNTRY;
    int INF_MORT;
    int PCI;
    int YOUNG_MOM;
    int OLD_MOM;
    int CLOSE_BIRTHS;
    
    Country(int ID_, String COUNTRY_, int INFMORT_, int PCI_, int YOUNGMOM_, int OLDMOM_, int CLOSEBIRTHS_){
      ID = ID_;
      COUNTRY = COUNTRY_;
      INF_MORT = INFMORT_;
      PCI = PCI_;
      YOUNG_MOM = YOUNGMOM_;
      OLD_MOM = OLDMOM_;
      CLOSE_BIRTHS = CLOSEBIRTHS_;
    }
  
  }