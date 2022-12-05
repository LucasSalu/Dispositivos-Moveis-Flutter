import 'package:atividade_2/utils/stock.dart';

abstract class UserLoginEvent {}

class UserLogin extends UserLoginEvent {
  final String name;
  final String email;

  UserLogin({required this.name, required this.email});
}
