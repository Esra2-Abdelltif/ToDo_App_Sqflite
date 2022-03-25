import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite_bloc_app/shared/Bloc/cubit.dart';
import 'package:todo_sqflite_bloc_app/shared/Bloc/states.dart';
import 'package:todo_sqflite_bloc_app/shared/Constans/constans.dart';

class Setting extends StatelessWidget {
  const Setting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state)
        {
          if (state is AppDeleteAllDataBaseState) {Navigator.pop(context);}
        },
        builder: (BuildContext context ,AppStates state) {
         // AppCubit cubit = AppCubit.get(context);
          return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                ),
                Text('Setting', style: TextStyle(color: Colors.white,fontSize: 20)
                ),
                SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: ()=> showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Delete All Item'),
                      content: const Text('Do You sure ?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            //BlocProvider.of<AppCubit>(context).deleteAll(db: database);
                           AppCubit.get(context).deleteAll(db:database);
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                      elevation: 24,
                      backgroundColor: Color(0xFF1D1E33),
                      // shape: CircleBorder(),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Delete All', style: TextStyle(color: Colors.white,fontSize: 16)),


                    ],
                  ),
                ),
              ],
            ),
          );
        }

    );
}
}

