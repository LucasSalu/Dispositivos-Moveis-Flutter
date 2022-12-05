import 'package:atividade_2/utils/stock.dart';

abstract class UserStockEvent {}

class UserChangeChart extends UserStockEvent {
  final Stock changeChart;

  UserChangeChart({required this.changeChart});
}
