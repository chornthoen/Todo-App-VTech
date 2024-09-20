part of 'delete_bloc.dart';

abstract class DeleteEvent extends Equatable {
  const DeleteEvent();
}

class DeleteTodoRequested extends DeleteEvent {
  final String id;

  const DeleteTodoRequested(this.id);

  @override
  List<Object> get props => [id];
}

class DeleteEventInitial extends DeleteEvent {
  @override
  List<Object> get props => [];
}

class DeleteEventLoading extends DeleteEvent {
  @override
  List<Object> get props => [];
}

class DeleteEventReload extends DeleteEvent {
  @override
  List<Object> get props => [];
}

class DeleteEventError extends DeleteEvent {
  final String message;

  const DeleteEventError(this.message);

  @override
  List<Object> get props => [message];
}
