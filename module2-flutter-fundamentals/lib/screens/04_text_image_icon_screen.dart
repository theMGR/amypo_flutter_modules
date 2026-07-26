import 'package:flutter/material.dart';

// Session 4 — Basic UI components: Text, Image, Icon (+ CircleAvatar).

class TextImageIconScreen extends StatelessWidget {
  const TextImageIconScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('04 - Text, Image, Icon')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Text styling:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Default text'),
          const Text('Bold + colored', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
          const Text(
            'Italic, larger, letter-spaced',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18, letterSpacing: 1.2),
          ),
          const Text(
            'Long text truncates with an ellipsis when it overflows its line instead of wrapping forever, forever, forever',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 24),

          const Text('Icon sizing & color:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.favorite, color: Colors.red, size: 20),
              SizedBox(width: 12),
              Icon(Icons.favorite, color: Colors.red, size: 32),
              SizedBox(width: 12),
              Icon(Icons.favorite, color: Colors.red, size: 48),
            ],
          ),
          const SizedBox(height: 24),

          const Text('Image + CircleAvatar (profile-card style):', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.indigo,
                child: Icon(Icons.person, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Jane Doe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('Flutter Developer'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          const Text('Image.network with loading/error handling:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : const Center(child: CircularProgressIndicator()),
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.broken_image, size: 48, color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }
}
