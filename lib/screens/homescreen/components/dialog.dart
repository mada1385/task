import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/config/const.dart';
import 'package:task/provider/provider.dart';
import 'package:task/screens/homescreen/components/colorselect.dart';
import 'package:task/screens/homescreen/components/customdialog.dart';
import 'package:task/screens/homescreen/components/hoursselect.dart';
import 'package:task/screens/homescreen/homescreen.dart';

class Addschaduledialog extends StatelessWidget {
  Addschaduledialog({
    Key key,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: Provider.of<Userprovider>(context, listen: false)
            .selectedDatedialog,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null &&
        picked !=
            Provider.of<Userprovider>(context, listen: false)
                .selectedDatedialog)
      Provider.of<Userprovider>(context, listen: false)
          .setselectedDatedialog(picked);
    Provider.of<Userprovider>(context, listen: false).getavailablehours();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialogBox(
      text: "Add",
      title: "let's start studying",
      content: Expanded(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Constants.maincolor, width: 2),
                    borderRadius: BorderRadius.circular(Constants.padding),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: TextField(
                      controller: Provider.of<Userprovider>(context).tittle,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        hintText: "add tittle",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Constants.maincolor, width: 2),
                        borderRadius: BorderRadius.circular(Constants.padding),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 5),
                        child: Text(Provider.of<Userprovider>(context).date ??
                            "add date"),
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
                Provider.of<Userprovider>(context).date == null
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("From"),
                          Hourdropdownmenu(),
                          Text("TO"),
                          TOHourdropdownmenu(),
                        ],
                      ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Constants.maincolor, width: 2),
                    borderRadius: BorderRadius.circular(Constants.padding),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: TextField(
                      controller: Provider.of<Userprovider>(context).task,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          hintText: "add task"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text("Color"),
                    SizedBox(
                      width: 20,
                    ),
                    Colordropdowmenu(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  Provider.of<Userprovider>(context).errormassage,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
      img: Image.asset("assets/3f7d8dedfca501015a14b977312b3df0.gif"),
    );
  }
}
