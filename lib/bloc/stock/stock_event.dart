import 'package:atividade_2/utils/stock.dart';

abstract class StockEvent {}

class ChangeChart extends StockEvent {
  final Stock changeChart;

  ChangeChart({required this.changeChart});
}
