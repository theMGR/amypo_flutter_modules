import 'package:flutter/material.dart';

// Session 6 — Inputs & lists (expanded widget set): TextField, Checkbox,
// Switch, Radio, Slider, Card, ListTile, ListView.builder, GridView.builder.

enum Plan { free, pro, team }

class InputsListsScreen extends StatefulWidget {
  const InputsListsScreen({super.key});

  @override
  State<InputsListsScreen> createState() => _InputsListsScreenState();
}

class _InputsListsScreenState extends State<InputsListsScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _items = ['Buy milk', 'Walk the dog'];

  bool _notificationsOn = true;
  bool _agreedToTerms = false;
  Plan _selectedPlan = Plan.free;
  double _volume = 50;

  void _addItem() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _items.add(text);
      _textController.clear();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('06 - Inputs & Lists')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('TextField + adding to a list:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(hintText: 'New to-do item', border: OutlineInputBorder()),
                  onSubmitted: (_) => _addItem(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: _addItem, child: const Text('Add')),
            ],
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: Text(_items[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => setState(() => _items.removeAt(index)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          const Text('Checkbox / Switch / Radio / Slider:', style: TextStyle(fontWeight: FontWeight.bold)),
          CheckboxListTile(
            title: const Text('I agree to the terms'),
            value: _agreedToTerms,
            onChanged: (v) => setState(() => _agreedToTerms = v ?? false),
          ),
          SwitchListTile(
            title: const Text('Notifications'),
            value: _notificationsOn,
            onChanged: (v) => setState(() => _notificationsOn = v),
          ),
          RadioGroup<Plan>(
            groupValue: _selectedPlan,
            onChanged: (v) => setState(() => _selectedPlan = v ?? _selectedPlan),
            child: Column(
              children: Plan.values
                  .map((plan) => RadioListTile<Plan>(title: Text(plan.name), value: plan))
                  .toList(),
            ),
          ),
          Row(
            children: [
              const Text('Volume'),
              Expanded(
                child: Slider(
                  value: _volume,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  label: _volume.round().toString(),
                  onChanged: (v) => setState(() => _volume = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          const Text('GridView.builder:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
            itemCount: 6,
            itemBuilder: (context, index) => Container(
              color: Colors.indigo.shade100,
              alignment: Alignment.center,
              child: Text('Item ${index + 1}'),
            ),
          ),
        ],
      ),
    );
  }
}
