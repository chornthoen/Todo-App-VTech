part of 'create_bloc.dart';

abstract class CreateEvent extends Equatable {
  const CreateEvent();
}

class CreateTodoRequested extends CreateEvent {
  final TodoModel todo;

  const CreateTodoRequested(this.todo);

  @override
  List<Object> get props => [todo];
}

class CreateEventInitial extends CreateEvent {
  @override
  List<Object> get props => [];
}

class CreateEventLoading extends CreateEvent {
  @override
  List<Object> get props => [];
}

class CreateEventReload extends CreateEvent {
  @override
  List<Object> get props => [];
}
