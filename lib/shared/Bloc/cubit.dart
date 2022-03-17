import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
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
  List<Map> NewsTasks=[];
  List<Map> DoneTasks=[];
  List<Map> ArchiveTasks=[];

  Database database;
  IconData FloatIcon = Icons.edit;
  bool IsBottomSheet = false;

  List<Widget> Screen = [
    TaskScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];

  List<String> TitleAppBar = ['New Tasks', 'Done', 'New Archived'];
  void ChangeIndex(int index){
    CurrentIndex=index;
    emit(AppChangeBottomNavBarState());
  }

  void CreatDataBase() {
    openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) {
        print('DataBase Created');
        database
            .execute(
            'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('Table created');
        }).catchError((error) {
          print('Error when Create Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        GetDataFromDataBase(database);
        print('open DataBase');
      },
    ).then((value) {
      database=value;
      emit(AppCreateDataBaseState());
    });
  }

   InsertDataBase({@required title, @required date,@required time}) async {
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO Tasks(title, date, time,status) VALUES("$title"," $date", "$time","New")'
      ).then((value) {
        print('$value insert succefuly');
        emit(AppInsertDataBaseState());

        GetDataFromDataBase(database);
        
      }).catchError((error) {
        print('Error when insert new  ${error.toString()}');
      });
      return null;
    });
  }

  void GetDataFromDataBase(database)  {
    NewsTasks=[];
    ArchiveTasks=[];
    DoneTasks=[];
    emit(AppGetDataBaseLoadingState());
     database.rawQuery('SELECT * FROM Tasks').then((value) {
       value.forEach((element) {
         if(element['status']=='New'){
           NewsTasks.add(element);
         }
         else if(element['status']=='Done'){
           DoneTasks.add(element);
         }
         else {
           ArchiveTasks.add(element);
         };

       });
       emit(AppGetDataBaseState());



     });

  }
  void UpdateDataBase({@required String status ,@required int id})async{
     database.rawUpdate(
        'UPDATE Tasks SET status = ?  WHERE id = ?',
        ['$status', '$id']).then((value) {
          GetDataFromDataBase(database);
          emit(AppUpdatetDataBaseState());
     });
   
  }
  void DeleteDataBase({@required int id})async{
     database.rawDelete('DELETE FROM Tasks WHERE id = ?', ['$id']).then((value) {
      GetDataFromDataBase(database);
      emit(AppDeleteDataBaseState());
    });

  }

  void ChangeBottomSheet({@required bool isShow ,@required IconData icon}){
    IsBottomSheet=isShow;
    FloatIcon=icon;
    emit(AppChangeBottomSheetState());
  }


}
