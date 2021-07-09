import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/config/mediaqueryconfig.dart';
import 'package:task/provider/provider.dart';

class Colordropdowmenu extends StatelessWidget {
  List colors = [
    Colors.red,
    Colors.pink,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.white,
    Colors.purple,
    Colors.purpleAccent,
    Colors.lightBlue,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DropdownButton(
        icon: Icon(
          Icons.ac_unit,
          size: 0,
        ),
        items: colors
            .map((e) => DropdownMenuItem(
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 54,
                    height: 50,
                    color: e,
                  ),
                  value: e,
                ))
            .toList(),
        value: Provider.of<Userprovider>(context, listen: false).colorvalue,
        onChanged: (value) {
          Provider.of<Userprovider>(context, listen: false)
              .setcolorvalue(value);
        });
  }
}
