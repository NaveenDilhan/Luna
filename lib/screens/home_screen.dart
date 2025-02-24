import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Music'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Trending Tracks",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:
                        const Icon(Icons.music_note, color: Colors.deepPurple),
                    title: Text('Track ${index + 1}'),
                    subtitle: Text('Artist ${index + 1}'),
                    onTap: () {
                      // Navigate to music player
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Recently Added",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.library_music,
                        color: Colors.deepPurple),
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
