import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_sqflite_bloc_app/shared/companed.dart';
import 'package:todo_sqflite_bloc_app/shared/constans.dart';


class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder:(context,index)=> BuildTaskItem(Tasks[index]),itemCount:Tasks.length,);
    //




  }
}
