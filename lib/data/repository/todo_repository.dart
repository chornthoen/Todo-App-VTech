import 'package:flutter_application/data/model/todo_model.dart';
import 'package:flutter_application/data/service/todo_service.dart';

class TodoRepository {
  final TodoService _todoService;

  TodoRepository(this._todoService);

  Future<void> addTodo(TodoModel todo) async {
    await _todoService.addTodo(todo);
  }

  Future<void> updateTodo(String id, TodoModel todo) async {
    await _todoService.updateTodo(id, todo);
  }

  Future<void> deleteTodo(String id) async {
    await _todoService.deleteTodo(id);
  }

  Future<List<TodoModel>> getTodos() async {
    return await _todoService.getTodos();
  }

  Future<List<TodoModel>> getCompletedTodos() async {
    return await _todoService.getCompletedTodos();
  }

  Future<List<TodoModel>> getInCompletedTodos() async {
    return await _todoService.getInCompletedTodos();
  }
}
