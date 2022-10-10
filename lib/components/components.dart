import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget defulttextformfild({
  VoidCallback? ontab,
  Function(String)? onchanged,
  required TextEditingController controllerad,
  required String labeltext,
  required Icon prifixicon,
  required TextInputType type,
  required valid,
}) =>
    TextFormField(
      controller: controllerad,
      onChanged: onchanged,
      onTap: ontab,
      validator: valid,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: labeltext,
        icon: prifixicon,
      ),
    );
Widget builditems(
        {required String textTime,
        required String textTitle,
        required String textDate,
        required context,
        Function()? btnmissin,
        Function()? btnmissin2,
        IconData? iconbtnmissin,
        IconData? iconbtnmissin2,
        Color? colorbtnmissin,
        Color? colorbtnmissin2}) =>
    Container(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            child: Text(textTime),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  textTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  textDate,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: btnmissin,
            /*() {
              AppCubit.get(context).updateData(stutusarcive, id);
            },*/
            icon: Icon(
              iconbtnmissin,
              color: colorbtnmissin,
            ),
          ),
          IconButton(
            onPressed: btnmissin2,
            /*() {
              
            },*/
            icon: Icon(
              iconbtnmissin2,
              color: colorbtnmissin2,
            ),
          )
        ],
      ),
    );
Widget bottomsheet(
        {required TextEditingController btnsheetcontrollertitle,
        required TextEditingController btnsheetcontrollertime,
        required TextEditingController btnsheetcontrollerdate,
        required BuildContext contextxx,
        required Function() additem}) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          color: Colors.grey[100],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              defulttextformfild(
                type: TextInputType.text,
                labeltext: "عنوان المهمة",
                prifixicon: Icon(Icons.title),
                valid: (value) {
                  if (value!.isEmpty) {
                    return "لا يمكنك ترك العنوان فارغاً";
                  }
                  return null;
                },
                controllerad: btnsheetcontrollertitle,
              ),
              defulttextformfild(
                type: TextInputType.datetime,
                labeltext: "وقت المهمة",
                prifixicon: Icon(Icons.watch_later_outlined),
                ontab: () {
                  showTimePicker(
                    initialEntryMode: TimePickerEntryMode.input,
                    helpText: "المساعده",
                    errorInvalidText: "حدث خطاً في اختيارا لوقت",
                    cancelText: "الغاء",
                    minuteLabelText: "الدقائق",
                    hourLabelText: "الساعات",
                    confirmText: "تأكيد",
                    context: contextxx,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    btnsheetcontrollertime.text =
                        value!.format(contextxx).toString();
                  });
                },
                valid: (value) {
                  if (value!.isEmpty) {
                    return "لا يمكنك ترك الوقت فارغاً";
                  }
                  return null;
                },
                controllerad: btnsheetcontrollertime,
              ),
              defulttextformfild(
                ontab: () {
                  showDatePicker(
                          locale: Locale('ar', 'AE'),
                          context: contextxx,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse('2030-10-10'))
                      .then((value) {
                    btnsheetcontrollerdate.text =
                        DateFormat.yMMMd().format(value!);
                  });
                },
                type: TextInputType.datetime,
                labeltext: "تاريخ المهمة",
                prifixicon: Icon(Icons.date_range_outlined),
                valid: (value) {
                  if (value!.isEmpty) {
                    return "لا يمكنك ترك التاريخ فارغاً";
                  }
                  return null;
                },
                controllerad: btnsheetcontrollerdate,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: additem,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("اضافة"),
                  ))
            ],
          ),
        ),
      ],
    );
Widget swapdelete() {
  return Container(
      color: Colors.grey,
      child: Row(
        children: <Widget>[
          Icon(
            Icons.delete,
            size: 35,
          )
        ],
      ));
}
