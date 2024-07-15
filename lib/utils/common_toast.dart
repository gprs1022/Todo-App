import 'package:flutter/material.dart';

commonToast(BuildContext context,String massage, {Color? bgColor}) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(massage), backgroundColor: bgColor ?? Colors.red));
}