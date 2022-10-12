import 'package:atividade_2/models/Card.dart';
import 'package:atividade_2/models/Forms.dart';
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
      const Tab(icon: Icon(Icons.emoji_people_sharp)),
      const Tab(icon: Icon(Icons.emoji_people_sharp)),
      const Tab(icon: Icon(Icons.emoji_people_sharp)),
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
          children: <Widget>[
            SignupPage(),
            WidgetsStateful(
                "Renan Douglas- 243782",
                "Software Developer",
                "Lucas é um estudante de Análise e Desenvolvimento de Sistemas que atualmente está trabalhando na Letrus. Adora jogar Magic, e não vive sem seu Pc Gamer",
                "images/Renan.jpeg",
                Colors.green,
                Colors.green.shade100),
            WidgetsStateful(
                "Lucas Samuel - 240147",
                "Software Developer",
                'Lucas é um estudante de Análise e Desenvolvimento de Sistemas que atualmente está trabalhando na Padtec . Tem muita familiaridade com tecnologias como JavaScript',
                "images/Lucas.jpeg",
                Colors.blue,
                Colors.blue.shade100),
          ],
        ),
      ),
    );
  }
}
