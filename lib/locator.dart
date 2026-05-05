import 'package:get_it/get_it.dart';
import 'services/todo_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<TodoService>(TodoService());
}