import 'dart:convert';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:intl/intl.dart';
import 'package:atividade_2/utils/stock.dart';
import 'package:dio/dio.dart';

class ServiceStock {
  final dio = Dio();

  static List<Stock> getAll() {
    var total = <Stock>[];
    total.add(Stock("Bitcoin", DateTime.now(), 200.0, "BTC"));
    total.add(Stock("Ethereum", DateTime.now(),200.0,"ETH"));
    total.add(Stock("Cardano", DateTime.now(),200.0,"ADA"));
    total.add(Stock("Litecoin", DateTime.now(),200.0,"LTC"));
    total.add(Stock("Ripple", DateTime.now(),200.0,"XRP"));
    // total.add(Stock("USDT", DateTime.now(),200.0,"USDT"));
    // total.add(Stock("Ethereum", DateTime.now(),200.0,"Ethereum"));
    // total.add(Stock("Bitcoin", DateTime.now(),200.0,"BTC"));
    // total.add(Stock("USD", DateTime.now(),200.0,"USD"));
    // total.add(Stock("USDT", DateTime.now(),200.0,"USDT"));
    // total.add(Stock("Ethereum", DateTime.now(),200.0,"Ethereum"));
    return total;
  }

  getCripto(Stock stock) async {
    DateFormat format = new DateFormat("yyyy-MM-dd");
    List<Stock> historyChart = [];
    for (var stock in getAll()) {
      final response = await dio.get("https://www.alphavantage.co/query?function=DIGITAL_CURRENCY_DAILY&symbol=${stock.simbol}&market=CNY&apikey=6V17MI1D59PR1S30");
      final Map map = Map.from(response.data["Time Series (Digital Currency Daily)"]);

      map.forEach((key, value) {
        final Map mapDate = Map.from(
            response.data["Time Series (Digital Currency Daily)"][key]);
        var verifica = true;
        mapDate.forEach((key1, value1) {
          if (verifica) {
            historyChart.add(Stock(
                stock.name,
                format.parse(key),
                double.parse(
                    response.data["Time Series (Digital Currency Daily)"][key]
                        ["4b. close (USD)"]),
                stock.simbol));
          }
          verifica = false;
        });
      });
    }
  }

  Future<List<Stock>> getHistory(Stock currencyStock) async {
    DateFormat format = new DateFormat("yyyy-MM-dd");
    List<Stock> historyChart = [];

    print(
        "https://www.alphavantage.co/query?function=DIGITAL_CURRENCY_DAILY&symbol=${currencyStock.simbol}&market=CNY&apikey=6V17MI1D59PR1S30");
    final response = await dio.get(
        "https://www.alphavantage.co/query?function=DIGITAL_CURRENCY_DAILY&symbol=${currencyStock.simbol}&market=CNY&apikey=6V17MI1D59PR1S30");
    final Map map =
        Map.from(response.data["Time Series (Digital Currency Daily)"]);

    map.forEach((key, value) {
      final Map mapDate =
          Map.from(response.data["Time Series (Digital Currency Daily)"][key]);
      var verifica = true;
      mapDate.forEach((key1, value1) {
        if (verifica) {
          historyChart.add(Stock(
              currencyStock.name,
              format.parse(key),
              double.parse(response.data["Time Series (Digital Currency Daily)"]
                  [key]["4b. close (USD)"]),
              currencyStock.simbol));
        }
        verifica = false;
      });
    });
    return historyChart;
  }

  Future<List<DataPoint<DateTime>>> dataPoints(Stock stock) async {
    List<Stock> listStock = await this.getHistory(stock);
    List<DataPoint<DateTime>> list = [];
    for (var i in listStock) {
      list.add(DataPoint<DateTime>(value: i.price, xAxis: i.date));
    }

    return list;
  }
}
