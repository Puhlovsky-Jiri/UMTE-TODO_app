import 'package:flutter/material.dart';

class TodoDetailScreen extends StatefulWidget {
  final String todo;

  TodoDetailScreen({required this.todo});

  @override
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.todo);
  }

  void _save() {
    Navigator.pop(context, _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail TODO"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Upravit úkol"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _save,
              child: Text("Uložit změny"),
            )
          ],
        ),
      ),
    );
  }
}