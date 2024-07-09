import 'package:equatable/equatable.dart';
import 'package:interview_test/src/model/task_model.dart';

class TaskState extends Equatable {

  // final UserRepository _repository;
  // ProfileCubit(this._repository) : super(ProfileInitial());


  final List<TaskModel>? allTasks;
  // final dynamic result;

  const TaskState({this.allTasks = const <TaskModel>[], dynamic taskId});

  TaskState

  copyWith(
      {
        state,
        index,
        TaskModel? task,
      List<TaskModel>? allTask,
      dynamic taskId,
      // TaskModel? updateTask
      }
      )

  {
    // TaskState(
    //   allTasks: List<TaskModel>.
    //   from(state.allTasks!)..add(event!.task!),
    // )


    return
      TaskState(
      taskId: taskId,
      allTasks: allTask ??  List<TaskModel>.
      from(state.allTasks!)..insert(index,task!),
    );


  }

  @override
  List<Object> get props => [allTasks!,identityHashCode(this)
  ];





  // static TaskState? fromMap(Map<String, dynamic> json) {}

  // Map<String,dynamic> toMap() {
  //   return {
  //     'allTasks': allTasks?.map((x) => x.toMap()).toList(),
  //   };
  //
  // }

  // TaskState? fromMap(Map<String, dynamic> json) {}

  //  TaskState? fromMap(Map<String, dynamic>map){
  //
  //   return TaskState(
  //     allTasks: List<TaskModel>.from('allTasks').map((e) => TaskModel.fromMap(x!));
  //   );
  // }
}

class TaskLoaded extends TaskState {
  // final ResponseModel responseModel;
  final List<TaskModel> ? responseModel;

   // allTasks;
  const TaskLoaded({this.responseModel});

}


class TaskLoading extends TaskState {}

class TaskError extends TaskState {

  final String ?  error;

  const TaskError({this.error});

}



// class AddTask extends TaskState {}
