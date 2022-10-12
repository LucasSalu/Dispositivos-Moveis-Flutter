import 'package:atividade_2/models/Card.dart';
import 'package:atividade_2/models/Chart.dart';
import 'package:atividade_2/models/Forms.dart';
import 'package:atividade_2/models/StockList.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

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
      Tab(icon: Icon(Icons.login)),
      Tab(icon: Icon(Icons.list_alt_rounded)),
      Tab(icon: Icon(Icons.graphic_eq)),
    ];
    return DefaultTabController(
      initialIndex: 2,
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Invest')),
          bottom: TabBar(
            tabs: myTabs,
          ),
          backgroundColor: Colors.black,
        ),
        body: TabBarView(
          children: <Widget>[SignupPage(), StockList(), Chart()],
        ),
      ),
    );
  }
}
