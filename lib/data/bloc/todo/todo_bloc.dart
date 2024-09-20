import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/model/todo_model.dart';
import 'package:flutter_application/data/repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;

  TodoBloc(this._todoRepository) : super(TodoInitial()) {
    on<LoadTodos>(onLoadTodos);
    on<FilterCompleted>(onFilterCompleted);
    on<FilterIncompleted>(onFilterIncompleted);
  }

  Future<void> onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodosLoading());
    try {
      final todos = await _todoRepository.getTodos();
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  Future<void> onFilterCompleted(
      FilterCompleted event, Emitter<TodoState> emit) async {
    emit(TodosLoading());
    try {
      final todos = await _todoRepository.getCompletedTodos();
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  Future<void> onFilterIncompleted(
      FilterIncompleted event, Emitter<TodoState> emit) async {
    emit(TodosLoading());
    try {
      final todos = await _todoRepository.getInCompletedTodos();
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }
}
