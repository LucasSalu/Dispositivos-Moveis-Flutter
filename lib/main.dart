import 'package:atividade_2/bloc/stock/stock_state.dart';
import 'package:atividade_2/bloc/stock/user_stock_bloc.dart';
import 'package:atividade_2/bloc/stock/user_stock_event.dart';
import 'package:atividade_2/bloc/stock/user_stock_state.dart';
import 'package:atividade_2/models/Wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/auth/auth_state.dart';
import 'bloc/stock/stock_bloc.dart';
import 'bloc/view/view_bloc.dart';
import 'bloc/view/view_state.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Investment App';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AuthBloc(AuthState())),
      BlocProvider(create: (context) => ViewBloc(ViewState())),
      BlocProvider(create: (context) => StockBloc(StockState())),
      BlocProvider(create: (context) => UserLoginBloc(UserLoginState())),
    ], child: const Wrapper());
  }
}
