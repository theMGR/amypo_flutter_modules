// common_widgets_demo.dart
// A single-file Flutter app demonstrating the most commonly used widgets.
// Run with: flutter create demo && replace lib/main.dart with this file,
// then `flutter run`.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Common Widgets Demo',
      theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

// ---------------------------------------------------------------------------
// HOME SCREEN — Scaffold, AppBar, Drawer, BottomNavigationBar, FAB
// ---------------------------------------------------------------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  final List<Widget> _pages = const [
    WidgetGallery(),
    TabsAndPagesDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Common Widgets Demo'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                setState(() => _navIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tab),
              title: const Text('Tabs & Pages'),
              onTap: () {
                setState(() => _navIndex = 1);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_navIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.widgets), label: 'Gallery'),
          BottomNavigationBarItem(icon: Icon(Icons.tab), label: 'Tabs'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FAB pressed — SnackBar shown')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET GALLERY — scrollable list of common widget demos
// ---------------------------------------------------------------------------
class WidgetGallery extends StatefulWidget {
  const WidgetGallery({super.key});

  @override
  State<WidgetGallery> createState() => _WidgetGalleryState();
}

class _WidgetGalleryState extends State<WidgetGallery> {
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // State values
  bool _isChecked = false;
  bool _isSwitchOn = false;
  double _sliderValue = 20;
  int _radioValue = 1;
  String? _dropdownValue = 'One';

  final List<String> _items =
      List.generate(15, (index) => 'List item ${index + 1}');

  @override
  void dispose() {
    _nameController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm'),
        content: const Text('This is an AlertDialog example.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Text & Icon'),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.amber),
              SizedBox(width: 8),
              Text(
                'Hello Flutter',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          _sectionTitle('Container'),
          Container(
            width: 100,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('Box', style: TextStyle(color: Colors.white)),
          ),

          _sectionTitle('Row, Column & Expanded'),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(height: 40, color: Colors.red[300]),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Container(height: 40, color: Colors.blue[300]),
              ),
            ],
          ),

          _sectionTitle('Stack'),
          SizedBox(
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(width: 100, height: 100, color: Colors.grey[300]),
                const Positioned(
                  bottom: 8,
                  right: 8,
                  child: Icon(Icons.edit, color: Colors.black87),
                ),
              ],
            ),
          ),

          _sectionTitle('Wrap & Chip'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Chip(label: Text('Dart')),
              Chip(label: Text('Flutter')),
              Chip(label: Text('Mobile')),
            ],
          ),

          _sectionTitle('Buttons'),
          Wrap(
            spacing: 8,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Elevated'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Text Button'),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
              ),
            ],
          ),

          _sectionTitle('GestureDetector & InkWell'),
          Row(
            children: [
              GestureDetector(
                onTap: () => debugPrint('GestureDetector tapped'),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.orange[100],
                  child: const Text('Tap (Gesture)'),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => debugPrint('InkWell tapped'),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.orange[100],
                  child: const Text('Tap (InkWell)'),
                ),
              ),
            ],
          ),

          _sectionTitle('TextField with Controller'),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Enter name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => debugPrint('Typed: $value'),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => debugPrint(_nameController.text),
                child: const Text('Read value'),
              ),
              ElevatedButton(
                onPressed: () => _nameController.clear(),
                child: const Text('Clear'),
              ),
            ],
          ),

          _sectionTitle('Form & TextFormField'),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required';
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      debugPrint('Form is valid');
                    }
                  },
                  child: const Text('Validate'),
                ),
              ],
            ),
          ),

          _sectionTitle('Checkbox & Switch'),
          Row(
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (val) => setState(() => _isChecked = val!),
              ),
              const Text('Checkbox'),
              const SizedBox(width: 16),
              Switch(
                value: _isSwitchOn,
                onChanged: (val) => setState(() => _isSwitchOn = val),
              ),
              const Text('Switch'),
            ],
          ),

          _sectionTitle('Radio'),
          Row(
            children: [
              Radio<int>(
                value: 1,
                groupValue: _radioValue,
                onChanged: (val) => setState(() => _radioValue = val!),
              ),
              const Text('Option 1'),
              Radio<int>(
                value: 2,
                groupValue: _radioValue,
                onChanged: (val) => setState(() => _radioValue = val!),
              ),
              const Text('Option 2'),
            ],
          ),

          _sectionTitle('Slider'),
          Slider(
            value: _sliderValue,
            min: 0,
            max: 100,
            divisions: 5,
            label: _sliderValue.round().toString(),
            onChanged: (val) => setState(() => _sliderValue = val),
          ),

          _sectionTitle('DropdownButton'),
          DropdownButton<String>(
            value: _dropdownValue,
            items: ['One', 'Two', 'Three']
                .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                .toList(),
            onChanged: (val) => setState(() => _dropdownValue = val),
          ),

          _sectionTitle('Card'),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text('Card content'.toUpperCase()),
            ),
          ),

          _sectionTitle('ExpansionTile'),
          ExpansionTile(
            title: const Text('More info'),
            children: const [
              ListTile(title: Text('Detail 1')),
              ListTile(title: Text('Detail 2')),
            ],
          ),

          _sectionTitle('Progress Indicators'),
          const Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Expanded(child: LinearProgressIndicator(value: 0.6)),
            ],
          ),

          _sectionTitle('AlertDialog & SnackBar'),
          Wrap(
            spacing: 8,
            children: [
              ElevatedButton(
                onPressed: _showAlertDialog,
                child: const Text('Show AlertDialog'),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a SnackBar')),
                  );
                },
                child: const Text('Show SnackBar'),
              ),
            ],
          ),

          _sectionTitle('ListView.builder (fixed height)'),
          SizedBox(
            height: 150,
            child: ListView.separated(
              itemCount: _items.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) => ListTile(
                title: Text(_items[index]),
              ),
            ),
          ),

          _sectionTitle('GridView.builder (fixed height)'),
          SizedBox(
            height: 150,
            child: GridView.builder(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => Container(
                color: Colors.teal[100 * ((index % 8) + 1)] ?? Colors.teal,
                alignment: Alignment.center,
                child: Text('${index + 1}'),
              ),
            ),
          ),

          _sectionTitle('Image'),
          const Text(
            'Image.network / Image.asset would render a picture here.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),

          _sectionTitle('FutureBuilder'),
          FutureBuilder<String>(
            future: _fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Text(snapshot.data ?? '');
            },
          ),

          _sectionTitle('StreamBuilder'),
          StreamBuilder<int>(
            stream: _counterStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Waiting...');
              return Text('Stream count: ${snapshot.data}');
            },
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }

  Future<String> _fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Data loaded from FutureBuilder';
  }

  Stream<int> _counterStream() async* {
    for (int i = 1; i <= 3; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }
}

// ---------------------------------------------------------------------------
// TABS & PAGES DEMO — TabBar/TabBarView, PageView, SafeArea
// ---------------------------------------------------------------------------
class TabsAndPagesDemo extends StatelessWidget {
  const TabsAndPagesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              labelColor: Colors.teal,
              tabs: [
                Tab(text: 'TabBar Demo'),
                Tab(text: 'PageView Demo'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const Center(child: Text('Content of Tab One')),
                  PageView(
                    children: [
                      Container(
                        color: Colors.red[200],
                        alignment: Alignment.center,
                        child: const Text('Page 1'),
                      ),
                      Container(
                        color: Colors.green[200],
                        alignment: Alignment.center,
                        child: const Text('Page 2'),
                      ),
                      Container(
                        color: Colors.blue[200],
                        alignment: Alignment.center,
                        child: const Text('Page 3'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
