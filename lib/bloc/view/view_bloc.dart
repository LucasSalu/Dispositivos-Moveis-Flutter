import 'package:flutter_bloc/flutter_bloc.dart';

import 'view_events.dart';
import 'view_state.dart';

class ViewBloc extends Bloc<ViewEvent, ViewState> {
  ViewBloc(ViewState initialState) : super(initialState) {
    on<ChangeView>((event, emit) {
      emit(ViewState(view: event.view));
    });
    on<LogoutUserView>((event, emit) {
      emit(ViewState(view: 'login'));
    });
  }
}
