import 'package:flutter/material.dart';
import 'sequencer_grid_screen.dart'; 

class SequencerScreen extends StatelessWidget {
  const SequencerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Music'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.queue_music, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 20),
            const Text(
              "Start Creating Your Track",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SequencerGridScreen()),
                );
              },
              child: const Text("Open Sequencer"),
            ),
          ],
        ),
      ),
    );
  }
}
