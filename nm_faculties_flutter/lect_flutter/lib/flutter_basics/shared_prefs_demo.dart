import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: const SharedPrefsDemo()));
}

/// A single-file simple example demonstrating how to use SharedPreferences in Flutter.
///
/// Features demonstrated:
/// - Saving String, int, and bool values to local storage
/// - Reading stored values on app initialization
/// - Updating values
/// - Removing specific keys or clearing all stored data
class SharedPrefsDemo extends StatefulWidget {
  const SharedPrefsDemo({super.key});

  @override
  State<SharedPrefsDemo> createState() => _SharedPrefsDemoState();
}

class _SharedPrefsDemoState extends State<SharedPrefsDemo> {
  // Keys for SharedPreferences
  static const String _keyUsername = 'username';
  static const String _keyCounter = 'counter';
  static const String _keyDarkMode = 'is_dark_mode';

  final TextEditingController _nameController = TextEditingController();

  String _savedName = '';
  int _counter = 0;
  bool _isDarkMode = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// Load all saved preferences when the screen loads
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedName = prefs.getString(_keyUsername) ?? '';
      _counter = prefs.getInt(_keyCounter) ?? 0;
      _isDarkMode = prefs.getBool(_keyDarkMode) ?? false;
      _nameController.text = _savedName;
      _isLoading = false;
    });
  }

  /// Save username (String)
  Future<void> _saveUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, _nameController.text);
    setState(() {
      _savedName = _nameController.text;
    });
    _showSnackBar('Username saved!');
  }

  /// Save counter (int)
  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    final newCounter = _counter + 1;
    await prefs.setInt(_keyCounter, newCounter);
    setState(() {
      _counter = newCounter;
    });
  }

  /// Save dark mode toggle (bool)
  Future<void> _toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, value);
    setState(() {
      _isDarkMode = value;
    });
  }

  /// Clear all saved preferences
  Future<void> _clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      _savedName = '';
      _counter = 0;
      _isDarkMode = false;
      _nameController.clear();
    });
    _showSnackBar('All preferences cleared!');
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SharedPreferences Demo'),
          centerTitle: true,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Card 1: Save String (Username)
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Save String Example',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Enter your name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: _saveUsername,
                              icon: const Icon(Icons.save),
                              label: const Text('Save Name'),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Stored Name: ${_savedName.isEmpty ? "(None)" : _savedName}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Card 2: Save Int (Counter)
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Save Int Example',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Counter Value: $_counter',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                ElevatedButton.icon(
                                  onPressed: _incrementCounter,
                                  icon: const Icon(Icons.add),
                                  label: const Text('Increment'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Card 3: Save Bool (Theme Toggle)
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Save Bool Example',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SwitchListTile(
                              title: const Text('Dark Mode Preference'),
                              value: _isDarkMode,
                              onChanged: _toggleDarkMode,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Clear Preferences Button
                    OutlinedButton.icon(
                      onPressed: _clearPreferences,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.delete_forever),
                      label: const Text(
                        'Clear All Preferences',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
