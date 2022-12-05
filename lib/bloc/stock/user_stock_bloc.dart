import 'package:atividade_2/bloc/stock/stock_event.dart';
import 'package:atividade_2/bloc/stock/user_stock_event.dart';
import 'package:atividade_2/bloc/stock/user_stock_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLoginBloc extends Bloc<UserLoginEvent,UserLoginState>{
  UserLoginBloc(UserLoginState initialState) : super(initialState){
    on<UserLogin>((event, emit){
      emit(UserLoginState(name: event.name,email: event.email));
    });
  }

}