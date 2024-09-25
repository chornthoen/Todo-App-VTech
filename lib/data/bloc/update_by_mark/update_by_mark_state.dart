part of 'update_by_mark_bloc.dart';

sealed class UpdateByMarkState extends Equatable {
  const UpdateByMarkState();
}

final class UpdateByMarkInitial extends UpdateByMarkState {
  @override
  List<Object> get props => [];
}

class UpdateLoadedMark extends UpdateByMarkState {
  final List<TodoModel> todos;

  const UpdateLoadedMark(this.todos);

  @override
  List<Object> get props => [todos];
}

class UpdateMarkError extends UpdateByMarkState {
  final String error;

  const UpdateMarkError(this.error);

  @override
  List<Object> get props => [error];
}
