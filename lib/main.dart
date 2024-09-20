import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/component/color/app_color.dart';
import 'package:flutter_application/data/bloc/craete/create_bloc.dart';
import 'package:flutter_application/data/bloc/delete/delete_bloc.dart';
import 'package:flutter_application/data/bloc/todo/todo_bloc.dart';
import 'package:flutter_application/data/bloc/update/update_bloc.dart';
import 'package:flutter_application/data/repository/todo_repository.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/service/todo_service.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final service = TodoService();
  final todoRepository = TodoRepository(service);
  runApp(AppView(todoRepository: todoRepository));
}

class AppView extends StatelessWidget {
  const AppView({super.key, required this.todoRepository});

  final TodoRepository todoRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: todoRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TodoBloc>(
            create: (context) => TodoBloc(todoRepository),
          ),
          BlocProvider<UpdateBloc>(
            create: (context) => UpdateBloc(todoRepository),
          ),
          BlocProvider<CreateBloc>(
            create: (context) => CreateBloc(todoRepository),
          ),
          BlocProvider<DeleteBloc>(
            create: (context) => DeleteBloc(todoRepository),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor.withOpacity(0.9),
          titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.whiteColor,
              ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: AppColors.whiteColor,
          ),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.router,
    );
  }
}
