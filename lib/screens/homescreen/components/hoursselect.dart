import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task/config/const.dart';
import 'package:task/provider/provider.dart';

class Hourdropdownmenu extends StatefulWidget {
  const Hourdropdownmenu({Key key}) : super(key: key);

  @override
  _HourdropdownmenuState createState() => _HourdropdownmenuState();
}

class _HourdropdownmenuState extends State<Hourdropdownmenu> {
  int value;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Userprovider>(context, listen: false).getavailablehours();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: ListView(
          children: Provider.of<Userprovider>(context)
              .hoursfrom
              .map((e) => GestureDetector(
                    onTap: () {
                      Provider.of<Userprovider>(context, listen: false)
                          .setfrom(e);
                      HapticFeedback.mediumImpact();
                    },
                    child: Container(
                      color: Provider.of<Userprovider>(context).from == e
                          ? Constants.maincolor
                          : Colors.white,
                      child: Center(
                        child: Text(
                          e.toString(),
                          style: TextStyle(
                            color: Provider.of<Userprovider>(context).from == e
                                ? Colors.white
                                : Constants.maincolor,
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList()),
    );
  }
}

class TOHourdropdownmenu extends StatefulWidget {
  const TOHourdropdownmenu({Key key}) : super(key: key);

  @override
  _TOHourdropdownmenuState createState() => _TOHourdropdownmenuState();
}

class _TOHourdropdownmenuState extends State<TOHourdropdownmenu> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Userprovider>(context, listen: false).getavailablehours();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: ListView(
          children: Provider.of<Userprovider>(context)
              .hoursto
              .map((e) => GestureDetector(
                    onTap: () {
                      Provider.of<Userprovider>(context, listen: false)
                          .setto(e);
                      HapticFeedback.mediumImpact();
                    },
                    child: Container(
                      color: Provider.of<Userprovider>(context).to == e
                          ? Constants.maincolor
                          : Colors.white,
                      child: Center(
                        child: Text(
                          e.toString(),
                          style: TextStyle(
                            color: Provider.of<Userprovider>(context).to == e
                                ? Colors.white
                                : Constants.maincolor,
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList()),
    );
  }
}
