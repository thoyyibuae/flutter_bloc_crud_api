import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_test/src/bloc/task_management_event.dart';
import 'package:interview_test/src/bloc/task_management_state.dart';
import 'package:interview_test/src/model/task_model.dart';

import '../repository/api_repository.dart';

class TaskBloc extends Bloc<TasksEvent, TaskState> {
  final ApiRepository _apiRepository = ApiRepository();


  TaskBloc() :
        super(
      const TaskState()
  )


  {

    on<LoadTask>((event, emit) async {
      try {

        emit(TaskLoading());

        final mList = await _apiRepository.fetchApiList();

        print("the m list is");
        mList?.forEach((element) {

          print(element.taskName);
          // emit(TaskState(
          //   allTasks: (AddTask(task: element)
          // ));
        });
        print("the m list is");
        // final mList = await _apiRepository.fetchProductList();
        // emit(TaskLoaded(responseModel: mList));

        emit(TaskState(
          allTasks: mList,
        ));
        // emit(ProductLoaded(mList));


        // if (mList?.error != null)
        // {
        //   emit(ProductError(mList.error));
        // }
        // else{
        //
        // }


      } on NetworkError {
        emit(
             TaskError(error: "Failed to fetch data. is your device online ?"));
      }
    });

    on<AddTask>(_onAddTask);

    on<UpdateTask>(_onUpdateTask);

    on<DeleteTask>(_onDeleteTask);
    // on<LoadTask>(_onLoadTask);


  }

  Future<void> _onAddTask(AddTask? event, Emitter<TaskState> emit)

  async {

    final state = this.state;
    // TaskLoaded(
    //     responseModel: state.allTasks
    // );
    final task = await _apiRepository.addTask(event!.task!);


    print("Added task is :${task?.toJson()}");


    emit(TaskState(
      allTasks: List<TaskModel>.from(state.allTasks!)..add(task!),
    ));




  }


  void _onLoadTask(LoadTask? event, Emitter<TaskState> emit)

  {

    final state = this.state;

    emit(TaskLoaded(
      responseModel: state.allTasks
    ));

  }


  Future<void> _onUpdateTask(UpdateTask? event, Emitter<TaskState> emit)

  async {

    final state = this.state;
    final task = event!.task;

    print(" update 114 The given id is : ${task!.toJson()}");

    // return;
    emit(TaskLoading());

    state.allTasks!.forEach((el)
    {
      // print("The item is :${el.id}");
      // emit(TaskState(
      //   allTasks: List<TaskModel>.
      //   from(state.allTasks!)..insert(index,event.task!),
      // ));
    });
    final update  = await _apiRepository.updateTask(task);


    print("the given updated data is:129");
    print(update?.toJson());

    final int index = state.allTasks!.indexWhere((item) => item.id == task.id);

    state.allTasks!.removeWhere((item) => item.id == task.id);

    print("The given index is : ${index}");
    // return;
    // emit(TaskState(
    //     allTasks: allTasks
    // ));
    // allTasks?.insert(index, task!);

    emit(state.copyWith(
        allTask: state.allTasks!,
        taskId: update?.id,
        task: update,
        index: index,
        state: state));

    // emit(TaskState(
    //   allTasks: List<TaskModel>.
    //   from(state.allTasks!)..insert(index,event.task!),
    // ));
  }

  Future<void> _onDeleteTask(DeleteTask? event, Emitter<TaskState> emit)
  async {

    final state = this.state;
    final task = event!.task;

    print("The given id is : ${task!.id}");

    state.allTasks!.forEach((el) {
      // print("The item is :${el.id}");
      // emit(TaskState(
      //   allTasks: List<TaskModel>.
      //   from(state.allTasks!)..insert(index,event.task!),
      // ));
    });

  final del=  await _apiRepository.removeTask(task);

    final int index = state.allTasks!.indexWhere((item) => item.id == task.id);

    state.allTasks!.removeWhere((item) => item.id == task.id);

    print("The given index is : ${index}");
    // return;
    // emit(TaskState(
    //     allTasks: allTasks
    // ));
    // allTasks?.insert(index, task!);

    // emit(
    //
    //     state.copyWith(
    //         allTask: state.allTasks!,
    //         taskId: task.id,
    //         task:task ,
    //         index: index,
    //         state: state
    //     ));

    emit(TaskState(
      allTasks: List<TaskModel>.
      from(state.allTasks!)..remove(event.task!),
    ));
  }
}
