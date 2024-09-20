import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/component/color/app_color.dart';
import 'package:flutter_application/component/spacing/app_spacing.dart';
import 'package:flutter_application/data/bloc/craete/create_bloc.dart';
import 'package:flutter_application/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:random_string/random_string.dart';

class CreateTodoPage extends StatelessWidget {
  const CreateTodoPage({
    super.key,
  });

  static const String routePath = '/create-todo';

  @override
  Widget build(BuildContext context) {
    return const CreateTodoView();
  }
}

class CreateTodoView extends StatefulWidget {
  const CreateTodoView({super.key});

  @override
  State<CreateTodoView> createState() => _CreateTodoViewState();
}

class _CreateTodoViewState extends State<CreateTodoView> {
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateBloc, CreateState>(
      listener: (context, state) {
        if (state is CreateError) {
          _titleController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is CreateLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CreateSuccess) {
          context.read<TodoBloc>().add(LoadTodos());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Todo created successfully'),
            ),
          );
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const Text('Create Todo'),
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
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryColor.withOpacity(0.9),
                ),
                onPressed: () {
                  String id = randomAlphaNumeric(10);
                  TodoModel todo = TodoModel(
                    id: id,
                    title: _titleController.text,
                    isCompleted: _completed,
                    createdAt: Timestamp.now(),
                    updatedAt: Timestamp.now(),
                  );
                  if (todo.title.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Title cannot be empty'),
                      ),
                    );
                    return;
                  } else {
                    context.read<CreateBloc>().add(CreateTodoRequested(todo));
                  }
                },
                child: const Text('Create'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
