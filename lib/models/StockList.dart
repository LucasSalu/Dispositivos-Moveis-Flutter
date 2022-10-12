import 'package:atividade_2/ServiceStock.dart';
import 'package:flutter/material.dart';

class StockList extends StatefulWidget {
  const StockList({Key? key}) : super(key: key);

  @override
  StockListState createState() {
    return StockListState();
  }
}

class StockListState extends State<StockList> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  List lista = ServiceStock.getAll();

  @override
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: lista.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                backgroundImage: NetworkImage('images/Grafico.png'),
                radius: 25.0),
            title: Text(lista[index].name),
            subtitle: Text(lista[index].price.toString()),
            tileColor: Colors.grey[300],
            trailing: IconButton(
              icon: PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("Editar"),
                      value: 1,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Você clicou em editar")));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Mostrar Grafico"),
                      value: 2,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Você clicou em Mostrar Grafico")));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Excluir"),
                      value: 3,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Você clicou em Excluir")));
                      },
                    ),
                  ];
                },
              ),
              onPressed: () {},
            ),
          );
        });
    ;
  }
}
