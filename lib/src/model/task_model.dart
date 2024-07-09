import 'dart:math';

import 'package:interview_test/src/bloc/task_management_state.dart';

class TaskModel {

  dynamic   id;
  String ? taskName;
  String ? taskDescription;
  String ? assignedPerson;

  TaskModel({
    this.id,
    this.taskName,
    this.taskDescription,
    this.assignedPerson
});

  TaskModel.fromMap(Map<String, dynamic> map){
    id = map['_id'];
    taskName = map['taskName'];

    taskDescription = map['taskDescription'];
    assignedPerson = map['assignedPerson'];


  }
  // updateTitle(title) {
  //   this.title = title;
  // }
  //
  // Map<String, dynamic> toMap() {
  //   return {
  //     'value': value,
  //     'colorNumber': colorNumber.index,
  //   };
  // }
  // factory TaskState.fromMap(Map<String, dynamic> map) {
  //   int val = map['colorNumber'];
  //   return TaskState(
  //    allTasks:
  //   );
  // }


  Map toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'assignedPerson' : assignedPerson
    };
  }

  TaskModel.fromJson(Map<String, dynamic> json) {

    id = json['_id'];
    taskName = json['taskName'];
    taskDescription = json['taskDescription'];
    assignedPerson = json['assignedPerson'];

  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['taskName'] = taskName;
    data['taskDescription'] = taskDescription;
    data['assignedPerson'] = assignedPerson;
    return data;

  }

}