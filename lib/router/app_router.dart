import 'package:flutter_application/modules/todo/view/create_todo_page.dart';
import 'package:flutter_application/modules/todo/view/edit_todo_page.dart';
import 'package:flutter_application/modules/todo/view/todo_detail_page.dart';
import 'package:flutter_application/modules/todo/view/todo_page.dart';
import 'package:go_router/go_router.dart';

import '../data/model/todo_model.dart';

class AppRouter {
  final GoRouter _router = GoRouter(
    initialLocation: TodoPage.routePath,
    routes: [
      GoRoute(
        path: TodoPage.routePath,
        builder: (context, state) => const TodoPage(),
      ),
      GoRoute(
        path: CreateTodoPage.routePath,
        builder: (context, state) => const CreateTodoPage(),
      ),
      GoRoute(
        path: TodoDetailPage.routePath,
        builder: (context, state) {
          final todo = state.extra as TodoModel;
          return TodoDetailPage(todo: todo);
        },
      ),
      GoRoute(
        path: EditTodoPage.routePath,
        builder: (context, state) {
          final todo = state.extra as TodoModel;
          return EditTodoPage(todo: todo);
        },
      ),
    ],
  );

  GoRouter get router => _router;
}
