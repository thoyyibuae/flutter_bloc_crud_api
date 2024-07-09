


import 'package:interview_test/src/model/task_model.dart';

import '../data_provider/api_data__provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  // Future<ResponseModel> fetchProductList() {
  //   return _provider.fetchProductList();
  // }

  Future <List<TaskModel>?> fetchApiList(){

    return _provider.fetchData_new();

  }

  Future<TaskModel?> addTask ( TaskModel task){

    return _provider.addTask(task);
  }
  Future<TaskModel?> updateTask ( TaskModel task){

    return _provider.updateTask(task);
  }




  Future<TaskModel?> removeTask ( TaskModel task){

    return _provider.removeTask(task);
  }

}

class NetworkError extends Error {}
