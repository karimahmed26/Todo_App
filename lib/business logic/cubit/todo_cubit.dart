import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  static TodoCubit get(context) => BlocProvider.of(context);
  late Database database;
  List<Map> dataList = [];
  List<Map> unCompleteList = [];
  List<Map> completeList = [];
  List<Map> favoriteList = [];

  // open the database

  createDB() async {
    database = await openDatabase('tOdo.db', version: 1,
        onCreate: (Database db, int version) async {
      print('dataBas created');

      await db
          .execute(
              'CREATE TABLE Tasks(id INTEGER PRIMARY KEY, status Text, title TEXT, deadline TEXT, startTime TEXT, endTime TEXT, remind TEXT, repeat TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print(error.toString());
      });
    }, onOpen: (Database db) {
      database = db;
      print('database opened');
    }).then((value) {
      getDB(value);
      emit(CreateDBSuccess());
      return database = value;
    });
  }

  // insert row

  Future insertDB({
    required String status,
    required String title,
    required String deadline,
    required String startTime,
    required String endTime,
    required String remind,
    required String repeat,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO Tasks(status, title, deadLine, startTime, endTime, remind, repeat) VALUES("$status","$title","$startTime","$deadline","$endTime","$remind","$repeat")',
      )
          .then((value) {
        print('$value inserted success');
        getDB(database);
        emit(TaskInsertSuccess());
      });
    });
  }

  //get DB
  void getDB(database) {
    emit(TasksGetLoading());
    database.rawQuery('SELECT * FROM Tasks').then((value) {
      value.forEach((element) {
        dataList.add(element);
        if (element['status'] == 'favorite') {
          favoriteList.add(element);
        } else if (element['status'] == 'complete') {
          completeList.add(element);
        } else if (element['status'] == 'unComplete') {
          unCompleteList.add(element);
        }

        emit(TasksGetSuccess());
      });
    });
  }

  //update DB

  upDateDB({
    required String status,
    required int id,
  }) async {
    await database.rawUpdate('UPDATE Tasks SET status = ? WHERE id = ? ',
        [status, id]).then((value) {
      getDB(database);
      emit(TaskUpdateSuccess());
    });
  }

  //delete DB

  deleteDB({required int id}) async {
    await database
        .rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      getDB(database);
      emit(TaskDeleteSuccess());
    });
  }

  //change checkBox
  bool isChecked = false;

  chekBox() {
    isChecked = !isChecked;
    emit(ChangeCheckBox());
  }
}
