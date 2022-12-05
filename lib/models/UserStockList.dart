import 'package:atividade_2/bloc/stock/stock_bloc.dart';
import 'package:atividade_2/bloc/stock/stock_event.dart';
import 'package:atividade_2/utils/stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/ServiceUserStock.dart';

class UserStockList extends StatefulWidget {
  const UserStockList({Key? key}) : super(key: key);

  @override
  UserStockListState createState() {
    return UserStockListState();
  }
}

class UserStockListState extends State<UserStockList> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  ServiceUserStock serviceUserStock = ServiceUserStock();
  List<Stock> lista = ServiceUserStock.getAll();

  @override
  Widget build(BuildContext context) {
    StockBloc stockBloc = BlocProvider.of<StockBloc>(context);
    return ListView.builder(
        itemCount: lista.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                backgroundImage: const NetworkImage('images/Grafico.png'),
                radius: 25.0),
            title: Text(lista[index].name),
            subtitle: Text(lista[index].price.toString()),
            tileColor: Colors.grey[300],
            trailing: IconButton(
              icon: PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: const Text("remover"),
                      value: 1,
                      onTap: () {
                        stockBloc.add(ChangeChart(changeChart: lista[index]));
                        DefaultTabController.of(this.context)!.animateTo(2);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Essa funcionalidade irá comparar duas criptomoedas no futuro")));
                      },
                    ),
                    PopupMenuItem(
                      child: const Text("Mostrar Grafico"),
                      value: 2,
                      onTap: () {
                        stockBloc.add(ChangeChart(changeChart: lista[index]));
                        serviceUserStock.addStock(lista[index]);
                        DefaultTabController.of(this.context)!.animateTo(2);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Essa funcionalidade irá mostrar o gráfico somente da criptomoeda selecionada")));
                      },
                    ),
                  ];
                },
              ),
              onPressed: () {
              },
            ),
          );
        });
    ;
  }
}
