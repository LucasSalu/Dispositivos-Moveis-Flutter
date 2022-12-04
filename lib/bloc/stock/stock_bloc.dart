import 'package:atividade_2/bloc/stock/stock_event.dart';
import 'package:atividade_2/bloc/stock/stock_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockBloc extends Bloc<StockEvent,StockState>{
  StockBloc(StockState initialState) : super(initialState){
    on<ChangeChart>((event, emit){
      emit(StockState(stock: event.changeChart));
    });
  }

}