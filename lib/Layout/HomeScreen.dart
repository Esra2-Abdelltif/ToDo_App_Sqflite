import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqflite_bloc_app/shared/Bloc/cubit.dart';
import 'package:todo_sqflite_bloc_app/shared/Bloc/states.dart';
import 'package:todo_sqflite_bloc_app/shared/Componeds/companed.dart';
import 'package:todo_sqflite_bloc_app/shared/Constans/constans.dart';


class HomeScreen extends StatelessWidget {
 // const ({Key key}) : super(key: key);

  var TitleController = TextEditingController();
  var DateController = TextEditingController();
  var TimeController = TextEditingController();
  var StatusController = TextEditingController();
  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(//.. bt5lny ader acesse 3la ele da5l appcubit
        create:(BuildContext context)=>AppCubit()..CreatDataBase(),
        child: BlocConsumer<AppCubit,AppStates>(
            listener: (BuildContext context,AppStates state)
            {
             // if(state is InitialAppState) print('intial state');
              if (state is AppInsertDataBaseState) {Navigator.pop(context);}
            },
            builder: (BuildContext context ,AppStates state) {
              AppCubit cubit = AppCubit.get(context);
              return Scaffold(
                backgroundColor: Color(0xFF031956),
                key: ScaffoldKey,
                appBar: AppBar(
                  backgroundColor: Color(0xFF031956), centerTitle: true,
                  title: Text(cubit.TitleAppBar[cubit.CurrentIndex],),
                  leading: IconButton(onPressed: (){
                   // AppCubit.get(context).deleteAll(db:database);
                  },icon:Icon(Icons.delete),color:  Colors.purple),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  fixedColor: Colors.purple,
                  unselectedItemColor: Color(0xFF8D8E98),
                  elevation: 5,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.menu), label: 'Tasks'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.check_circle_outline), label: 'Done'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive_outlined), label: 'Archived'),
                   BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Setting'),
                  ],
                  backgroundColor: Color(0xFF031956),
                  currentIndex: cubit.CurrentIndex,
                  onTap: (index) {
                      cubit.ChangeIndex(index);
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  elevation: 5,
                  backgroundColor: Colors.purple,
                  onPressed: () {
                    if (cubit.IsBottomSheet) {
                      if (FormKey.currentState.validate()) {
                       cubit.InsertDataBase(date: DateController.text, time: TimeController.text,title: TitleController.text);
                       TitleController.clear();
                       TimeController.clear();
                       DateController.clear();
                      }
                    } else {
                      ScaffoldKey.currentState.showBottomSheet((context) =>
                          Container(
                            decoration: BoxDecoration(
                            color: Color(0xFF031956),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                               // color: Colors.white,
                                child: Form(
                                  key: FormKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      //Ttile
                                      defultTextFormField(
                                          controller: TitleController,
                                          type: TextInputType.text,
                                          label: 'Task Title',
                                          prefixIcon: Icons.title),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      //Time
                                      defultTextFormField(
                                        controller: TimeController,
                                        ontap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((dynamic value) {

                                               TimeController.text = value.format(context).toString();

                                          });
                                        },
                                        type: TextInputType.datetime,
                                        label: 'Task Time',
                                        prefixIcon: Icons.watch_later_outlined,
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      //Date
                                      defultTextFormField(
                                          controller: DateController,
                                          ontap: () {
                                            showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate:
                                                DateTime.parse('2022-04-04'))
                                                .then((dynamic value) {
                                                 DateController.text = DateFormat.yMMMd().format(value);

                                            });
                                          },
                                          type: TextInputType.datetime,
                                          label: 'Task Date',
                                          prefixIcon: Icons.calendar_today),
                                      SizedBox(height: 10,),
                                      //Status
                                      // defultTextFormField(
                                      //     controller:     StatusController,
                                      //     type:TextInputType.text,
                                      //     label: 'Task Staus', prefixIcon: Icons.title),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ),
                      ).closed.then((value) {
                        cubit.ChangeBottomSheet(isShow: false, icon: Icons.edit);


                      });
                      cubit.ChangeBottomSheet(isShow: true, icon: Icons.add);
                    }
                  },
                  child: Icon(cubit.FloatIcon),
                ),

                 // body: cubit.Screen[cubit.CurrentIndex],
                 // state is! AppGetDataBaseLoadingState ?  Center(child: CircularProgressIndicator()): cubit.Screen[cubit.CurrentIndex]
                body:ConditionalBuilder(
                  builder: (context)=> cubit.Screen[cubit.CurrentIndex],
                  condition: state is! AppGetDataBaseLoadingState ,
                  fallback:(context)=>  CircularProgressIndicator() ,
                ),
              );
            }

    ),
              );
  }


}
