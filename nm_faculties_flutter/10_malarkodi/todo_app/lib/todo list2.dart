import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final TextEditingController _controller = TextEditingController();

  final List<String> _categories = [
    "Personal",
    "Work",
    "Shopping",
    "Study",
  ];

  String _selectedCategory = "Personal";

  final List<Map<String, dynamic>> _todos = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTodo() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _todos.add({
        "title": _controller.text.trim(),
        "category": _selectedCategory,
        "done": false,
      });
    });

    _controller.clear();
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index]["done"] = !_todos[index]["done"];
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // TextField
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter a task",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // Dropdown
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: "Select Category",
                border: OutlineInputBorder(),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addTodo,
                child: const Text("Add Todo"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: _todos.isEmpty
                  ? const Center(
                      child: Text(
                        "No tasks yet",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            leading: Checkbox(
                              value: _todos[index]["done"],
                              onChanged: (_) => _toggleTodo(index),
                            ),
                            title: Text(
                              _todos[index]["title"],
                              style: TextStyle(
                                decoration: _todos[index]["done"]
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            subtitle: Text(
                              "Category: ${_todos[index]["category"]}",
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () => _deleteTodo(index),
                            ),
                          ),
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