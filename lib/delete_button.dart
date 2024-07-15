import 'package:flutter/material.dart';
import 'package:todo_app/api_services/api_service.dart';
import 'package:todo_app/todo_list_screen.dart';
import 'package:todo_app/utils/common_toast.dart';

class DeleteButton extends StatefulWidget {
  final String id;

  const DeleteButton({super.key, required this.id});

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLoading = true;
        });
        ApiSservice().deleteTodos(widget.id).then((value) {
          commonToast(context, 'Deleted Successfully', bgColor: Colors.green);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => TodoListScreen()));
          setState(() {
            isLoading = false;
          });
        }).onError((error, stackTrace) {
          debugPrint(error.toString());
          setState(() {
            isLoading = false;
          });
          commonToast(context, 'Something went wrong');
        });
      },
      child: Container(
        height: 40, width: 100,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: isLoading
            ? SizedBox(

                child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator()))
            : Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
      ),
    );
  }
}
