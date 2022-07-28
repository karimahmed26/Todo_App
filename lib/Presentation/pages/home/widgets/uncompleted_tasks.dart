import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business logic/cubit/todo_cubit.dart';
import '../../../../core/utils/size_config.dart';
import 'all_tasks.dart';


class UnCompleteTasks extends StatelessWidget {
  UnCompleteTasks({Key? key}) : super(key: key);
  final double size = SizeConfig.defaultSize!;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {},
        builder: (context, state) {
          TodoCubit cubit = TodoCubit.get(context);
          List<Map> tasksl = TodoCubit.get(context).unCompleteList;
          if (tasksl.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size * 2, horizontal: size * 1.8),
              child: ListView.builder(
                  itemCount: tasksl.length,
                  itemBuilder: (context, index) {
                    Map tasks = tasksl[index];

                    return AllTasks().taskItem(tasks, context, cubit);
                  }),
            );
          } else {
            return Container();
          }
        });
  }
}
