part of 'update_by_mark_bloc.dart';

sealed class UpdateByMarkEvent extends Equatable {
  const UpdateByMarkEvent();
}

class UpdatedMark extends UpdateByMarkEvent {
  final String id;
  final TodoModel todo;

  const UpdatedMark(this.id, this.todo);

  @override
  List<Object> get props => [id, todo];
}

class Reload extends UpdateByMarkEvent {
  @override
  List<Object> get props => [];
}
