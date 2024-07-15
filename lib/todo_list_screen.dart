import 'package:flutter/material.dart';
import 'package:todo_app/add_and_update_todo.dart';
import 'package:todo_app/api_services/api_service.dart';
import 'package:todo_app/models/get_all_todos.dart';
import 'package:todo_app/models/get_all_todos.dart';
import 'package:todo_app/todo_screen.dart';

import 'models/get_all_todos.dart';



class TodoListScreen extends StatefulWidget {
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  GetAllTodosModel getAllTodosModel = GetAllTodosModel();
  List<Items> inCompleteTodo = [];
  List<Items> completeTodo = [];
  bool isLoading = false;

  getAllTodos () async {

    setState(() {
      isLoading = true;
      getAllTodosModel.items?.clear();
      inCompleteTodo.clear();
      completeTodo.clear();
    });



    await ApiSservice().getAllTodos().then((value){
      
      getAllTodosModel = value;
      for(var todo in value.items!){
          
        if(todo.isCompleted ==true){
          completeTodo.add(todo);
        } else {
          inCompleteTodo.add(todo);
        }
        isLoading = false;

        setState(() {

        });
      }
      setState(() {

      });
    }).onError((error, stackTrace){
      debugPrint(error.toString());
    });

  }

  @override
  void initState(){

    getAllTodos();
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 3,
          child: Scaffold(

            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text("Todo List"),
              bottom: TabBar(
                  labelPadding: EdgeInsets.symmetric(vertical: 10),
                  labelStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),
                  tabs: [
                    Text("All",style: TextStyle(color: Colors.white),),
                    Text("Incomplete",style: TextStyle(color: Colors.white),),
                    Text("Complete",style: TextStyle(color: Colors.white),),

                  ]
              ),

            ),
            body: isLoading? const Center(child: CircularProgressIndicator(),):
            TabBarView(

                children: [
                  TodoScreen(todolist: getAllTodosModel.items??[]),
                  TodoScreen(todolist: inCompleteTodo),
                  TodoScreen(todolist: completeTodo),
                ],
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () async{
                bool loading = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddAndUpdateTodo()));

                if(loading == true){
                  getAllTodos();
                }
              },
              child: const Icon(Icons.add , color: Colors.blue),
            ),

          ),
        ),
    );


  }
}









