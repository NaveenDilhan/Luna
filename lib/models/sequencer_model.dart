import 'package:flutter/scheduler.dart'; // For handling timing and frame-based updates
import 'package:audioplayers/audioplayers.dart'; // For audio playback
import 'package:shared_preferences/shared_preferences.dart'; // For saving and loading sequence data
import 'package:flutter/material.dart'; // For Flutter UI components

class SequencerModel extends ChangeNotifier {
  bool isPlaying = false; // Tracks if the sequencer is currently playing
  int currentStep = 0; // Tracks the current step in the sequence
  double tempo = 120.0; // The tempo (beats per minute) of the sequencer
  late Ticker _ticker; // Ticker for controlling the time-based sequence
  final AudioPlayer _audioPlayer = AudioPlayer(); // Audio player instance for playing notes

  static const int numSteps = 16; // Number of steps in the sequencer grid
  static const int numNotes = 8; // Number of notes (rows in the grid)
  final List<bool> grid = List.generate(numSteps * numNotes, (index) => false); // Sequencer grid, with each cell being a note on/off state

  String selectedInstrument = 'Piano'; // The currently selected instrument
  String currentNote = 'C4'; // The note that is currently being played

  final Map<String, String> noteToSound = {}; // A map of notes to their corresponding sound file paths
  final List<String> notes = ['C4', 'D4', 'E4', 'F4', 'G4', 'A4', 'B4', 'C5']; // List of possible notes

  // Constructor for initializing the sequencer model, it takes a TickerProvider to create a ticker
  SequencerModel({required TickerProvider tickerProvider}) {
    _ticker = tickerProvider.createTicker((elapsed) {
      // Calculates the current step based on elapsed time and tempo
      int step = (elapsed.inMilliseconds ~/ (60000 ~/ tempo ~/ numSteps)) % numSteps;
      
      if (step != currentStep) {
        currentStep = step;
        // For each note, check if the current step has it enabled, and play the note
        for (int i = 0; i < numNotes; i++) {
          int index = currentStep + (i * numSteps); // Index in the grid for the note
          if (grid[index]) {
            _playNote(notes[i]); // Play the note if it's active
            currentNote = notes[i]; // Update the current note
          }
        }
        notifyListeners(); // Notify the listeners to update the UI
      }
    });
    _updateInstrumentSounds(); // Initialize the sound mappings based on the selected instrument
  }

  // Toggles the state of a specific note in the grid (on/off)
  void toggleNote(int index) {
    grid[index] = !grid[index]; // Switch the state of the note
    notifyListeners(); // Notify the listeners to update the UI
  }

  // Plays a specific note sound by looking it up in the noteToSound map
  Future<void> _playNote(String note) async {
    if (!noteToSound.containsKey(note)) return; // If no sound is assigned for the note, do nothing
    try {
      // Attempt to play the sound for the note
      await _audioPlayer.play(AssetSource(noteToSound[note]!));
    } catch (e) {
      debugPrint('Error playing $note: $e'); // Log any error that occurs during playback
    }
  }

  // Starts the sequencer, resetting the step counter and beginning the ticker
  void startSequencer() {
    if (isPlaying) return; // If it's already playing, do nothing
    isPlaying = true;
    currentStep = 0;
    _ticker.start(); // Start the ticker to begin processing the sequence
    notifyListeners(); // Notify listeners to update the UI
  }

  // Stops the sequencer, halting the ticker and resetting the step counter
  void stopSequencer() {
    _ticker.stop(); // Stop the ticker
    isPlaying = false; // Mark as not playing
    currentStep = 0; // Reset the current step
    notifyListeners(); // Notify listeners to update the UI
  }

  // Updates the tempo of the sequencer and notifies listeners
  void updateTempo(double newTempo) {
    tempo = newTempo;
    notifyListeners(); // Notify listeners to update the UI
  }

  // Saves the current sequence (grid) to SharedPreferences for persistence
  Future<void> saveSequence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); // Get an instance of SharedPreferences
    await prefs.setString('sequence', grid.join(',')); // Save the grid as a comma-separated string
  }

  // Loads a previously saved sequence from SharedPreferences
  Future<void> loadSequence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); // Get an instance of SharedPreferences
    String? savedSequence = prefs.getString('sequence'); // Retrieve the saved sequence
    if (savedSequence != null) {
      grid.setAll(0, savedSequence.split(',').map((e) => e == 'true')); // Populate the grid with the saved state
      notifyListeners(); // Notify listeners to update the UI
    }
  }

  // Updates the selected instrument and reinitializes the sound mappings
  void updateInstrument(String instrument) {
    selectedInstrument = instrument; // Set the new instrument
    _updateInstrumentSounds(); // Reinitialize the instrument sounds
    notifyListeners(); // Notify listeners to update the UI
  }

  // Updates the note-to-sound mapping based on the selected instrument
  void _updateInstrumentSounds() {
    noteToSound.clear(); // Clear any existing note-to-sound mappings
    String path = selectedInstrument.toLowerCase(); // Use the instrument name as the folder path
    for (String note in notes) {
      noteToSound[note] = '$path/$note.wav'; // Assign each note to its respective sound file
    }
  }

  // Dispose of resources (ticker and audio player) when the model is no longer needed
  void dispose() {
    _ticker.dispose(); // Dispose the ticker
    _audioPlayer.dispose(); // Dispose the audio player
    super.dispose(); // Call the parent dispose method
  }
}
