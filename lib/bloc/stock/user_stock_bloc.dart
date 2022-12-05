import 'package:atividade_2/bloc/stock/stock_event.dart';
import 'package:atividade_2/bloc/stock/user_stock_event.dart';
import 'package:atividade_2/bloc/stock/user_stock_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserStockBloc extends Bloc<UserStockEvent,UserStockState>{
  UserStockBloc(UserStockState initialState) : super(initialState){
    on<UserChangeChart>((event, emit){
      emit(UserStockState(stock: event.changeChart));
    });
  }

}