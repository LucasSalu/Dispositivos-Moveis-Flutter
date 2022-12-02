import 'package:atividade_2/utils/stock.dart';
import 'package:dio/dio.dart';

class ServiceStock{

  final dio = Dio();

  static List<Stock> getAll(){
    var total = <Stock>[];
    total.add(Stock("Bitcoin", DateTime.now(),200.0,"BTC"));
    // total.add(Stock("Ethereum", DateTime.now(),200.0,"ETH"));
    // total.add(Stock("Ethereum", DateTime.now(),200.0,"Ethereum"));
    // total.add(Stock("Bitcoin", DateTime.now(),200.0,"BTC"));
    // total.add(Stock("USD", DateTime.now(),200.0,"USD"));
    // total.add(Stock("USDT", DateTime.now(),200.0,"USDT"));
    // total.add(Stock("Ethereum", DateTime.now(),200.0,"Ethereum"));
    // total.add(Stock("Bitcoin", DateTime.now(),200.0,"BTC"));
    // total.add(Stock("USD", DateTime.now(),200.0,"USD"));
    // total.add(Stock("USDT", DateTime.now(),200.0,"USDT"));
    // total.add(Stock("Ethereum", DateTime.now(),200.0,"Ethereum"));
    return total;
  }
  getCripto() async {
      for(var i in getAll()) {
        Response response = await dio.get(
            "https://www.alphavantage.co/query?function=DIGITAL_CURRENCY_DAILY&symbol=${i.simbol}&market=CNY&apikey=6V17MI1D59PR1S30");
            print(response.data["Meta Data"]);
      }
  }
}