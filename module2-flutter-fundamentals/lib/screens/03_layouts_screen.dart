import 'package:flutter/material.dart';

// Session 3 — Layout techniques: Row, Column, Stack, Container,
// SizedBox, Padding, Align, Expanded/Flexible, Wrap.

class LayoutsScreen extends StatelessWidget {
  const LayoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('03 - Layout Techniques')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Row + Expanded (fills remaining width):', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(width: 50, height: 50, color: Colors.red),
              Expanded(
                child: Container(height: 50, color: Colors.orange, alignment: Alignment.center, child: const Text('Expanded')),
              ),
              Container(width: 50, height: 50, color: Colors.green),
            ],
          ),
          const SizedBox(height: 24),

          const Text('Column with MainAxisAlignment.spaceBetween:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 30, color: Colors.blue.shade200),
                Container(height: 30, color: Colors.blue.shade400),
                Container(height: 30, color: Colors.blue.shade600),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text('Stack + Align/Positioned (overlapping widgets):', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: Stack(
              children: [
                Container(color: Colors.grey.shade300),
                const Align(alignment: Alignment.topLeft, child: Padding(padding: EdgeInsets.all(8), child: Text('top-left'))),
                const Align(alignment: Alignment.center, child: Text('center')),
                Positioned(bottom: 8, right: 8, child: const Icon(Icons.star, color: Colors.amber)),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text('Padding + Container decoration:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.indigo),
              ),
              child: const Text('Container with padding + decoration'),
            ),
          ),
          const SizedBox(height: 24),

          const Text('Wrap (flows to next line when out of space):', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              8,
              (i) => Chip(label: Text('Tag ${i + 1}')),
            ),
          ),
        ],
      ),
    );
  }
}
