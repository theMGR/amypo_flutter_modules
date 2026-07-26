import 'package:flutter/material.dart';

// Session 9 (supplementary) — more widgets that show up constantly in real
// apps but weren't in the original syllabus rows: Form/TextFormField
// validation, DropdownButton, Tabs, ExpansionTile, Tooltip, PopupMenuButton,
// DataTable, PageView, showModalBottomSheet, showDatePicker,
// GestureDetector/InkWell, LinearProgressIndicator.

class MoreCommonWidgetsScreen extends StatefulWidget {
  const MoreCommonWidgetsScreen({super.key});

  @override
  State<MoreCommonWidgetsScreen> createState() => _MoreCommonWidgetsScreenState();
}

class _MoreCommonWidgetsScreenState extends State<MoreCommonWidgetsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String? _selectedCountry = 'India';
  DateTime? _pickedDate;
  int _tapCount = 0;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (result != null) setState(() => _pickedDate = result);
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 150,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('This is a modal BottomSheet'),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('09 - More Common Widgets'),
          bottom: const TabBar(tabs: [Tab(text: 'Form & Inputs'), Tab(text: 'Display & Misc')]),
        ),
        body: TabBarView(
          children: [
            _buildFormTab(),
            _buildDisplayTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Form + TextFormField validation:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Email is required';
                if (!value.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                final valid = _formKey.currentState?.validate() ?? false;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(valid ? 'Form is valid' : 'Fix the errors above')),
                );
              },
              child: const Text('Validate'),
            ),
            const SizedBox(height: 24),

            const Text('DropdownButton:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedCountry,
              items: const ['India', 'USA', 'UK', 'Germany']
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedCountry = v),
            ),
            const SizedBox(height: 24),

            const Text('showDatePicker:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(onPressed: _pickDate, child: const Text('Pick a date')),
                const SizedBox(width: 12),
                Text(_pickedDate == null ? 'No date selected' : _pickedDate!.toLocal().toString().split(' ').first),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplayTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ExpansionTile:', style: TextStyle(fontWeight: FontWeight.bold)),
          ExpansionTile(
            title: const Text('Tap to expand'),
            children: const [Padding(padding: EdgeInsets.all(16), child: Text('Hidden content revealed.'))],
          ),
          const SizedBox(height: 16),

          const Text('Tooltip + PopupMenuButton:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Tooltip(message: 'This is a tooltip', child: Icon(Icons.info_outline)),
              const SizedBox(width: 16),
              PopupMenuButton<String>(
                onSelected: (value) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected: $value')),
                ),
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'Edit', child: Text('Edit')),
                  PopupMenuItem(value: 'Delete', child: Text('Delete')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          const Text('GestureDetector / InkWell (custom tap targets):', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => setState(() => _tapCount++),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(8)),
              child: Text('Tapped $_tapCount times (InkWell gives a ripple effect)'),
            ),
          ),
          const SizedBox(height: 16),

          const Text('LinearProgressIndicator:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const LinearProgressIndicator(value: 0.6),
          const SizedBox(height: 16),

          const Text('DataTable:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DataTable(
            columns: const [DataColumn(label: Text('Name')), DataColumn(label: Text('Score'))],
            rows: const [
              DataRow(cells: [DataCell(Text('Asha')), DataCell(Text('92'))]),
              DataRow(cells: [DataCell(Text('Ravi')), DataCell(Text('87'))]),
            ],
          ),
          const SizedBox(height: 16),

          const Text('PageView (swipeable pages):', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: PageView(
              children: [
                Container(color: Colors.red.shade100, alignment: Alignment.center, child: const Text('Page 1')),
                Container(color: Colors.green.shade100, alignment: Alignment.center, child: const Text('Page 2')),
                Container(color: Colors.blue.shade100, alignment: Alignment.center, child: const Text('Page 3')),
              ],
            ),
          ),
          const SizedBox(height: 16),

          const Text('showModalBottomSheet:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _showBottomSheet, child: const Text('Show BottomSheet')),
        ],
      ),
    );
  }
}
