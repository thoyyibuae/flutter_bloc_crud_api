

import 'package:equatable/equatable.dart';

import '../model/task_model.dart';

class TasksEvent extends Equatable {
 final List<TaskModel>? allTasks;
 // final dynamic result;
 const TasksEvent(
 {
  this.allTasks
 }
 );
 @override
 List<Object> get props => [];
}


class AddTask extends TasksEvent{


 final  TaskModel ? task;

 const AddTask({
  this.task
});


 // @override
 // List<Object> get props => [task!];
}
class UpdateTask extends TasksEvent{


 final  TaskModel ? task;
 // final index;

 const UpdateTask({
  // this.index,
  this.task
 });

 @override
 List<Object> get props => [task!];
}


class DeleteTask extends TasksEvent
{


 final  TaskModel ? task;

const DeleteTask({
  this.task
 });

 @override
 List<Object> get props => [task!];
}



class LoadTask extends TasksEvent{


 final  List<TaskModel> ? task;
 // final index;

 const LoadTask({
  // this.index,
  this.task
 });

 @override
 List<Object> get props => [task!];
}