import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_tasks/Presentation/pages/home/home.dart';

import '../business logic/cubit/todo_cubit.dart';
import '../core/router/app_router.dart';


class ToDo extends StatelessWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit()..createDB(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Home(),
        onGenerateRoute: AppRouter().generateRoute,
      ),
    );
  }
}
