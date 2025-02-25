import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/sequencer_grid.dart';
import '../widgets/instrument_selector.dart';
import '../models/sequencer_model.dart';

class SequencerGridScreen extends StatefulWidget {
  @override
  _SequencerGridScreenState createState() => _SequencerGridScreenState();
}

class _SequencerGridScreenState extends State<SequencerGridScreen> with SingleTickerProviderStateMixin {
  late SequencerModel _sequencer;
  double _tempo = 120.0;

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
                  label: '$_tempo BPM',
                  onChanged: (newTempo) {
                    setState(() {
                      _tempo = newTempo;
                      sequencer.updateTempo(newTempo);
                    });
                  },
                );
              },
            ),
            Expanded(child: SequencerGrid()), // 
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

  Widget _buildControlButton({required IconData icon, required Color color, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(15), backgroundColor: color),
      child: Icon(icon, size: 30, color: Colors.white),
    );
  }
}
