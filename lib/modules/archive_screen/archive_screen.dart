import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp_todo/shared/cubit/states.dart';

import '../../components/components.dart';
import '../../shared/cubit/cubit.dart';

class arcivescreen extends StatelessWidget {
  const arcivescreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          var arciveshort = AppCubit.get(context).arcivelist;
          return ConditionalBuilder(
              condition: arciveshort.length > 0,
              fallback: (context) => Center(
                    child: Text(
                      " الارشيف فارغ",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
              builder: (context) => ListView.separated(
                  itemBuilder: ((context, index) => Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          cubit.deleteData(cubit.arcivelist[index]["id"]);
                        },
                        child: builditems(
                          btnmissin: () {
                            AppCubit.get(context)
                                .updateData('NEW', arciveshort[index]["id"]);
                          },
                          btnmissin2: () {
                            cubit.deleteData(cubit.arcivelist[index]["id"]);
                          },
                          iconbtnmissin: Icons.menu,
                          iconbtnmissin2: Icons.delete,
                          colorbtnmissin: Colors.grey[600],
                          colorbtnmissin2: Colors.red,
                          context: context,
                          textTime: cubit.arcivelist[index]["time"],
                          textDate: cubit.arcivelist[index]["date"],
                          textTitle: cubit.arcivelist[index]["title"],
                        ),
                        background: swapdelete(),
                      )),
                  separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 1,
                      ),
                  itemCount: cubit.arcivelist.length));
        });
  }
}
