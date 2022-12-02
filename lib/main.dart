import 'package:atividade_2/models/Chart.dart';
import 'package:atividade_2/models/Forms.dart';
import 'package:atividade_2/models/StockList.dart';
import 'package:flutter/material.dart';

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
    final List<Tab> myTabs = <Tab>[
      const Tab(
          icon: Icon(Icons.login
              //TO-DO: Change icons after login and profile implementation
              )),
      const Tab(icon: Icon(Icons.list_alt_rounded)),
      const Tab(icon: Icon(Icons.graphic_eq)),
    ];
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Invest')),
          bottom: TabBar(
            tabs: myTabs,
          ),
          backgroundColor: Colors.black,
        ),
        body: const TabBarView(
          children: <Widget>[Forms(), StockList(), Chart()],
        ),
      ),
    );
  }
}
