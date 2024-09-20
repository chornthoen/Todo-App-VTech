part of 'create_bloc.dart';

abstract class CreateState extends Equatable {
  const CreateState();
}

class CreateInitial extends CreateState {
  @override
  List<Object> get props => [];
}

class CreateLoading extends CreateState {
  @override
  List<Object> get props => [];
}

class CreateSuccess extends CreateState {
  final List<TodoModel> todos;

  const CreateSuccess(this.todos);

  @override
  List<Object> get props => [todos];
}

class CreateError extends CreateState {
  final String message;

  const CreateError(this.message);

  @override
  List<Object> get props => [message];
}
