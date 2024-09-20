import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/model/todo_model.dart';
import 'package:flutter_application/data/repository/todo_repository.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final TodoRepository _todoRepository;

  UpdateBloc(this._todoRepository) : super(UpdateInitial()) {
    on<Updated>(onUpdated);
    on<Reload>(onReloadTodos);
  }

  Future<void> onUpdated(Updated event, Emitter<UpdateState> emit) async {
    try {
      final currentState = state;
      if (currentState is UpdateLoaded) {
        final isDuplicate = currentState.todos.any((todo) =>
            todo.title == event.todo.title && todo.id != event.todo.id);
        if (isDuplicate) {
          emit(UpdateError(
              'Duplicate item: ${event.todo.title} already exists.'));
          return;
        }
      }
      await _todoRepository.updateTodo(event.id, event.todo);
      add(Reload());
    } catch (e) {
      emit(UpdateError(e.toString()));
      print(e);
    }
  }

  Future<void> onReloadTodos(Reload event, Emitter<UpdateState> emit) async {
    try {
      final todos = await _todoRepository.getTodos();
      emit(UpdateLoaded(todos));
    } catch (e) {
      emit(UpdateError(e.toString()));
    }
  }
}
