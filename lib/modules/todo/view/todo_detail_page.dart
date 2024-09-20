import 'package:flutter/material.dart';
import 'package:flutter_application/component/spacing/app_spacing.dart';
import 'package:flutter_application/component/widgets/custom_time.dart';
import 'package:flutter_application/data/data.dart';

class TodoDetailPage extends StatelessWidget {
  const TodoDetailPage({super.key, required this.todo});

  final TodoModel todo;

  static const String routePath = '/todo-detail';

  @override
  Widget build(BuildContext context) {
    return TodoDetailView(
      todo: todo,
    );
  }
}

class TodoDetailView extends StatefulWidget {
  const TodoDetailView({super.key, required this.todo});

  final TodoModel todo;

  @override
  State<TodoDetailView> createState() => _TodoDetailViewState();
}

class _TodoDetailViewState extends State<TodoDetailView> {
  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = widget.todo.createdAt.toDate();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.todo.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                        decoration: widget.todo.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Text(
                      'Date: ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      CustomTime.getFormattedTime(dateTime),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Text(
                      'Status: ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: widget.todo.isCompleted
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(AppSpacing.md),
                      ),
                      child: Text(
                        widget.todo.isCompleted ? 'Completed' : 'Incompleted',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: widget.todo.isCompleted
                                  ? Colors.green
                                  : Colors.red,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
