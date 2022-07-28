import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_tasks/Presentation/pages/home/widgets/all_tasks.dart';
import 'package:todo_tasks/Presentation/pages/home/widgets/completed_tasks.dart';
import 'package:todo_tasks/Presentation/pages/home/widgets/favorite_tasks.dart';
import 'package:todo_tasks/Presentation/pages/home/widgets/uncompleted_tasks.dart';

import '../../../business logic/cubit/todo_cubit.dart';
import '../../../core/custom_elevated_button.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/size_config.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late double size = SizeConfig.defaultSize ?? 9.3;
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
        length: 4,
        vsync: this,
        initialIndex: 0,
        animationDuration: const Duration(milliseconds: 800))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {},
        builder: (context, state) {
          return DefaultTabController(
            length: 4,
            child: SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: size * 9,
                    elevation: 1,
                    backgroundColor: Colors.white,
                    title: const Text(
                      'Board',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBlackColor,
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          color: kBlackColor,
                        ),
                      )
                    ],
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border(
                            bottom: BorderSide(
                                color: kGreyColor.withOpacity(0.5), width: 1),
                          ),
                        ),
                        child: TabBar(
                          tabs: const [
                            Tab(
                              text: 'All',
                            ),
                            Tab(
                              text: 'Completed',
                            ),
                            Tab(
                              text: 'Uncompleted',
                            ),
                            Tab(
                              text: 'Favorite',
                            ),
                          ],
                          controller: tabController,
                          onTap: (index) {},
                          indicatorColor: kBlackColor,
                          isScrollable: true,
                          unselectedLabelColor: kGreyColor,
                          unselectedLabelStyle: TextStyle(
                            fontSize: size * 1.7,
                            fontWeight: FontWeight.bold,
                          ),
                          labelStyle: TextStyle(
                            fontSize: size * 1.7,
                            fontWeight: FontWeight.bold,
                          ),
                          padding: EdgeInsets.only(top: size),
                          labelPadding: EdgeInsets.symmetric(
                            horizontal: size * 1.8,
                          ),
                          labelColor: kBlackColor,
                        ),
                      ),
                      Expanded(
                        child: TabBarView(controller: tabController, children: [
                          Tab(
                            child: AllTasks(),
                          ),
                          Tab(
                            child: CompleteTasks(),
                          ),
                          Tab(
                            child: UnCompleteTasks(),
                          ),
                          Tab(
                            child: FavoriteTasks(),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size * 3, vertical: size * 2),
                        child: CustomElevatedButton(
                          text: 'Add Task',
                          textColor: kWhiteColor,
                          buttonColor: const Color(0XFF259963),
                          circular: 10,
                          onPressed: () {
                            Navigator.pushNamed(context, addTask);
                          },
                          verticalPadding: size * 1.8,
                          size: const Size(double.infinity, 10),
                        ),
                      )
                    ],
                  )),
            ),
          );
        });
  }
}
