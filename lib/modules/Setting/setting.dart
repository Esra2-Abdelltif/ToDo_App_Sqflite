import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite_bloc_app/shared/Bloc/cubit.dart';
import 'package:todo_sqflite_bloc_app/shared/Bloc/states.dart';
import 'package:todo_sqflite_bloc_app/shared/Constans/constans.dart';
import 'package:todo_sqflite_bloc_app/shared/Styles/colors.dart';

class Setting extends StatelessWidget {
  const Setting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state)
        {
          if (state is AppDeleteAllDataBaseState) {Navigator.pop(context);}
        },
        builder: (BuildContext cubitcontext ,AppStates state) {
         // AppCubit cubit = AppCubit.get(context);
          return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                ),
                Text('General Setting', style: TextStyle(color: Colors.grey[400],fontSize: 16)
                ),
                SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: ()=> showDialog(
                    context: cubitcontext,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Delete All Items'),
                      content: const Text('Do You sure ?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                           AppCubit.get(cubitcontext).deleteAll(db:database);
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
                          color: PrimaryColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.grey[400],
                          size: 22,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Delete All', style: TextStyle(color: TextColor,fontSize: 16)),


                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                // Row(
                //   children: [
                //     Container(
                //       width: 35,
                //       height: 35,
                //       decoration: BoxDecoration(
                //         color: PrimaryColor,
                //         borderRadius: BorderRadius.circular(7),
                //       ),
                //       child: Icon(
                //         Icons.brightness_2_outlined,
                //         color: Colors.grey[400],
                //         size: 22,
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Text('Dark Mode', style: TextStyle(color: TextColor,fontSize: 16)),
                //
                //
                //   ],
                // ),
              ],
            ),
          );
        }

    );
}
}

