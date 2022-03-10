
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqflite_bloc_app/models/ArchivedScreen/ArchivedScreen.dart';
import 'package:todo_sqflite_bloc_app/models/DoneScreen/DoneScreen.dart';
import 'package:todo_sqflite_bloc_app/models/TaskScreen/TaskScreen.dart';
import 'package:todo_sqflite_bloc_app/shared/companed.dart';
import 'package:todo_sqflite_bloc_app/shared/constans.dart';


class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int CurrentIndex=0;

  List<Widget> Screen =[

/////////////
    TaskScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];

  List<String> TitleAppBar=['New Tasks','Done','New Archived'];
  late Database database;
  var TitleController=TextEditingController();
  var  DateController=TextEditingController();
  var TimeController=TextEditingController();
  var StatusController=TextEditingController();
  // ignore: non_constant_identifier_names
  var ScaffoldKey =GlobalKey<ScaffoldState>();
  var FormKey =GlobalKey<FormState>();
  IconData FloatIcon=Icons.edit;
  bool IsBottomSheet=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CreatDataBase();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScaffoldKey,
      appBar: AppBar(
        title: Text(TitleAppBar[CurrentIndex]),),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu),label:'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline),label:'Done'),
          BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),label:'Archived'),
        ],
        currentIndex: CurrentIndex,
        onTap:(index){
          setState(() {
            CurrentIndex=index;
          });
        } ,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        if(IsBottomSheet)
        {
          if(FormKey.currentState!.validate())
          {
          InsertDataBase(
              date: DateController.text,
              time: TimeController.text,
            title: TitleController.text
          ).then((value) {

            GetDataFromDataBase(database).then((value)
            {
              Navigator.pop(context);
                setState(() {
                  IsBottomSheet=false;
                  FloatIcon=Icons.edit;
                  Tasks = value;
                });
            });
          });
          }
        }
        else{
          ScaffoldKey.currentState?.showBottomSheet((context) =>
              Container(
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius:BorderRadius.circular(40) ,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: FormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Ttile
                        defultTextFormField(

                            controller: TitleController,
                            type:TextInputType.text,
                            label: 'Task Title', prefixIcon: Icons.title),
                        SizedBox(height: 10,),

                        //Time
                        defultTextFormField(

                            controller: TimeController,
                            ontap: (){
                            showTimePicker(context: context, initialTime: TimeOfDay.now(),
                             ).then(( dynamic value)
                             {
                               setState(() {
                                 TimeController.text=value.format(context).toString();
                              });

                             });
                            },

                            type:TextInputType.datetime,
                            label: 'Task Time', prefixIcon: Icons.watch_later_outlined,

                        ),

                        SizedBox(height: 10,),
                        //Date
                        defultTextFormField(
                            controller: DateController,
                            ontap: (){
                              showDatePicker(context: context,
                                  initialDate:DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2022-04-04')
                              ).then(( dynamic value)
                              {
                                setState(() {
                                  DateController.text=DateFormat.yMMMd().format(value);
                                });


                              });
                            },
                            type:TextInputType.datetime,
                            label: 'Task Date', prefixIcon: Icons.calendar_today),
                        SizedBox(height: 10,),
                        //Status
                        // defultTextFormField(
                        //     controller:     StatusController,
                        //     type:TextInputType.text,
                        //     label: 'Task Staus', prefixIcon: Icons.title),


                      ],),
                  ),
                ),
              ),
          ).closed.then((value)  {

              IsBottomSheet=false;
              setState(() {
            FloatIcon=Icons.edit;
          });
    });

          IsBottomSheet=true;
          setState(() {
            FloatIcon=Icons.add;
          });
        }
      },
      child: Icon(FloatIcon),),
      body:Tasks.length ==0 ? Center(child: CircularProgressIndicator()):  Screen[CurrentIndex],
      // body:ConditionalBuilder(
      //   builder: (context)=> Screen[CurrentIndex],
      //   condition: Tasks.length >0,
      //   fallback:(context)=>  CircularProgressIndicator() ,
      // ),
    );
  }


  void CreatDataBase() async
  {
     database = await openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) {
        print('DataBase Created');
        database.execute(
            'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('Table created');
        }).catchError((error) {
          print('Error when Create Table ${error.toString()}');
        });
      },
      onOpen: (database) {
       GetDataFromDataBase(database).then((value)  {

        //   setState(() {
             Tasks = value;
         //  });
       });
        print('open DataBase');
      },
    );
  }
 Future InsertDataBase({required title,required  date,required time}) async
 {
   return await database.transaction((txn) async {
      txn.rawInsert('INSERT INTO Tasks(title, date, time,status) VALUES("$title"," $date", "$time","New")'
      ).then((value){
        print('$value insert succefuly');
      }).catchError((error) {
        print('Error when insert new  ${error.toString()}');
      });
    });
  }
  Future<List<Map>> GetDataFromDataBase(database) async{
   return await database.rawQuery('SELECT * FROM Tasks');
    print(Tasks);

  }

}
