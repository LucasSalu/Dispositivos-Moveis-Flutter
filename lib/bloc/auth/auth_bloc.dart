import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthState initialState) : super(initialState) {
    on<LoadUser>((event, emit) {
      emit(AuthState(token: authenticate(event.token)));
    });
    on<LoginUser>((event, emit) {
      emit(AuthState(token: event.password));
    });
    on<RegisterUser>((event, emit) {
      emit(AuthState(token: 'TOKEN'));
    });
    on<LogoutUser>((event, emit) {
      emit(AuthState(token: clearToken(event.token)));
    });
  }
}

String authenticate(String token) {
  if (token == 'TOKEN') {
    //TODO: Get Token from DB
    return token;
  } else {
    //Not Authenticated
    return '';
  }
}

String clearToken(String token) {
  if (token.isNotEmpty) {
    //TODO: Clear Token from DB
    return '';
  } else {
    return token;
  }
}
