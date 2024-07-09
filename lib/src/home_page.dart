import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_test/src/bloc/task_management_event.dart';
import 'package:interview_test/src/model/task_model.dart';

import 'bloc/task_management_bloc.dart';
import 'bloc/task_management_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var selectedId;
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  final _assignedPerson = TextEditingController();
  final List<String> employeeList = [
    "Ramu",
    "Raju",
    "Usman",
    "Shamsu",
    "Ramesh",
    "Rahoof",
    "Thoyyib"
  ];

  bool? isUpdate = false;

  String? selectedValue;
  final _formKey = GlobalKey<FormState>();
  TaskBloc ? _taskBloc;

  @override
  void initState() {

    // _taskBloc = TaskBloc();
    super.initState();
  }

  Future showDeleteDialog(TaskModel? task) {
    Widget yesDeleteButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        // BlocProvider<TaskBloc>(bloc: _tabBloc).child.
        BlocProvider.of<TaskBloc>(context).add(DeleteTask(task: task)
            // MyEvent(
            // data: data,
            // onSuccess: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) {
            //       return HomePage();
            //     }),
            //   );
            // })
            );
        // showDeleteDialog();

        // alertDelete;
        // setState((){
        //   isUpdate = true;
        //   var id;
        //   selectedId = state.allTasks![index].id!;
        //   _taskNameController.text =
        //   state.allTasks![index].taskName!;
        //
        //   _taskDescriptionController.text =
        //   state.allTasks![index].taskDescription!;
        //
        //   selectedValue =
        //   state.allTasks![index].assignedPerson!;
        //
        // });
        Navigator.pop(context);
      },
    );

    Widget noDeleteButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alertDelete = AlertDialog(
        title: Text("Task Management"),
        content: Text("Are your sure to delete ?"),
        actions: [yesDeleteButton, noDeleteButton]);

    return showDialog(
        context: context,
        builder: (context) {
          return alertDelete;
        });
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    _assignedPerson.dispose();

    super.dispose();
  }

  void _addTask() {
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
        enableDrag: true,
        context: context,
        builder: (context) => BlocBuilder<TaskBloc, TaskState?>(
                // bloc: this._bloc,
                builder: (context, state) {
              List<TaskModel>? taskList = state?.allTasks;

              if (state!.allTasks!.isEmpty) {
                return CircularProgressIndicator(
                  color: Colors.pink,
                );
              }

              return ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _taskNameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(14.0),
                                        left: Radius.circular(14.0))),
                                hintText: "Task Name"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                // Validation Logic
                                return 'Please enter Task Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _taskDescriptionController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(14.0),
                                        left: Radius.circular(14.0))),
                                hintText: "Task Description"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Select Employee',
                                      style: TextStyle(
                                        fontSize: 14,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: employeeList
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValue = value!;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 60,
                                // width: 160,
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                  color: Colors.white,
                                ),
                                elevation: 0,
                              ),
                              iconStyleData: const IconStyleData(

                                  // icon: Container(),
                                  // iconSize: 14,
                                  // iconEnabledColor: Colors.yellow,
                                  // iconDisabledColor: Colors.grey,
                                  ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                // width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),
                                offset: const Offset(0, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness:
                                      MaterialStateProperty.all<double>(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all<bool>(false),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                // padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.cyan),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   const SnackBar(
                                      //       content: Text('Processing Data')),
                                      // );

                                      TaskModel task = !isUpdate!
                                          ? TaskModel(
                                              taskName:
                                                  _taskNameController.text,
                                              taskDescription:
                                                  _taskDescriptionController
                                                      .text,
                                              assignedPerson:
                                                  selectedValue ?? "")
                                          : TaskModel(
                                              taskName:
                                                  _taskNameController.text,
                                              taskDescription:
                                                  _taskDescriptionController
                                                      .text,
                                              assignedPerson:
                                                  selectedValue ?? "");

                                      print(task.taskName);

                                      // return;
                                      // BlocProvider.of<TaskBloc>(context).add(AddTask(task: task));

                                      !isUpdate!
                                          ? context
                                              .read<TaskBloc>()
                                              .add(AddTask(task: task))
                                          : context
                                              .read<TaskBloc>()
                                              .add(UpdateTask(task: task));
                                      setState(() {
                                        _taskNameController.text = "";
                                        _taskDescriptionController.text = "";
                                        selectedValue = "";
                                      });
                                      _taskNameController.clear();
                                      _taskDescriptionController.clear();
                                      _assignedPerson.clear();
                                      _formKey.currentState?.reset();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          centerTitle: true,
          title: Text("Task View"),
        ),
        body: Column(
          children: [
// BlocBuilder(builder: builder)

            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Center(child: BlocListener<TaskBloc, TaskState>(
                  listener: (context, state) {

                    state.allTasks?.forEach((element) {print(element.taskDescription);});
                    if (state is TaskError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("state.message"),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<TaskBloc, TaskState?>(
                      // bloc: this._bloc,
                      builder: (context, state) {
                    // if(state is Up)

                    List<TaskModel>? taskList = state?.allTasks;
                    if (state is TaskLoaded) {
                      print("The task list view   1");

                      // print();
                      state.allTasks!.forEach((element) {
                        print(element.taskName);

                      });
                      print("The task list view n");
                    }

                    if (state!.allTasks!.isEmpty) {
                      print("The given list is empty");
                      return Container(
                          // color: Colors.pink,

                          );
                    }

                    print("The task list view");

                    // print();
                    state.allTasks!.forEach((element) {
                      print(element.taskName);
                      print("The task list view");
                    });
                    if (state is TaskLoaded) {
                      print("The task list view");

                      // print();
                      state.allTasks!.forEach((element) {
                        print(element.taskName);
                        print("The task list view");
                      });
                    }

                    return ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: taskList!.length,
                        itemBuilder: (context, int index) {
                          return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: Colors.black, width: 0.2)),
                              height: MediaQuery.of(context).size.height / 6,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Task Name ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Expanded(
                                          child: Text(
                                        ": ${state.allTasks?[index].taskName ?? ""}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black),
                                      )),
                                      IconButton(
                                        onPressed: () {
                                          print(
                                              "Selected item : ${state.allTasks?[index].taskName}");
                                          print("The location selected ");
                                          // all are calculated as per result shown in the figure
                                          // how it try to get the sub inspector.. sir you can get it.
                                          // they have already done.
                                          // i work everyday.
                                          // he works everyday

                                          Widget updateButton = TextButton(
                                            child: const Text("Update"),
                                            onPressed: () {
                                              setState(() {
                                                isUpdate = true;
                                                var id;
                                                print("The id is");
                                                print(state.allTasks![index].toJson());
                                                selectedId =
                                                    state.allTasks![index].id!;
                                                _taskNameController.text = state
                                                    .allTasks![index].taskName!;

                                                _taskDescriptionController.text =
                                                    state.allTasks![index]
                                                        .taskDescription!;

                                                selectedValue = state
                                                    .allTasks![index]
                                                    .assignedPerson!;
                                              });
                                              Navigator.pop(context);
                                            },
                                          );

                                          Widget deleteButton = TextButton(
                                            child: Text("Delete"),
                                            onPressed: () {
                                              Navigator.pop(context);

                                              showDeleteDialog(
                                                  state.allTasks![index]);

                                              // alertDelete;
                                              // setState((){
                                              //   isUpdate = true;
                                              //   var id;
                                              //   selectedId = state.allTasks![index].id!;
                                              //   _taskNameController.text =
                                              //   state.allTasks![index].taskName!;
                                              //
                                              //   _taskDescriptionController.text =
                                              //   state.allTasks![index].taskDescription!;
                                              //
                                              //   selectedValue =
                                              //   state.allTasks![index].assignedPerson!;
                                              //
                                              // });
                                            },
                                          );

                                          // set up the AlertDialog
                                          AlertDialog alert = AlertDialog(
                                            title: Text("Task Management"),
                                            content: Text("Select Option ?"),
                                            actions: [updateButton, deleteButton],
                                          );

                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return alert;
                                              });
                                        },
                                        icon: Icon(Icons.more_horiz),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        "id",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Expanded(
                                          child: Text(
                                        ": ${state.allTasks?[index].id ?? ""}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        "Description",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Expanded(
                                          child: Text(
                                        ": ${state.allTasks?[index].taskDescription ?? ""}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        "Assigned",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      // SizedBox(width: 10,),
                                      Expanded(
                                        child: Text(
                                          ": ${state.allTasks?[index].assignedPerson ?? ""}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                ],
                              ));
                        });
                  }),
                )),
              ),
            ),
            Expanded(child: BlocBuilder<TaskBloc, TaskState?>(
                // bloc: this._bloc,
                builder: (context, state) {
              List<TaskModel>? taskList = state?.allTasks;

              // if (state!.allTasks!.isEmpty) {
              //   return CircularProgressIndicator(
              //     color: Colors.pink,
              //
              //   );
              // }

              return SingleChildScrollView(
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TextFormField(
                        //   // controller: _,
                        //   decoration: const InputDecoration(
                        //     border: OutlineInputBorder(
                        //
                        //     )
                        //   ),
                        // ),
                        // Row(children: [
                        //   TextFormField(
                        //     // controller:,
                        //     decoration: const InputDecoration(border: OutlineInputBorder()),
                        //   )
                        // ],),

                        TextFormField(
                          controller: _taskNameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(14.0),
                                      left: Radius.circular(14.0))),
                              hintText: "Task Name"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              // Validation Logic
                              return 'Please enter Task Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _taskDescriptionController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(14.0),
                                      left: Radius.circular(14.0))),
                              hintText: "Task Description"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Select Employee',
                                    style: TextStyle(
                                      fontSize: 14,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: employeeList
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 60,
                              // width: 160,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: Colors.white,
                              ),
                              elevation: 0,
                            ),
                            iconStyleData: const IconStyleData(),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              // width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              offset: const Offset(0, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all<double>(6),
                                thumbVisibility:
                                    MaterialStateProperty.all<bool>(false),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              // padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.cyan),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (selectedValue == null ||
                                        selectedValue == "") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text('Select Assign')),
                                      );
                                      return;
                                    }

                                    // print(   taskList?.last.id! +1);
                                    dynamic lastId = taskList!.isEmpty
                                        ? 1
                                        : taskList.last.id;

                                    // int id =
                                    //     !isUpdate! ? lastId + 1 : selectedId;

                                    TaskModel task = TaskModel(
                                        id: selectedId,
                                        taskName: _taskNameController.text,
                                        taskDescription:
                                            _taskDescriptionController.text,
                                        assignedPerson: selectedValue ?? "");

                                    // BlocProvider.of<TaskBloc>(context).add(AddTask(task: task));

                                    print("Update : ${isUpdate!}");
                                    print(task.toJson());
                                    // return;

                                    !isUpdate!
                                        ? context
                                            .read<TaskBloc>()
                                            .add(AddTask(task: task))
                                        : context
                                            .read<TaskBloc>()
                                            .add(UpdateTask(task: task));

                                    setState(() {
                                      isUpdate! == true
                                          ? isUpdate = false
                                          : true;
                                    });
                                    _taskNameController.text = "";
                                    _taskDescriptionController.text = "";
                                    _assignedPerson.text = "";
                                    selectedValue = null;

                                    // _formKey.currentState?.reset();
                                  }
                                },
                                child:  Text(
                                  !isUpdate! ? 'Submit' :"update",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }))
          ],
        ),
        //   floatingActionButton: Container(
        //
        //     // margin: const EdgeInsets.only(bottom:600),
        //     child: FloatingActionButton(
        //       tooltip: "Assign Task",
        //       // child: _addTask(),
        //
        //       backgroundColor: Colors.cyan,
        //       child: Icon(Icons.add),
        //       onPressed: () { _addTask(); },
        // ),
        //   ),
      ),
    );
  }
}
// }
