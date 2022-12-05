import 'package:atividade_2/bloc/auth/auth_bloc.dart';
import 'package:atividade_2/bloc/auth/auth_event.dart';
import 'package:atividade_2/bloc/auth/auth_state.dart';
import 'package:atividade_2/bloc/stock/user_stock_bloc.dart';
import 'package:atividade_2/bloc/view/view_bloc.dart';
import 'package:atividade_2/bloc/view/view_events.dart';
import 'package:atividade_2/models/Chart.dart';
import 'package:atividade_2/models/Forms.dart';
import 'package:atividade_2/models/ProfilePage.dart';
import 'package:atividade_2/models/StockList.dart';
import 'package:atividade_2/models/UserStockList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WrapperState();
  }
}

class WrapperState extends State<Wrapper> {
  final List<Tab> myTabs = <Tab>[
    const Tab(
        icon: Icon(Icons.login
            //TODO: Change icons after login and profile implementation
            )),
    const Tab(icon: Icon(Icons.list_alt_rounded)),
    const Tab(icon: Icon(Icons.graphic_eq)),
    const Tab(icon: Icon(Icons.people)),
  ];

  @override
  Widget build(BuildContext context) {
    UserLoginBloc userLoginBloc = BlocProvider.of<UserLoginBloc>(context);
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    ViewBloc viewBloc = BlocProvider.of<ViewBloc>(context);

    //TODO: Remenber to insert a field named 'currentSessionToken' at the SQFLite database.
    authBloc.add(LoadUser(token: getLoggedUserAuthToken()));

    return BlocBuilder<AuthBloc, AuthState>(
      builder: ((context, state) => DefaultTabController(
            length: myTabs.length,
            child: Conditional.single(
              context: context,
              conditionBuilder: (context) {
                if (state.token.isNotEmpty) {
                  return state.token.isNotEmpty;
                } else {
                  viewBloc.add(ChangeView(view: 'login'));
                  return state.token.isNotEmpty;
                }
              },
              widgetBuilder: (context) => Scaffold(
                appBar: AppBar(
                  title: const Center(child: Text('Invest')),
                  bottom: TabBar(
                    tabs: myTabs,
                  ),
                  backgroundColor: Colors.black,
                ),
                body: const TabBarView(
                  children: <Widget>[ProfilePage(), StockList(), Chart(), UserStockList()],
                ),
              ),
              fallbackBuilder: (context) => Scaffold(
                appBar: AppBar(
                  title: const Center(child: Text('Invest')),
                  backgroundColor: Colors.black,
                ),
                body: const Forms(),
              ),
            ),
          )),
    );
  }
}

//TODO: Implement a query to get the logged user token
String getLoggedUserAuthToken() {
  //return 'Not Authenticated';
  return 'TOKEN';
}
