class Stock {

  String _name;
  DateTime _date;
  double _price;

  Stock(this._name, this._date, this._price){}

  set name(String name) {
    _name = name;
  }
  set date(DateTime date) {
    _date = date;
  }
  set price(double price) {
    _price = price;
  }

  DateTime get date => _date;
  String get name => _name;
  double get price => _price;

  List total = [];


  String toString(){
    return 'name: $name\n date: $date\n price: $price\n';

  }
}