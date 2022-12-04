class Stock {

  String _name;
  DateTime _date;
  double _price;
  String _simbol;


  Stock(this._name, this._date, this._price,this._simbol){}


  set name(String name) {
    _name = name;
  }
  set date(DateTime date) {
    _date = date;
  }
  set price(double price) {
    _price = price;
  }
  set_simbol(double_simbol) {
    _simbol = simbol;
  }

  DateTime get date => _date;
  String get name => _name;
  double get price => _price;
  String get simbol => _simbol;

  List total = [];


  String toString(){
    return 'name: $name\n date: $date\n price: $price\n $simbol\n';

  }
}