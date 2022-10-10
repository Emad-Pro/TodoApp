import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp_todo/shared/cubit/states.dart';

import '../../components/components.dart';
import '../../shared/cubit/cubit.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          var tasksshort = AppCubit.get(context).taskslist;
          return ConditionalBuilder(
            condition: tasksshort.length > 0,
            builder: (context) => ListView.separated(
              itemBuilder: ((context, index) => Dismissible(
                    background: swapdelete(),
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      cubit.deleteData(tasksshort[index]["id"]);
                    },
                    child: builditems(
                      btnmissin: () {
                        AppCubit.get(context)
                            .updateData('DONE', tasksshort[index]["id"]);
                      },
                      btnmissin2: () {
                        AppCubit.get(context)
                            .updateData('ARCIVE', tasksshort[index]["id"]);
                      },
                      context: context,
                      iconbtnmissin: Icons.check_circle_outline,
                      iconbtnmissin2: Icons.archive_outlined,
                      colorbtnmissin: Colors.green,
                      colorbtnmissin2: Colors.grey[700],
                      textTime: tasksshort[index]["time"],
                      textDate: tasksshort[index]["date"],
                      textTitle: tasksshort[index]["title"],
                    ),
                  )),
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1,
              ),
              itemCount: tasksshort.length,
            ),
            fallback: (context) => Center(
                child: Text(
              "  لا توجد مهام حتي الان ...\nتمت برمجة هذا البرنامج بواسطة \n EMad Younis ",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w800),
            )),
          );
        });
  }
}
