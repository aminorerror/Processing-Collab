
boolean DEFAULT_MSG = false;

//Bass TrackBass;
//Vox TrackVox;

Track[] Tracks = new Track[7];

Track drums;
Track bass;
Track vox;
Track vox2;
Track synth;
Track bleeps;
Track glitchpad;

void setup(){
  size(600,600);
  
  MIDIsetup(); 
    
  //Create objects for each Track
  drums = Tracks[0] = new Track (0,"drums");
  bass = Tracks[1] = new Track (1,"bass");
  vox = Tracks[2] = new Track(2,"vox");
  vox2 = Tracks[3] = new Track(3,"vox2");
  synth = Tracks[4] = new Track(4,"synth");
  bleeps = Tracks[5] = new Track(5,"bleeps");
  glitchpad = Tracks[6] = new Track(6, "glitchpad");

} 
Circle bassCircle = new Circle(200,0);



void draw() {
  background(255);
    //translate(width/2,height/2);
      
      strokeWeight(2);
      stroke(0);
      line(0,height/2,width,height/2);
      
      bassCircle.update();
      bassCircle.display();
      
      bass.update();
      
      if (bass.hasPitch(5)){
        bass.getNoteByPitch(5).visualize(200);
      }
      if (bass.hasPitch(6)){
        bass.getNoteByPitch(6).visualize(-50);
      }      
      
      //Unpack Notes and update them
      
      
      //DELete below
      /*
      ArrayList<EnvelopeNote> bassNotes = bass.getNotes();

      for (int i=0; i<bassNotes.size();i++){
        EnvelopeNote note = bassNotes.get(i);
        note.update();
        
        //println(note.getEnvelope());
      }
      */
      
      
      
      
      
      
      
      
      
      
      /*
       if (bass.hasPitch(5)){
        EnvelopeNote envelopeAmp = bass.getNoteByPitch(5);
        envelopeAmp.visualize();
      } 
      
      */
      
      /*
      //Wave Vis
   
      float envelopeAmp = 0.0;
      
      if (bass.hasPitch(5)){
        envelopeAmp = bass.getEnvelopeByPitch(5);
        println(envelopeAmp);

      }
      for(int i = 1; i < width; i++) { 
        yVals[i-1] = yVals[i];
      }
      
      yVals[width-1] = envelopeAmp;
      for (int i=1; i<width; i++){
        stroke(0);
        strokeWeight(2);  
         line(i,height/2+yVals[i]*height/3*-1,i,height/2+yVals[i-1]*height/3*-1);
      }
      
      */
      //bassCircle.display();
      
      /*
      if (bass.getPitch()==5){
        println("down");
        //bassCircle.setColor(125);
      } else if (bass.getPitch()==6){
        println("up");
        //bassCircle.setColor(200);
      }
      */

   
      
      //bassCircle.display();
      //ellipse(0,0,bass.getPitch(),bass.getPitch());
   // }
    /*
    if (vox.getOn()){
      ellipse(100+vox.getPitch(),50,vox.getPitch(),vox.getPitch());
    }
    
    if (synth.getOn()){
      ellipse(-100 + synth.getPitch()*4,-50,synth.getPitch(),synth.getPitch());
    }
    */
}