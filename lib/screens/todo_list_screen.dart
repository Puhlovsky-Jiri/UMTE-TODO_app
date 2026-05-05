import 'package:flutter/material.dart';
import 'add_todo_screen.dart';
import 'todo_detail_screen.dart';
import 'settings_screen.dart';
import 'api_todo_screen.dart';
import 'package:hive/hive.dart';
import '../locator.dart';
import '../services/todo_service.dart';

class TodoListScreen extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  TodoListScreen({
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late Box box;
  List todos = [];
  final todoService = getIt<TodoService>();

  @override
  void initState() {
    super.initState();
    todos = todoService.getTodos();
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
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                   toggleTheme: widget.toggleTheme,
                  isDarkMode: widget.isDarkMode,
                  ),
                )
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
                todoService.updateTodo(index, updatedTodo);
                setState(() {
                  todos = todoService.getTodos();
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
            todoService.addTodo(newTodo);
            setState(() {
              todos = todoService.getTodos();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}