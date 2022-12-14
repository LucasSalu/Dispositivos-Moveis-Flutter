import 'package:atividade_2/models/UserStockList.dart';
import 'package:atividade_2/services/ServiceStock.dart';
import 'package:atividade_2/bloc/stock/stock_bloc.dart';
import 'package:atividade_2/bloc/stock/stock_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  ServiceStock serviceStock = ServiceStock();

  @override
  @override
  Widget build(BuildContext context) {
    StockBloc stockBloc = BlocProvider.of<StockBloc>(context);
    UserStockList stockList = UserStockList();
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
                      child: const Text("Vizualizar"),
                      value: 1,
                      onTap: () {
                        stockBloc.add(ChangeChart(changeChart: lista[index]));
                        DefaultTabController.of(this.context)!.animateTo(2);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Essa funcionalidade ir?? comparar duas criptomoedas no futuro")));
                      },
                    ),
                    PopupMenuItem(
                      child: ElevatedButton(
                        child: const Text('Adicionar'),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200,
                                color: Colors.blue.shade200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ElevatedButton(
                                        child: Text("${lista[index].name.toString()} : ${lista[index].price.toString()}"),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      Padding(padding: EdgeInsets.all(10)),
                                      ElevatedButton(
                                        child: Text(' + 1 '),
                                        onPressed: () => {
                                          lista[index].price += 1
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      value: 2,
                      onTap: () {
                        stockBloc.add(ChangeChart(changeChart: lista[index]));
                        DefaultTabController.of(this.context)!.animateTo(2);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Essa funcionalidade ir?? mostrar o gr??fico somente da criptomoeda selecionada")));
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
