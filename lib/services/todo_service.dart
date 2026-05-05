import 'package:hive/hive.dart';

class TodoService {
  final Box box = Hive.box('todos');

  List getTodos() {
    return box.values.toList();
  }

  void addTodo(String todo) {
    box.add(todo);
  }

  void updateTodo(int index, String todo) {
    box.putAt(index, todo);
  }

  void deleteTodo(int index) {
    box.deleteAt(index);
  } 
}