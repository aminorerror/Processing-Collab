/*
Receiving MIDI messages in processing.
1) Select MIDI device you want to receive from.
    - Run the sketch and check console for list of available devices
    - change line 30 of this sketch with the number of device ou want to select:
      e.g. mymididevice = RWMidi.getInputDevices()[0].createInput(this); // listen to device number 1
      e.g. mymididevice = RWMidi.getInputDevices()[1].createInput(this); // listen to device number 0

2) Play any MIDI message from you device and see the console output
*/

import rwmidi.*;  

MidiInput mymididevice; 


 
void MIDIsetup() { 
   
// Show available MIDI input devices in console 
  MidiInputDevice devices[] = RWMidi.getInputDevices();
  
    for (int i = 0; i < devices.length; i++) { 
      println(i + ": " + devices[i].getName()); 
    } 

// Currently we assume the first device (#0) is the one we want 
  mymididevice = RWMidi.getInputDevices()[0].createInput(this); 

} 
  
Track track;
//Note ON recieved 
void noteOnReceived(Note MIDInote) {
  
    //Store pitch and change Track state to Note On
    int i = MIDInote.getChannel();
    //track = Tracks[i];
    
    
    Tracks[i].noteOn(MIDInote.getPitch()); // Send MIDI ON signal to Track object
    
    
    //track.setPitch(MIDInote.getPitch());
    //track.setOn(true);
    
    if (DEFAULT_MSG){
      println("note on " + track.getName() +" " + MIDInote.getChannel() + "  " + MIDInote.getPitch()+ "  " + MIDInote.getVelocity());
    }
}

// Note Off recieved 
void noteOffReceived(Note MIDInote) {
    if (DEFAULT_MSG){
      println("note off " + MIDInote.getChannel() + "  " + MIDInote.getPitch()+ "  " + MIDInote.getVelocity());
    }
    int i = MIDInote.getChannel();
    //Tracks[i].setOn(false);
    Tracks[i].noteOff(MIDInote.getPitch()); // Send MIDI OFF signal to Track object
}

// Program Change recieved  
void programChangeReceived(ProgramChange pc) {
    println("note off " + pc.getChannel() + "  " + pc.getNumber());
  }

// Control Change recieved 
void controllerChangeReceived(Controller cc) {
  println("cc channell is: " + cc.getChannel() + "  " + "cc number is: " + cc.getCC() + "  " + "cc value is:  " + cc.getValue() );
}

// System Exclusive recieved 
void sysexReceived(SysexMessage msg) {
  println("sysex " + msg);
}