import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:luna/widgets/instrument_selector.dart';
import 'package:luna/widgets/sequencer_grid.dart';
import '../models/sequencer_model.dart';

class SequencerGridScreen extends StatefulWidget {
  @override
  _SequencerGridScreenState createState() => _SequencerGridScreenState();
}

class _SequencerGridScreenState extends State<SequencerGridScreen> with SingleTickerProviderStateMixin {
  late SequencerModel _sequencer;
  double _tempo = 120.0;
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    _sequencer = SequencerModel(tickerProvider: this);
  }

  @override
  void dispose() {
    _sequencer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _sequencer,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Music Sequencer"),
          backgroundColor: Colors.deepPurpleAccent,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Consumer<SequencerModel>(
              builder: (context, sequencer, child) {
                return InstrumentSelector(
                  selectedInstrument: sequencer.selectedInstrument,
                  onInstrumentChanged: sequencer.updateInstrument,
                );
              },
            ),
            Consumer<SequencerModel>(
              builder: (context, sequencer, child) {
                return Slider(
                  value: _tempo,
                  min: 60.0,
                  max: 180.0,
                  divisions: 12,
                  label: '${_tempo.round()} BPM',
                  onChanged: (newTempo) {
                    setState(() {
                      _tempo = newTempo;
                      sequencer.updateTempo(newTempo);
                    });
                  },
                );
              },
            ),
            _buildDropdownMenu(),
            Expanded(child: SequencerGrid()),
            Consumer<SequencerModel>(
              builder: (context, sequencer, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildControlButton(
                      icon: sequencer.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.green,
                      onPressed: () {
                        sequencer.isPlaying ? sequencer.stopSequencer() : sequencer.startSequencer();
                      },
                    ),
                    const SizedBox(width: 20),
                    _buildControlButton(
                      icon: Icons.stop,
                      color: Colors.red,
                      onPressed: sequencer.stopSequencer,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({required IconData icon, required Color color, required void Function() onPressed}) {
    return IconButton(
      icon: Icon(icon),
      color: color,
      onPressed: onPressed,
    );
  }

  Widget _buildDropdownMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButton<String>(
        value: selectedOption,
        onChanged: (String? newValue) {
          setState(() {
            selectedOption = newValue;
            if (newValue == 'Create Blank Song') {
              _sequencer.clearGrid();
            } else if (newValue == 'Export MP3') {
              // Implement MP3 export logic
            } else if (newValue == 'Upload Song') {
              // Implement song upload logic
            }
          });
        },
        hint: const Text("Select an option"),
        items: <String>['Create Blank Song', 'Export MP3', 'Upload Song']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
