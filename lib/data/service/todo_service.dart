import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/data/model/todo_model.dart';

const String todosCollection = 'todos';

class TodoService {
  TodoService() {
    _todosCollection = _firestore.collection(todosCollection);
  }

  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _todosCollection;

  Future<void> addTodo(TodoModel todo) async {
    final snapshot =
        await _todosCollection.where('title', isEqualTo: todo.title).get();

    if (snapshot.docs.isNotEmpty) {
      print('Todo with the same title already exists');
      return;
    } else {
      await _todosCollection.add(todo.toMap());
      print('Todo added successfully');
    }
  }

  Future<void> updateTodo(String id, TodoModel todo) async {
    try {
      final title =
          await _todosCollection.where('title', isEqualTo: todo.title).get();
      QuerySnapshot snapshot = await _todosCollection
          .where(
            'id',
            isEqualTo: id,
          )
          .get();
      if (title.docs.isNotEmpty) {
        print('Todo with the same title already exists');
        return;
      }
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.update(todo.toMap());
      }
    } catch (e) {
      print('Failed to update document: $e');
    }
  }

  Future<void> updateTodoMark(String id, TodoModel todo) async {
    try {
      QuerySnapshot snapshot = await _todosCollection
          .where(
            'id',
            isEqualTo: id,
          )
          .get();
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.update(todo.toMap());
      }
    } catch (e) {
      print('Failed to update document: $e');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      QuerySnapshot snapshot = await _todosCollection
          .where(
            'id',
            isEqualTo: id,
          )
          .get();

      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print('Failed to delete document: $e');
      if (e is FirebaseException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
      }
    }
  }

  Future<List<TodoModel>> getTodos() async {
    final snapshot = await _todosCollection.get();
    return snapshot.docs
        .map((doc) => TodoModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<TodoModel>> getCompletedTodos() async {
    final snapshot =
        await _todosCollection.where('isCompleted', isEqualTo: true).get();
    return snapshot.docs
        .map((doc) => TodoModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<TodoModel>> getInCompletedTodos() async {
    final snapshot =
        await _todosCollection.where('isCompleted', isEqualTo: false).get();
    return snapshot.docs
        .map((doc) => TodoModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
