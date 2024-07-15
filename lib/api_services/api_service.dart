import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo_model.dart';

import '../models/get_all_todos.dart';

class ApiSservice {

  String baseUrl = "https://api.nstack.in";
 // get All todos
  Future<GetAllTodosModel> getAllTodos() async{
    
    var response =  await http.get(Uri.parse('$baseUrl/v1/todos'));
    if(response.statusCode == 200 ){

      debugPrint(jsonDecode(response.body).toString());
      final data =  GetAllTodosModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('API Error');
    }


  }

//add todos
  Future<TodosModels> addTodos(String title, String description, bool isComplete ) async{

    var response =  await http.post(Uri.parse('$baseUrl/v1/todos'),
    headers: {"Content-Type" : "application/json"},
      body: jsonEncode({

          "title": title,
          "description":description,
          "is_completed": isComplete

      })
    );
    if(response.statusCode == 201 ){

      debugPrint(jsonDecode(response.body).toString());
      final data =  TodosModels.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('API Error');
    }
  }


  //update todos



  Future<TodosModels> updateTodos(String id,String title, String description, bool isComplete ) async{

    var response =  await http.put(Uri.parse('$baseUrl/v1/todos/$id'),
        headers: {"Content-Type" : "application/json"},
        body:  jsonEncode({

          "title": title,
          "description":description,
          "is_completed": isComplete

        })
    );
    if(response.statusCode == 200 ){

      debugPrint(jsonDecode(response.body).toString());
      final data =  TodosModels.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('API Error');
    }
  }

  // delete todos

  Future<GetAllTodosModel> deleteTodos(String id) async{

    var response =  await http.delete(Uri.parse('$baseUrl/v1/todos/$id'));
    if(response.statusCode == 200 ){

      debugPrint(jsonDecode(response.body).toString());
      final data =  GetAllTodosModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('API Error');
    }


  }

}