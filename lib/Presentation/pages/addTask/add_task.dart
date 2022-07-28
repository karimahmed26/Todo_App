import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../business logic/cubit/todo_cubit.dart';
import '../../../core/customTextFormField.dart';
import '../../../core/custom_elevated_button.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/size_config.dart';


class AddTask extends StatelessWidget {
  AddTask({
    Key? key,
  }) : super(key: key);
  final double size = SizeConfig.defaultSize!;
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController startTimeTextController = TextEditingController();
  final TextEditingController endTimeTextController = TextEditingController();
  final TextEditingController deadlineTextController = TextEditingController();
  final TextEditingController remindTextController = TextEditingController();
  final TextEditingController repeatTextController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<TodoCubit, TodoState>(listener: (context, state) {
      if (state is TaskInsertSuccess) {
        Navigator.pop(context, home);
      }
    }, builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: size * 9,
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text(
            'Add Task',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kBlackColor,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: size * 1.8,
              color: kBlackColor,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(size * 4),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customText(text: 'Title'),
                  SizedBox(
                    height: size * 1.3,
                  ),
                  CustomeTextFormField(
                    hintText: 'I Want to ...',
                    textEditingController: titleTextController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Title Must Not Be Empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    suffixWidget: null,
                    prefixWidget: null,
                  ),
                  SizedBox(
                    height: size * 3,
                  ),
                  customText(text: 'Deadline'),
                  SizedBox(
                    height: size * 1.3,
                  ),
                  CustomeTextFormField(
                    hintText: '2021-02-02',
                    keyboardType: TextInputType.none,
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2022-12-31'))
                          .then((value) {
                        deadlineTextController.text =
                            DateFormat.yMMMMd().format(value!);
                      }).catchError((error) {
                        print(error.toString());
                      });
                    },
                    textEditingController: deadlineTextController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Deadline Must Not Be Empty';
                      }
                      return null;
                    },
                    prefixWidget: null,
                    suffixWidget: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: size * 2,
                        )),
                  ),
                  SizedBox(
                    height: size * 3,
                  ),
                  Row(
                    children: [
                      customText(text: 'Start Time'),
                      const Spacer(),
                      customText(text: 'End Time'),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: size * 1.3,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomeTextFormField(
                          hintText: '11:00 Am',
                          keyboardType: TextInputType.none,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              startTimeTextController.text =
                                  value!.format(context).toString();
                            }).catchError((error) {
                              print(error.toString());
                            });
                          },
                          textEditingController: startTimeTextController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Start Time Must Not Be Empty';
                            }
                            return null;
                          },
                          prefixWidget: null,
                          suffixWidget: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.access_time_rounded,
                                size: size * 2,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: size,
                      ),
                      Expanded(
                        child: CustomeTextFormField(
                          hintText: '14:00 Pm',
                          keyboardType: TextInputType.none,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              endTimeTextController.text =
                                  value!.format(context).toString();
                            }).catchError((error) {
                              print(error.toString());
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'End Time Must Not Be Empty';
                            }
                            return null;
                          },
                          textEditingController: endTimeTextController,
                          prefixWidget: null,
                          suffixWidget: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.access_time_rounded,
                                size: size * 2,
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size * 3,
                  ),
                  customText(text: 'Remind'),
                  SizedBox(
                    height: size * 1.3,
                  ),
                  CustomeTextFormField(
                    hintText: '10 Minutes early',
                    textEditingController: remindTextController,
                    prefixWidget: null,
                    suffixWidget: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: size * 2,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Remind Must Not Be Empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size * 3,
                  ),
                  customText(text: 'Repeat'),
                  SizedBox(
                    height: size * 1.3,
                  ),
                  CustomeTextFormField(
                    hintText: 'Weakly',
                    textEditingController: repeatTextController,
                    prefixWidget: null,
                    onTap: () {},
                    suffixWidget: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: size * 2,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Repeat Must Not Be Empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size * 3,
                  ),
// BlocConsumer(
//   builder: (context, state) {
//     return Container();
//   },
// )

                  CustomElevatedButton(
                    text: 'Create a Task',
                    textColor: kWhiteColor,
                    buttonColor: const Color(0XFF259963),
                    circular: 10,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print('validate done');
                        TodoCubit.get(context).insertDB(
                          status: 'new',
                          title: titleTextController.text,
                          deadline: deadlineTextController.text,
                          startTime: startTimeTextController.text,
                          endTime: endTimeTextController.text,
                          remind: remindTextController.text,
                          repeat: repeatTextController.text,
                        );
                      }
                    },
                    verticalPadding: size * 1.8,
                    size: const Size(double.infinity, 10),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

Widget customText({required String text}) {
  return Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: kBlackColor,
      fontSize: 18,
    ),
  );
}
