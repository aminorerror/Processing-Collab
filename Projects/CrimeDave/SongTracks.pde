class Track {
  //Represents a MIDI track that has multiple EnvelopeNote Objects
  // EnvelopeNotes are Notes that have their own Envelopes
  
  //Velocity not yet implemented
  
  int c;
  String name;
  int pitch;
  boolean on = false;
  
  //IntList notes;
  ArrayList<EnvelopeNote> notes; //Array of all the currently active envelope notes
  
  // Constructors
  Track() {
     c = 0;
     name = "none";
     notes = new ArrayList<EnvelopeNote>();
  }
  Track(int c_) {
    c = c_;
    name = "none";
    //notes = new IntList();
    notes = new ArrayList<EnvelopeNote>();
  }
  Track (int c_, String name_){
    c = c_;
    name = name_;
    //notes = new IntList();
    notes = new ArrayList<EnvelopeNote>();
    
    //notes.add(new EnvelopeNote(15)); //REMOVETHISTESTONYL
  }
  
  
  //Getters and Setters
  int getChannel(){
    return c;
  }
  String getName(){
    return name; 
  }

  
  //Receive MIDI signal
  //Add or Remove pitch vased on MIDI on or MIDI off
  void noteOn(int pitch_){
    // add note to list 
      //notes.append(pitch_); 
      
      notes.add(new EnvelopeNote(pitch_));
      
  }
  void noteOff(int pitch_){
      /*
      //remove note from list on Note Off
      for (int i=0;i<notes.size();i++){
        if (notes.get(i).getPitch() == pitch_){
          notes.remove(i); 
        }
      }*/
      
      //Release note and remove once release is gone
      for (int i=0;i<notes.size();i++){
        if (notes.get(i).getPitch() == pitch_){
          
          notes.get(i).release();
          //notes.remove(i); 
        }
      }
      
  }
  
  ArrayList getNotes(){
    return notes;  
  }
  
  void getEnvelope(){
    
  };
  
  
  boolean hasPitch(int pitch_){
    //checks if note is in the list
    
    //extract Pitches from EnvelopeNote objects
    IntList tempNotes = new IntList();
    for (int i=0;i<notes.size();i++){
      tempNotes.append(notes.get(i).getPitch());
    }
    return tempNotes.hasValue(pitch_); 
  }
  void setOn(boolean on_){
    on =  on_;
  }
  boolean getOn(){
    return on;
  }
  
   EnvelopeNote getNoteByPitch(int pitch_){
     //Gets the note object
     int foundIndex=99;
     for (int i=0;i<notes.size();i++){
       if (notes.get(i).getPitch() == pitch_){
         foundIndex = i;
       }
     }
    return notes.get(foundIndex);
  }
  
   float getEnvelopeByPitch(int pitch_){
     // Helper function, returns the envelope amplitude for a given pitch
     float env = 0.0;
     
     for (int i=0;i<notes.size();i++){
       if (notes.get(i).getPitch() == pitch_){
         env = notes.get(i).getEnvelope();
       }
     }
    return env;
  }
  
  void update(){
    for (int i=0; i<notes.size(); i++){
      EnvelopeNote note = notes.get(i);
      note.update();
      
      if (note.isOff()){
        notes.remove(i);
      }
    }
  }
}