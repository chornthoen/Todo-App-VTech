import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/model/todo_model.dart';
import 'package:flutter_application/data/repository/todo_repository.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  final TodoRepository _todoRepository;

  DeleteBloc(this._todoRepository) : super(DeleteInitial()) {
    on<DeleteTodoRequested>(onDeleteTodo);
    on<DeleteEventReload>(onReloadTodos);
  }

  Future<void> onDeleteTodo(
      DeleteTodoRequested event, Emitter<DeleteState> emit) async {
    try {
      await _todoRepository.deleteTodo(event.id);
      add(DeleteEventReload());
    } catch (e) {
      emit(DeleteError(e.toString()));
    }
  }

  Future<void> onReloadTodos(
      DeleteEventReload event, Emitter<DeleteState> emit) async {
    try {
      final todos = await _todoRepository.getTodos();
      emit(DeleteSuccess(todos));
    } catch (e) {
      emit(DeleteError(e.toString()));
    }
  }
}
