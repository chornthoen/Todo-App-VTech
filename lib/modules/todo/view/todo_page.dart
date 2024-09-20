import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/component/color/app_color.dart';
import 'package:flutter_application/component/spacing/app_spacing.dart';
import 'package:flutter_application/component/widgets/custom_time.dart';
import 'package:flutter_application/data/bloc/delete/delete_bloc.dart';
import 'package:flutter_application/data/bloc/update/update_bloc.dart';
import 'package:flutter_application/data/data.dart';
import 'package:flutter_application/modules/todo/view/edit_todo_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../todo.dart';
import 'create_todo_page.dart';
import 'todo_detail_page.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  static const routePath = '/';

  @override
  Widget build(BuildContext context) {
    return const TodoView();
  }
}

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  List<String> filter = [
    'All',
    'Completed',
    'Incompleted',
  ];

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(LoadTodos());
  }

  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateBloc, UpdateState>(
          listener: (context, state) {
            if (state is UpdateLoaded) {
              context.read<TodoBloc>().add(LoadTodos());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Todo updated successfully'),
                ),
              );
            } else if (state is UpdateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
        ),
        BlocListener<DeleteBloc, DeleteState>(
          listener: (context, state) {
            if (state is DeleteSuccess) {
              context.read<TodoBloc>().add(LoadTodos());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Todo deleted successfully'),
                ),
              );
            } else if (state is DeleteError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const Text('Todo App'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'All') {
                  context.read<TodoBloc>().add(LoadTodos());
                } else if (value == 'Completed') {
                  context.read<TodoBloc>().add(FilterCompleted());
                } else if (value == 'Incompleted') {
                  context.read<TodoBloc>().add(FilterIncompleted());
                }
              },
              icon: const Icon(Icons.filter_list),
              itemBuilder: (context) {
                return filter.map((item) {
                  return PopupMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              },
            ),
            const SizedBox(width: AppSpacing.md),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<TodoBloc>().add(LoadTodos());
          },
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodosLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TodosLoaded) {
                if (state.todos.isEmpty) {
                  return const Center(
                      child: Text('No result. Create a new one instead.'));
                }
                final sortedTodos = state.todos
                  ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  child: ListView.builder(
                    itemCount: state.todos.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final todo = sortedTodos[index];
                      final DateTime dateTime = todo.createdAt.toDate();
                      return ItemTodo(
                        title: todo.title,
                        createdAt: CustomTime.getFormattedTime(dateTime),
                        isCompleted: todo.isCompleted,
                        onEdit: () {
                          context.push(
                            EditTodoPage.routePath,
                            extra: todo,
                          );
                        },
                        onDelete: () {
                          onDeleted(todo.id);
                        },
                        onTab: () {
                          context.push(TodoDetailPage.routePath, extra: todo);
                        },
                        onMarkAsCompleted: () {
                          if (todo.isCompleted) {
                            _completed = false;
                          } else {
                            _completed = true;
                          }
                          TodoModel todos = TodoModel(
                            createdAt: todo.createdAt,
                            id: todo.id,
                            title: todo.title,
                            isCompleted: _completed,
                            updatedAt: Timestamp.now(),
                          );
                          onMarkAsCompleted(todo.id, todos);
                        },
                      );
                    },
                  ),
                );
              } else if (state is TodosError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('No todos available'));
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            context.push(CreateTodoPage.routePath);
          },
          child: const Icon(
            Icons.add,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }

  void onDeleted(String id) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Todo'),
          content: const Text('Are you sure you want to delete this todo?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<DeleteBloc>().add(DeleteTodoRequested(id));
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void onMarkAsCompleted(String id, TodoModel todo) {
    context.read<UpdateBloc>().add(Updated(id, todo));
  }
}
