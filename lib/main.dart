import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/core/app_contstans.dart';
import 'package:todo_app/features/home/models/user_model.dart';
import 'package:todo_app/todo_app.dart';



void main()async{

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>(AppConstants.userBox);
  runApp(TodoApp());
}