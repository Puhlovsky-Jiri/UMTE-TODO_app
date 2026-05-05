import 'package:flutter/material.dart';
import 'add_todo_screen.dart';
import 'todo_detail_screen.dart';
import 'settings_screen.dart';
import 'api_todo_screen.dart';
import 'package:hive/hive.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late Box box;
  List todos = [];

  @override
  void initState() {
    super.initState();
    box = Hive.box('todos');
    todos = box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        actions: [
          IconButton(
            icon: Icon(Icons.cloud),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApiTodoScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index]),
            onTap: () async {
              final updatedTodo = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoDetailScreen(todo: todos[index]),
                ),
              );

              if (updatedTodo != null) {
                box.putAt(index, updatedTodo);
                setState(() {
                  todos = box.values.toList();
                });
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTodo = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          );

          if (newTodo != null) {
            box.add(newTodo);
            setState(() {
              todos = box.values.toList();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}