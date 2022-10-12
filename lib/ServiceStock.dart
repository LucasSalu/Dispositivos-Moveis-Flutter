import 'package:atividade_2/utils/stock.dart';

class ServiceStock{

  static List<Stock> getAll(){
    var total = <Stock>[];
    total.add(Stock("Bitcoin", DateTime.now(),200.0));
    total.add(Stock("USD", DateTime.now(),200.0));
    total.add(Stock("USDT", DateTime.now(),200.0));
    total.add(Stock("Ethereum", DateTime.now(),200.0));
    total.add(Stock("Bitcoin", DateTime.now(),200.0));
    total.add(Stock("USD", DateTime.now(),200.0));
    total.add(Stock("USDT", DateTime.now(),200.0));
    total.add(Stock("Ethereum", DateTime.now(),200.0));
    total.add(Stock("Bitcoin", DateTime.now(),200.0));
    total.add(Stock("USD", DateTime.now(),200.0));
    total.add(Stock("USDT", DateTime.now(),200.0));
    total.add(Stock("Ethereum", DateTime.now(),200.0));
    total.add(Stock("Bitcoin", DateTime.now(),200.0));
    total.add(Stock("USD", DateTime.now(),200.0));
    total.add(Stock("USDT", DateTime.now(),200.0));
    total.add(Stock("Ethereum", DateTime.now(),200.0));
    return total;
  }
}