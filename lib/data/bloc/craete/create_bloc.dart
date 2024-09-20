import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/model/todo_model.dart';
import 'package:flutter_application/data/repository/todo_repository.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  final TodoRepository _todoRepository;

  CreateBloc(this._todoRepository) : super(CreateInitial()) {
    on<CreateTodoRequested>(onCreated);
    on<CreateEventReload>(onReload);
  }

  Future<void> onCreated(
      CreateTodoRequested event, Emitter<CreateState> emit) async {
    try {
      final currentState = state;
      if (currentState is CreateSuccess) {
        final isDuplicate = currentState.todos.any(
          (todo) => todo.title == event.todo.title && todo.id != event.todo.id,
        );
        if (isDuplicate) {
          emit(CreateError(
              'Duplicate item: ${event.todo.title} already exists.'));
          return;
        }
      }
      await _todoRepository.addTodo(event.todo);
      add(CreateEventReload());
    } catch (e) {
      emit(CreateError(e.toString()));
    }
  }

  Future<void> onReload(
      CreateEventReload event, Emitter<CreateState> emit) async {
    emit(CreateLoading());
    try {
      final todos = await _todoRepository.getTodos();
      emit(CreateSuccess(todos));
    } catch (e) {
      emit(CreateError(e.toString()));
    }
  }
}
