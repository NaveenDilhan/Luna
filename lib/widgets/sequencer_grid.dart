import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sequencer_model.dart';

class SequencerGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SequencerModel>(
      builder: (context, sequencer, child) {
        return Column(
          children: [
            for (int i = 0; i < SequencerModel.numNotes; i++)
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      sequencer.notes[i],
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: SequencerModel.numSteps,
                      ),
                      itemCount: SequencerModel.numSteps,
                      itemBuilder: (context, step) {
                        int index = step + (i * SequencerModel.numSteps);
                        bool isPlayingStep = step == sequencer.currentStep;

                        return GestureDetector(
                          onTap: () {
                            sequencer.toggleNote(index);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            decoration: BoxDecoration(
                              color: sequencer.isPlaying && isPlayingStep
                                  ? Colors.orange.withOpacity(0.5) // Highlighted column only when playing
                                  : (sequencer.grid[index] ? Colors.blue : Colors.grey[800]),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
