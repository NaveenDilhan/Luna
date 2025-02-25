import 'package:flutter/material.dart';
import 'sequencer_grid_screen.dart'; 

class SequencerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Music'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.queue_music, size: 80, color: Colors.deepPurple),
            SizedBox(height: 20),
            Text(
              "Start Creating Your Track",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SequencerGridScreen()),
                );
              },
              child: Text("Open Sequencer"),
            ),
          ],
        ),
      ),
    );
  }
}
