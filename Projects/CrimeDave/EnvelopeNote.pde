class EnvelopeNote{
  
  //PVector envelope;
  int pitch;
  int attack, decay, sustain, release;
  int state;
  float pct = 0.0;
  float step = .01;
  int exponent = 2; // for curves
  
  
  float[] envelope = new float[4]; // Stores Attack, Decay, Sustain, Release
  float[] yVals = new float[width]; // for the Visualizer
  
  EnvelopeNote(int pitch_){
    pitch = pitch_;
    
    envelope[0] = .02; //Attack
    envelope[1] = .2; //Decay
    envelope[2] = .5; //Sustain
    envelope[3] = .1; //Release
 
    pct=0.0;
  }
  
  
  int getPitch(){
    return pitch;
  }
  
  void release(){
    state=3; 
  }
  void update(){
    
    //for (int i=0;i<envelope.length;i++){
    //}
    
    //Achieve CURVES?

    if (state<3){
      
      if (state==0){
        //Attack
        pct +=step/envelope[0];
        
        if (pct>1.0){
          //Exit Condition
          pct =1.0;
          state++;
        }
        
      } else if (state==1){  
        //Decay
        pct -= step/envelope[1]; 
        
        if (pct<=envelope[2]){
          //Check if below sustain threshold
          pct = envelope[2]; //set to sustain
          state++;
        }
      } else if (state==2){
        //println("ff");
      }

    } else if (state==3){
      pct -= step/envelope[3];
      
      if (pct<0){
        state=4; // Flag for Removal
      }
      //println("release"); 
    }
    
   
      
  }
  
  boolean isOff(){
    return state==4; 
  }
  
  float getEnvelope(){
    //Returns the amplitude of the envelope
    return pct; 
  }
  
  void visualize(int offset){
      println(pct);
      //Wave Vis
      for(int i = 1; i < width; i++) { 
        yVals[i-1] = yVals[i];
      }
      
      yVals[width-1] = pct;
      for (int i=1; i<width; i++){
        stroke(0);
        strokeWeight(2);  
        line(i,offset+height/2+yVals[i]*height/3*-1,i,offset+height/2+yVals[i-1]*height/3*-1);
      }
  }
}