import 'package:atividade_2/models/LoginPage.dart';
import 'package:atividade_2/models/ProfilePage.dart';
import 'package:atividade_2/models/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class Forms extends StatefulWidget {
  const Forms({Key? key}) : super(key: key);

  @override
  FormsState createState() {
    return FormsState();
  }
}

class FormsState extends State<Forms> {
  final String pageViewState = 'profile'; //Transform this into a state

  @override
  Widget build(BuildContext context) {
    return ConditionalSwitch.single(
      context: context,
      valueBuilder: (BuildContext context) {
        return pageViewState;
      },
      caseBuilders: {
        'login': (BuildContext context) => const LoginPage(),
        'register': (BuildContext context) => const SignupPage(),
        'profile': (BuildContext context) => const ProfilePage(),
      },
      fallbackBuilder: (BuildContext context) => const LoginPage(),
    );
  }
}
