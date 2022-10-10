import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp_todo/shared/cubit/states.dart';

import '../../components/components.dart';
import '../../shared/cubit/cubit.dart';

class donescreen extends StatelessWidget {
  const donescreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          var doneshort = AppCubit.get(context).donelist;
          return ConditionalBuilder(
            condition: doneshort.length > 0,
            fallback: (context) => Center(
                child: Text(
              "لم تقم بأنجاز اي مهام حتي الان",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w800),
            )),
            builder: (context) => ListView.separated(
                itemBuilder: ((context, index) => Dismissible(
                      background: swapdelete(),
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        cubit.deleteData(cubit.donelist[index]["id"]);
                      },
                      child: builditems(
                        iconbtnmissin2: Icons.delete,
                        colorbtnmissin2: Colors.red[600],
                        btnmissin2: () {
                          cubit.deleteData(cubit.donelist[index]["id"]);
                        },
                        //id: doneshort[index]["id"],
                        //stutus: "DONE",
                        //stutusarcive: "ARCIVE",
                        context: context,
                        //testst: doneshort[index]["status"],
                        textTime: doneshort[index]["time"],
                        textDate: doneshort[index]["date"],
                        textTitle: doneshort[index]["title"],
                      ),
                    )),
                separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1,
                    ),
                itemCount: cubit.donelist.length),
          );
        });
  }
}
