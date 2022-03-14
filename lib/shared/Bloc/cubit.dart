import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_sqflite_bloc_app/modules/ArchivedScreen/ArchivedScreen.dart';
import 'package:todo_sqflite_bloc_app/modules/DoneScreen/DoneScreen.dart';
import 'package:todo_sqflite_bloc_app/modules/TaskScreen/TaskScreen.dart';
import 'package:todo_sqflite_bloc_app/shared/Bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialAppState());
  static  AppCubit get(context) => BlocProvider.of(context);
  int CurrentIndex = 0;

  List<Widget> Screen = [
    TaskScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];

  List<String> TitleAppBar = ['New Tasks', 'Done', 'New Archived'];
  void ChangeIndex(int index){
    CurrentIndex=index;
    emit(AppChangeBottomNavBaeState());
  }


}
