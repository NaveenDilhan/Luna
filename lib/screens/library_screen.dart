import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Library'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Saved Tracks",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Fetch saved tracks from a database later
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.music_note, color: Colors.deepPurple),
                    title: Text('Saved Track ${index + 1}'),
                    subtitle: Text('Artist ${index + 1}'),
                    onTap: () {
                      // Play saved track
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "My Playlists",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Fetch user-created playlists from a database later
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.playlist_play, color: Colors.deepPurple),
                    title: Text('Playlist ${index + 1}'),
                    subtitle: Text('Created on ${DateTime.now().year}'),
                    onTap: () {
                      // Navigate to playlist details
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
