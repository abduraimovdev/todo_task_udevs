import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/common/common.dart';
import 'src/screens/bloc/todo_bloc.dart';
import 'src/screens/bloc/todo_event.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<TodoBloc>()..add(const GetDataEvent()),
      child: MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.light,
        initialRoute: AppRoute.initialRoute,
        routes: AppRoute.routes,
      ),
    );
  }
}
