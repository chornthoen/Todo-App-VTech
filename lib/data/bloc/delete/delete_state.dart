part of 'delete_bloc.dart';

abstract class DeleteState extends Equatable {
  const DeleteState();
}

class DeleteInitial extends DeleteState {
  @override
  List<Object> get props => [];
}

class DeleteSuccess extends DeleteState {
  final List<TodoModel> todos;

  const DeleteSuccess(this.todos);

  @override
  List<Object> get props => [todos];
}

class DeleteLoading extends DeleteState {
  @override
  List<Object> get props => [];
}

class DeleteError extends DeleteState {
  final String message;

  const DeleteError(this.message);

  @override
  List<Object> get props => [message];
}
