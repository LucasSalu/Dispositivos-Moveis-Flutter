import 'package:atividade_2/bloc/stock/stock_bloc.dart';
import 'package:atividade_2/services/ServiceStock.dart';
import 'package:atividade_2/utils/stock.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  ChartState createState() {
    return ChartState();
  }
}

class ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    StockBloc stockBloc = BlocProvider.of<StockBloc>(context);
    ServiceStock serviceStock = ServiceStock();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Grafico de comparação:',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Text('BITCOIN x ETHEREUM',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          color: Colors.red,
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          child: sample3(context),
        ),
        ElevatedButton(
          onPressed: () {
            serviceStock.getCripto();
            print(stockBloc.state.stock);
          },
          child: const Text('Enabled'),
        ),
      ],
    );
  }
}



Widget sample3(BuildContext context) {
  final fromDate = DateTime(2019, 05, 22);
  final toDate = DateTime.now();

  final date1 = DateTime.now().subtract(Duration(days: 1));
  final date2 = DateTime.now().subtract(Duration(days: 15));
  ServiceStock serviceStock = ServiceStock();
  StockBloc stockBloc = BlocProvider.of<StockBloc>(context);
  Stock? stock = stockBloc.state.stock == null? stockBloc.state.stock :Stock("Bitcoin", DateTime.now(), 200.0, "BTC");
  List<DataPoint<DateTime>> listPoints = serviceStock.dataPoints(stock!);

  return Center(
    child: Container(
      color: Colors.red,
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: BezierChart(
        fromDate: fromDate,
        bezierChartScale: BezierChartScale.WEEKLY,
        toDate: toDate,
        selectedDate: toDate,
        series: [
          BezierLine(
            label: "Duty",
            onMissingValue: (dateTime) {
              if (dateTime.day.isEven) {
                return 10.0;
              }
              return 5.0;
            },
            data: listPoints,
          ),
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 3.0,
          verticalIndicatorColor: Colors.black26,
          showVerticalIndicator: true,
          verticalIndicatorFixedPosition: false,
          backgroundColor: Colors.red,
          footerHeight: 30.0,
        ),
      ),
    ),
  );
}
