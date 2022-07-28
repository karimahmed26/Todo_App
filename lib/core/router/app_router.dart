import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Presentation/pages/addTask/add_task.dart';
import '../../Presentation/pages/home/home.dart';
import '../../business logic/cubit/todo_cubit.dart';
import '../utils/constant.dart';

class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          switch (settings.name) {
            case home:
              return const Home();

            case addTask:
              return BlocProvider<TodoCubit>(
                  create: (context) => TodoCubit()..createDB(),
                  child: AddTask());
          }
          return const Home();
        });
  }
}
