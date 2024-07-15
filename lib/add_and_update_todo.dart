import 'package:flutter/material.dart';
import 'package:todo_app/add_and_update_todo.dart';
import 'package:todo_app/api_services/api_service.dart';
import 'package:todo_app/todo_list_screen.dart';
import 'package:todo_app/utils/common_toast.dart';

import 'models/get_all_todos.dart';

class AddAndUpdateTodo extends StatefulWidget {

  final Items? items;

  const AddAndUpdateTodo({super.key, this.items});

  @override
  State<AddAndUpdateTodo> createState() => _AddAndUpdateTodoState();
}

class _AddAndUpdateTodoState extends State<AddAndUpdateTodo> {

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  bool isComplete = false;
  bool isLoading = false;

  @override
  void initState(){
   if(widget.items != null ) {
     title.text = widget.items?.title??"";
     description.text = widget.items?.description??"";
     isComplete = widget.items?.isCompleted??false;
     setState(() {

     });
   }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.items == null? "Add Todo": "Update Todo"),
      ),

        body: Padding(
          padding:const EdgeInsets.all(12.0),
          child: Column(
            children: [

              TextFormField(
                controller: title ,
                autofocus: widget.items == null? true:false ,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,fontSize: 18
                ),
                decoration: const InputDecoration(
                  hintText: 'title',
                  border:InputBorder.none

                ),
              ),

              TextFormField(
                controller: description,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,fontSize: 18
                ),
                decoration: const InputDecoration(
                    hintText: 'Description',
                    border:InputBorder.none

                ),
              ),

              const Divider(

              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Complete', style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),),
                  Switch(
                      value: isComplete,
                      activeColor: Colors.blue,
                      onChanged: (bool value) {
                    setState(() {
                      isComplete = value;
                    });
                      })
                ],
              ),
            ],
          ),
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){

          if(title.text.isEmpty) {

            commonToast(context, 'Please Enter title');
          } else if(description.text.isEmpty){
            commonToast(context, 'Please Enter description');
          } else{

            setState(() {
              isLoading = true;
            });
          }

          if(widget.items == null){
            ApiSservice().addTodos(title.text.toString(), description.text, isComplete).then((value){
              setState(() {
                isLoading = false;
              });
              Navigator.pop(context, true);


            }).onError((error, stackTrace){
              debugPrint(error.toString());
              setState(() {
                isLoading = false;
              });
              commonToast(context, 'Something Went wrong');
            });
          } else {
            ApiSservice().updateTodos(widget.items!.sId!, title.text.toString(), description.text.toString(), isComplete).then((value){
              setState(() {
                isLoading = false;
              });
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  TodoListScreen()));
            }).onError((error, stackTrace){
              debugPrint(error.toString());
              setState(() {
                isLoading = false;
              });
              commonToast(context, 'Something went wrong');
            });
          }

        },
        child: isLoading?  const  CircularProgressIndicator(): const Icon(Icons.check , color: Colors.blue),
      ),
    );
  }

}