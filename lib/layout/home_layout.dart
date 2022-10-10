import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp_todo/shared/cubit/cubit.dart';

import '../components/components.dart';

import '../shared/cubit/states.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {
  /* LIST PAGE APP */

  /* LIST title PAGE APP */
  bool isbottomsheetshown = false;

  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((BuildContext context) => AppCubit()..readDataview()),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {},
          builder: (BuildContext context, AppStates state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              key: scaffoldkey,
              floatingActionButton: FloatingActionButton(
                backgroundColor: AppCubit.get(context).colofloating,
                child: Icon(cubit.fabicon),
                onPressed: () async {
                  if (isbottomsheetshown) {
                    titlecontroller.clear();
                    timecontroller.clear();
                    datecontroller.clear();
                    Navigator.pop(context);
                  } else {
                    scaffoldkey.currentState!
                        .showBottomSheet(
                          (context) => Form(
                            key: formKey,
                            child: bottomsheet(
                              contextxx: context,
                              btnsheetcontrollertitle: titlecontroller,
                              btnsheetcontrollertime: timecontroller,
                              btnsheetcontrollerdate: datecontroller,
                              additem: () async {
                                if (formKey.currentState!.validate()) {
                                  await cubit.insertData(
                                      "${titlecontroller.text}",
                                      timecontroller.text,
                                      datecontroller.text);
                                  Navigator.pop(context);

                                  cubit.changeBottomSHeetState(
                                    Colorreq: Colors.indigo,
                                    show: false,
                                    icon: Icons.close,
                                  );
                                  titlecontroller.clear();
                                  timecontroller.clear();
                                  datecontroller.clear();
                                }
                              },
                            ),
                          ),
                        )
                        .closed
                        .then((value) {
                      isbottomsheetshown = false;
                      cubit.changeBottomSHeetState(
                          Colorreq: Colors.indigo,
                          show: false,
                          icon: Icons.edit);
                    });
                    isbottomsheetshown = true;
                    cubit.changeBottomSHeetState(
                      show: true,
                      icon: Icons.close,
                      Colorreq: Colors.red,
                    );
                  }
                },
              ),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text("إدارة المهام "),
              ),
              body: cubit.screens[cubit.btnnavbar],
              bottomNavigationBar: BottomNavigationBar(
                  showSelectedLabels: true,
                  currentIndex: cubit.btnnavbar,
                  onTap: (index) {
                    cubit.ChangeIndex(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: "${cubit.titls[0]}",
                      icon: Icon(
                        Icons.menu,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "${cubit.titls[1]}",
                      icon: Icon(
                        Icons.check_circle_outline,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "${cubit.titls[2]}".toUpperCase(),
                      icon: Icon(
                        Icons.archive_outlined,
                      ),
                    ),
                  ]),
            );
          }),
    );
  }
}
