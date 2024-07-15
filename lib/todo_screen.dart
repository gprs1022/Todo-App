import 'package:flutter/material.dart';
import 'package:todo_app/add_and_update_todo.dart';
import 'package:todo_app/delete_button.dart';

import 'models/get_all_todos.dart';

class TodoScreen extends StatelessWidget {
 final List<Items> todolist;
  const TodoScreen({super.key, required this.todolist});

  @override
  Widget build(BuildContext context) {

    return todolist.isEmpty?
        Center(
          child: Text("Todo not found", textScaleFactor: 2,),
        ):
     ListView.separated(
         itemCount: todolist.length,
        padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        separatorBuilder: (context, i) => SizedBox(height: 10,),

      itemBuilder: (context,index){

          final item = todolist[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAndUpdateTodo(items:item)));
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(item.title??"", style:const TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w400
                        ),),
                      ),
                      DeleteButton(id: item.sId??""),
                    ],
                  ),

                  Text(item.description??"",style:const TextStyle(fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal:12 , vertical: 8),
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue,
                    ),
                    child: Text(item.isCompleted == true?"Complete":"Incomplete",style: const TextStyle(color: Colors.white),),
                  ),
                ],
              ),
              ),
            ),
          );
      }
    );
  }
}