part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final TodoModel todo;

  const AddTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodoEvent {
  final String id;
  final TodoModel todo;

  const UpdateTodo(this.id, this.todo);

  @override
  List<Object> get props => [id, todo];
}

class DeleteTodo extends TodoEvent {
  final String id;

  const DeleteTodo(this.id);

  @override
  List<Object> get props => [id];
}

class FilterCompleted extends TodoEvent {}

class FilterIncompleted extends TodoEvent {}
