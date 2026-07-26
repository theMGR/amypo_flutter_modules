import 'package:flutter/material.dart';

// Session 7 — Navigation & structure (expanded widget set): AppBar, Drawer,
// BottomNavigationBar, SnackBar, AlertDialog, Navigator push/pop with result.

class NavigationStructureScreen extends StatefulWidget {
  const NavigationStructureScreen({super.key});

  @override
  State<NavigationStructureScreen> createState() => _NavigationStructureScreenState();
}

class _NavigationStructureScreenState extends State<NavigationStructureScreen> {
  int _bottomIndex = 0;
  String? _lastResult;

  Future<void> _openDetailScreen() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const DetailScreen()),
    );
    if (result != null) {
      setState(() => _lastResult = result);
    }
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('This is a SnackBar')),
    );
  }

  Future<void> _showAlertDialog() async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AlertDialog'),
        content: const Text('This is a confirmation dialog.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('07 - Navigation & Structure')),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(child: Text('Menu')),
            ListTile(leading: Icon(Icons.home), title: Text('Home')),
            ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: (index) => setState(() => _bottomIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selected bottom tab: $_bottomIndex'),
            const SizedBox(height: 8),
            if (_lastResult != null) Text('Result from detail screen: $_lastResult'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _openDetailScreen, child: const Text('Push detail screen (returns a result)')),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _showSnackBar, child: const Text('Show SnackBar')),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _showAlertDialog, child: const Text('Show AlertDialog')),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context, 'Hello from DetailScreen'),
          child: const Text('Pop with a result'),
        ),
      ),
    );
  }
}
