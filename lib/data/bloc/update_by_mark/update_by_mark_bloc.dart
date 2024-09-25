import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/model/todo_model.dart';
import 'package:flutter_application/data/repository/todo_repository.dart';

part 'update_by_mark_event.dart';
part 'update_by_mark_state.dart';

class UpdateByMarkBloc extends Bloc<UpdateByMarkEvent, UpdateByMarkState> {
  final TodoRepository _todoRepository;

  UpdateByMarkBloc(this._todoRepository) : super(UpdateByMarkInitial()) {
    on<UpdatedMark>(updateByMark);
    on<Reload>(onReloadTodos);
  }

  Future<void> updateByMark(
      UpdatedMark event, Emitter<UpdateByMarkState> emit) async {
    try {
      await _todoRepository.updateTodoMark(event.id, event.todo);
      add(Reload());
    } catch (e) {
      emit(UpdateMarkError(e.toString()));
      print(e);
    }
  }

  Future<void> onReloadTodos(
      Reload event, Emitter<UpdateByMarkState> emit) async {
    try {
      final todos = await _todoRepository.getTodos();
      emit(UpdateLoadedMark(todos));
    } catch (e) {
      emit(UpdateMarkError(e.toString()));
    }
  }
}
