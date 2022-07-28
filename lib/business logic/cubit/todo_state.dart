part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class CreateDBSuccess extends TodoState {}

class TaskInsertSuccess extends TodoState {}

class TaskInsertError extends TodoState {}

class TasksGetLoading extends TodoState {}

class TasksGetSuccess extends TodoState {}

class TasksGetError extends TodoState {}

class TaskUpdateSuccess extends TodoState {}

class TaskDeleteSuccess extends TodoState {}

class ChangeCheckBox extends TodoState {}
