import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../model/task_model.dart';

// import '../models/ResponseModel.dart';
// import '../models/book_model.dart';
// import '../models/product.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url =
      'https://run.mocky.io/v3/919a0d45-c054-4452-8175-65538e554272';

  // final url ="https://jsonplaceholder.typicode.com/posts";


  // final url_new ="http://192.168.1.15:4001/api/book/books";

final baseUrl ="http://192.168.1.46:4001/api/task";
  final url_new ="http://192.168.1.46:4001/api/task/tasks";

  final urlAddTask ="http://192.168.1.46:4001/api/task/addTasks";


  final urlRemoveTask ="http://192.168.1.46:4001/api/task/deleteTask/";


  final url ="https://jsonplaceholder.typicode.com/photos";

  // Future<ResponseModel> fetchProductList() async
  // {
  //   try {
  //     Response response = await _dio.get(url);
  //     return ResponseModel.fromJson(response.data);
  //
  //   } catch (error, stacktrace) {
  //     // ignore: avoid_print
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return ResponseModel.withError("Data not found / Connection issue");
  //
  //   }
  // }


  Future<dynamic> fetchProductList_new() async
  {
    try {
      var response = await http.get(Uri.parse(url_new));
      print(" 40 the api res is : ${response.body}");

      return json.decode(response.body);
      // return ResponseModel.fromJson(response.body);

    } catch (error, stacktrace) {
      // ignore: avoid_print
      print("Exception occured: $error stackTrace: $stacktrace");
      // return ResponseModel.withError("Data not found / Connection issue");
      return "Exception occured: $error stackTrace: $stacktrace";

    }
  }



  List<TaskModel> userList =[];

  List<TaskModel> userList_new =[];

  Future<List<TaskModel>?> fetchData_new() async {
    try {

      userList_new=[];

      var response = await http.get(Uri.parse(url_new));
      print(response.body.runtimeType);
      print(response.body);
      var rs =json.decode(response.body);
      List<dynamic> dt = [];

      dt=rs;

      // var js = (json.decode(response.data));

      List<dynamic> dlst = [];


      // List<Users>.from(json.decode(response.body).map((x) => Users.fromJson(x)));
      // List<ApiRes>.from(dt.map((model)=> ApiRes.fromJson(model)));;
      // List<ApiRes>.from(dt.map((x) => ApiRes.fromJson(x)))
      //     .forEach((element)
      // {
      //
      //   // print(element.title);
      //   // print("The user id 37");
      //
      // });
      print("the given list is : ${dt.runtimeType}");

      userList_new =   List<TaskModel>.from(dt.map((x) => TaskModel.fromJson(x)));
      // Map<String, dynamic> categoryTypes = dt;

      // categories = ResModel.fromJson(categoryTypes);


      // dt.forEach((element) {
      //   print(element);
      // });



      print("the given list is :");
      // ResModel md=
      // ResModel(
      //     status: true,
      //     datas:userList_new
      //
      // );
      // print(" line 31 The md is : ${md}");

      // print(ResModel.fromJson(md).status);


      return userList_new;

    } catch (error, stacktrace) {
      // ignore: avoid_print
      print("Exception occured: $error stackTrace: $stacktrace");
      // return ResModel.withError("Data not found / Connection issue");
      // return "Exception occured: $error stackTrace: $stacktrace";
    }
  }


  Future<TaskModel?> addTask(TaskModel task) async {
    try {

      // userList_new=[];

      TaskModel t= TaskModel(
        assignedPerson: task.assignedPerson,
        taskDescription: task.taskDescription ,
        taskName:  task.taskName
      );

      print("The adding task is 141 : ${urlAddTask}  "
          "${json.encode(t)}");
      print(task.assignedPerson);

      var response = await http.post(Uri.parse(urlAddTask),
      body: json.encode(t),
      headers: { "Content-Type" :"application/json"} );
      print(response.body.runtimeType);
      print(response.body);
      var rs =json.decode(response.body);
      // List<dynamic> dt = [];
      //
      // dt=rs;

      // var js = (json.decode(response.data));

      List<dynamic> dlst = [];


      // List<Users>.from(json.decode(response.body).map((x) => Users.fromJson(x)));
      // List<ApiRes>.from(dt.map((model)=> ApiRes.fromJson(model)));;
      // List<ApiRes>.from(dt.map((x) => ApiRes.fromJson(x)))
      //     .forEach((element)
      // {
      //
      //   // print(element.title);
      //   // print("The user id 37");
      //
      // });
      print("the given list is : ${rs.runtimeType}");

      TaskModel r =  TaskModel.fromJson(rs['task']);
      // Map<String, dynamic> categoryTypes = dt;

      // categories = ResModel.fromJson(categoryTypes);


      // dt.forEach((element) {
      //   print(element);
      // });



      print("the given task  is : ${r.taskName}");
      print("the given task  is : ${r.taskDescription}");
      print("the given task  is : ${r.assignedPerson}");
      // ResModel md=
      // ResModel(
      //     status: true,
      //     datas:userList_new
      //
      // );
      // print(" line 31 The md is : ${md}");

      // print(ResModel.fromJson(md).status);


      return r;

    } catch (error, stacktrace) {
      // ignore: avoid_print
      print("Exception occured: $error stackTrace: $stacktrace");
      // return ResModel.withError("Data not found / Connection issue");
      // return "Exception occured: $error stackTrace: $stacktrace";
    }


  }



  Future<TaskModel?> updateTask(TaskModel task) async {
    try {

      // userList_new=[];

      print("$baseUrl/updateTask/${task.toJson()}");

      var response = await http.put(Uri.parse("$baseUrl/updateTask/${task.id}"),
        body: json.encode(task),
          headers: { "Content-Type" :"application/json"}
      );
      print(response.body.runtimeType);
      print(response.body);
      TaskModel rs =TaskModel.fromJson(json.decode(response.body)['user']);


      print(rs.toJson());
      dynamic dt ;

      dt=rs;

      // var js = (json.decode(response.data));

      List<dynamic> dlst = [];


      // List<Users>.from(json.decode(response.body).map((x) => Users.fromJson(x)));
      // List<ApiRes>.from(dt.map((model)=> ApiRes.fromJson(model)));;
      // List<ApiRes>.from(dt.map((x) => ApiRes.fromJson(x)))
      //     .forEach((element)
      // {
      //
      //   // print(element.title);
      //   // print("The user id 37");
      //
      // });
      print("the given list is : ${dt.runtimeType}");

      // TaskModel r =  TaskModel.fromJson(rs);
      // Map<String, dynamic> categoryTypes = dt;

      // categories = ResModel.fromJson(categoryTypes);


      // dt.forEach((element) {
      //   print(element);
      // });



      print("the given list is :");
      // ResModel md=
      // ResModel(
      //     status: true,
      //     datas:userList_new
      //
      // );
      // print(" line 31 The md is : ${md}");

      // print(ResModel.fromJson(md).status);

      return rs;

    } catch (error, stacktrace) {
      // ignore: avoid_print
      print("Exception occured: $error stackTrace: $stacktrace");
      // return ResModel.withError("Data not found / Connection issue");
      // return "Exception occured: $error stackTrace: $stacktrace";
    }
    return null;


  }


  Future<TaskModel?> removeTask(TaskModel task) async {
    try {

      // userList_new=[];

      print(urlRemoveTask+"${task.id}");

      var response = await http.delete(Uri.parse(urlRemoveTask+"${task.id}"),
          // body: json.encode(task)
      );
      print(response.body.runtimeType);
      print(response.body);
      var rs =json.decode(response.body);
      List<dynamic> dt = [];

      dt=rs;

      // var js = (json.decode(response.data));

      List<dynamic> dlst = [];


      // List<Users>.from(json.decode(response.body).map((x) => Users.fromJson(x)));
      // List<ApiRes>.from(dt.map((model)=> ApiRes.fromJson(model)));;
      // List<ApiRes>.from(dt.map((x) => ApiRes.fromJson(x)))
      //     .forEach((element)
      // {
      //
      //   // print(element.title);
      //   // print("The user id 37");
      //
      // });
      print("the given list is : ${dt.runtimeType}");

      TaskModel r =  TaskModel.fromJson(rs);
      // Map<String, dynamic> categoryTypes = dt;

      // categories = ResModel.fromJson(categoryTypes);


      // dt.forEach((element) {
      //   print(element);
      // });



      print("the given list is :");
      // ResModel md=
      // ResModel(
      //     status: true,
      //     datas:userList_new
      //
      // );
      // print(" line 31 The md is : ${md}");

      // print(ResModel.fromJson(md).status);

      return r;

    } catch (error, stacktrace) {
      // ignore: avoid_print
      print("Exception occured: $error stackTrace: $stacktrace");
      // return ResModel.withError("Data not found / Connection issue");
      // return "Exception occured: $error stackTrace: $stacktrace";
    }
    return null;


  }

// Future<ResModel> fetchData() async {
//   try {
//
//     userList=[];
//
//     Response response = await _dio.get(url);
//     print(response.data.runtimeType);
//     var rs =response.data;
//     List<dynamic> dt = [];
//
//     dt=rs;
//
//     // var js = (json.decode(response.data));
//
//     List<dynamic> dlst = [];
//
//
//     // List<Users>.from(json.decode(response.body).map((x) => Users.fromJson(x)));
//     // List<ApiRes>.from(dt.map((model)=> ApiRes.fromJson(model)));;
//     // List<ApiRes>.from(dt.map((x) => ApiRes.fromJson(x)))
//     //     .forEach((element)
//     // {
//     //
//     //   // print(element.title);
//     //   // print("The user id 37");
//     //
//     // });
//       print("the given list is : ${dt.runtimeType}");
//
//       userList =   List<ApiRes>.from(dt.map((x) => ApiRes.fromJson(x)));
//     // Map<String, dynamic> categoryTypes = dt;
//
//     // categories = ResModel.fromJson(categoryTypes);
//
//
//     // dt.forEach((element) {
//     //   print(element);
//     // });
//
//
//
//     print("the given list is :");
//     ResModel md=
//       ResModel(
//         status: true,
//         datas:userList
//
//       );
//     print(" line 31 The md is : ${md}");
//
//     // print(ResModel.fromJson(md).status);
//
//
//     return md;
//
//   } catch (error, stacktrace) {
//     // ignore: avoid_print
//     print("Exception occured: $error stackTrace: $stacktrace");
//     return ResModel.withError("Data not found / Connection issue");
//   }
// }

}
