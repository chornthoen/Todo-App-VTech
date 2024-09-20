part of 'update_bloc.dart';

abstract class UpdateEvent extends Equatable {
  const UpdateEvent();
}

class Updated extends UpdateEvent {
  final String id;
  final TodoModel todo;

  const Updated(this.id, this.todo);

  @override
  List<Object> get props => [id, todo];
}

class Reload extends UpdateEvent {
  @override
  List<Object> get props => [];
}
