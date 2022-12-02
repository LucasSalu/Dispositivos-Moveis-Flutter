import 'package:atividade_2/models/LoginPage.dart';
import 'package:atividade_2/models/ProfilePage.dart';
import 'package:atividade_2/models/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import '../bloc/view/view_bloc.dart';

class Forms extends StatelessWidget {
  const Forms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final viewState = context.watch<ViewBloc>().state.view;
      return ConditionalSwitch.single(
        context: context,
        valueBuilder: (BuildContext context) {
          return viewState;
        },
        caseBuilders: {
          'login': (context) => const LoginPage(),
          'register': (context) => const SignupPage(),
        },
        fallbackBuilder: (context) => const LoginPage(),
      );
    });
  }
}
