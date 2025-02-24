import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover Music'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Trending Tracks",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.music_note, color: Colors.deepPurple),
                    title: Text('Track ${index + 1}'),
                    subtitle: Text('Artist ${index + 1}'),
                    onTap: () {
                      // Navigate to music player
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Recently Added",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.library_music, color: Colors.deepPurple),
                    title: Text('New Track ${index + 1}'),
                    subtitle: Text('New Artist ${index + 1}'),
                    onTap: () {
                      // Navigate to music player
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
