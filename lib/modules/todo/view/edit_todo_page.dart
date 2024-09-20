import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/component/color/app_color.dart';
import 'package:flutter_application/component/spacing/app_spacing.dart';
import 'package:flutter_application/data/bloc/update/update_bloc.dart';
import 'package:flutter_application/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditTodoPage extends StatelessWidget {
  const EditTodoPage({super.key, required this.todo});

  final TodoModel todo;

  static const String routePath = '/edit-todo';

  @override
  Widget build(BuildContext context) {
    return EditTodoView(todo: todo);
  }
}

class EditTodoView extends StatefulWidget {
  const EditTodoView({super.key, required this.todo});

  final TodoModel todo;

  @override
  State<EditTodoView> createState() => _EditTodoViewState();
}

class _EditTodoViewState extends State<EditTodoView> {
  late TextEditingController _titleController;

  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _completed = widget.todo.isCompleted;
    _titleController = TextEditingController(text: widget.todo.title);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateBloc, UpdateState>(
      listener: (context, state) {
        if (state is UpdateLoaded) {
          context.read<TodoBloc>().add(LoadTodos());
          if (GoRouter.of(context).canPop()) {
            context.pop();
          }
        } else if (state is UpdateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const Text('Edit Todo'),
        ),
        body: Column(
          children: [
            const SizedBox(height: AppSpacing.xlg),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
              ),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Enter title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: AppColors.primaryColor,
                  value: _completed,
                  onChanged: (value) {
                    setState(() {
                      _completed = value!;
                    });
                  },
                ),
                const Text('Completed'),
              ],
            ),
            const SizedBox(height: AppSpacing.xlg),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryColor.withOpacity(0.9),
                ),
                onPressed: () {
                  String id = widget.todo.id;
                  TodoModel todo = TodoModel(
                    createdAt: widget.todo.createdAt,
                    id: id,
                    title: _titleController.text,
                    isCompleted: _completed,
                    updatedAt: Timestamp.now(),
                  );
                  print('Update Todo${todo.toMap()}');
                  context.read<UpdateBloc>().add(Updated(id, todo));
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
