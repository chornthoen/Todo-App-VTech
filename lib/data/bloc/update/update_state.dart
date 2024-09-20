part of 'update_bloc.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object> get props => [];
}

class UpdateInitial extends UpdateState {}

class UpdateLoaded extends UpdateState {
  final List<TodoModel> todos;

  const UpdateLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}

class UpdateSuccess extends UpdateState {}

class UpdateError extends UpdateState {
  final String message;

  const UpdateError(this.message);

  @override
  List<Object> get props => [message];
}
