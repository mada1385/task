import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task/config/mediaqueryconfig.dart';
import 'package:task/provider/provider.dart';
import 'package:task/config/const.dart';
import 'package:task/screens/homescreen/components/dialog.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  DateTime startDate = DateTime.now().subtract(Duration(days: 1000));
  DateTime endDate = DateTime.now().add(Duration(days: 1000));
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  onSelect(data) {
    HapticFeedback.lightImpact();
    setState(() {
      Provider.of<Userprovider>(context, listen: false).setdate(data);
    });
  }

  onWeekSelect(data) {
    HapticFeedback.mediumImpact();

    print("Selected week starting at -> $data");
  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(""),
    );
  }

  dateTileBuilder(
    date,
    selectedDate,
    rowIndex,
    dayName,
    isDateMarked,
    isDateOutOfRange,
  ) {
    List months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];

    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.white;
    TextStyle normalStyle =
        TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white);
    TextStyle dayNameStyle =
        TextStyle(fontSize: SizeConfig.blockSizeVertical * 2, color: fontColor);
    List<Widget> _children = [
      Text(months[date.month - 1], style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
      Text(dayName, style: dayNameStyle),
    ];

    if (isDateMarked == true) {
      // _children.add(getMarkedIndicatorWidget());
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      alignment: Alignment.center,
      // padding: EdgeInsets.only(
      //     top: SizeConfig.blockSizeVertical * 1,
      //     left: SizeConfig.blockSizeHorizontal * .5,
      //     right: SizeConfig.blockSizeHorizontal * .5,
      //     bottom: SizeConfig.blockSizeVertical * .5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Color(0xffFB805B),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, child: Addschaduledialog());
          },
          backgroundColor: Constants.maincolor,
          child: Icon(Icons.add),
        ),
        backgroundColor: Constants.maincolor,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Daily Studies",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Container(
                  decoration: BoxDecoration(color: Constants.maincolor),
                  height: 100,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: CalendarStrip(
                      startDate: startDate,
                      endDate: endDate,
                      selectedDate:
                          Provider.of<Userprovider>(context).selectedDate,
                      onDateSelected: onSelect,
                      onWeekSelected: onWeekSelect,
                      dateTileBuilder: dateTileBuilder,
                      iconColor: Colors.white,
                      monthNameWidget: _monthNameWidget,
                      // markedDates: markedDates,
                      containerDecoration:
                          BoxDecoration(color: Constants.maincolor),
                      addSwipeGesture: true,
                    ),
                  )),
              Expanded(
                  child: Container(
                color: Colors.white,
                child: ListView.builder(
                    itemCount: Provider.of<Userprovider>(context)
                        .getlistofschadules()
                        .length,
                    itemBuilder: (context, index) => Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Provider.of<Userprovider>(context)
                                        .getlistofschadules()[index]
                                        .from
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Container(
                                      height: 2,
                                      width: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Container(
                                      height: 2,
                                      width: 30,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Container(
                                      height: 2,
                                      width: 40,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Container(
                                      height: 2,
                                      width: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    Provider.of<Userprovider>(context)
                                        .getlistofschadules()[index]
                                        .to
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  color: Provider.of<Userprovider>(context)
                                      .getlistofschadules()[index]
                                      .color,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              Provider.of<Userprovider>(context)
                                                  .getlistofschadules()[index]
                                                  .tittle1
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            Text(
                                              Provider.of<Userprovider>(context)
                                                  .getlistofschadules()[index]
                                                  .tittle2
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
              ))
            ],
          ),
        ));
  }
}
