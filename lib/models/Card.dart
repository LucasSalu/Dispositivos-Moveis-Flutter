import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetsStateful extends StatefulWidget {
  String name;
  String profission;
  String description;
  String image;
  Color color;
  Color colorShade;

  WidgetsStateful(this.name, this.profission, this.description,  this.image, this.color, this.colorShade);

  @override
  State<StatefulWidget> createState() {
    return WidgetsStatefulState(this.name, this.profission, this.description, this.image, this.color, this.colorShade);
  }
}

class WidgetsStatefulState extends State<StatefulWidget> {
  bool checkBoxValue = false;
  bool switchValue = false;
  double sliderValue = 10;
  int radioValue = 1;

  String name;
  String profission;
  String description;
  String image;
  Color color;
  Color colorShade;

  WidgetsStatefulState(this.name, this.profission, this.description, this.image, this.color, this.colorShade);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(image),
                radius: 45.0,
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico'),
              ),
              Text(
                profission,
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    color: colorShade,
                    fontSize: 20.0,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 250,
                height: 20,
                child: Divider(
                  color: colorShade,
                ),
              ),
              Column(
                children: [
                  Card(
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      title: Text(
                        '+55 19 99352-0172',
                        style: TextStyle(
                          color: color,
                          fontFamily: 'Source Sans Pro',
                        ),
                      ),
                      leading: Icon(
                        Icons.phone,
                        size: 25.0,
                        color: color,
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      title: Text(
                        description,
                        style: TextStyle(
                          color: color,
                          fontFamily: 'Source Sans Pro',
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
