import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite_bloc_app/shared/Bloc/states.dart';
import 'package:todo_sqflite_bloc_app/shared/Componeds/companed.dart';

import '../../shared/Bloc/cubit.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state){},
        builder: (BuildContext context,AppStates state) {
          var Tasks= AppCubit.get(context).DoneTasks;

          return TaskBuilder(Tasks: Tasks);

        });
  }
}
