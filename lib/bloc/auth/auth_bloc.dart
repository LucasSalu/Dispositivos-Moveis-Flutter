import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthState initialState) : super(initialState) {
    on<LoadUser>((event, emit) {
      emit(AuthState(token: authenticate(event.token)));
    });
    on<LoginUser>((event, emit) {
      AuthClass authenticationState = loginUser(event.email, event.password);
      emit(AuthState(
          token: authenticationState.token,
          isAuthenticated: authenticationState.isAuthenticated));
    });
    on<RegisterUser>((event, emit) {
      AuthClass authenticationState = registerUser(
          event.email, event.password, event.name, event.hasAcceptedTerms);
      emit(AuthState(
          token: authenticationState.token,
          isAuthenticated: authenticationState.isAuthenticated));
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

String generateToken() {
  return 'FAILED';
}

AuthClass loginUser(String email, String password) {
  if (email == 'email' && password == '1234') {
    //TODO: Find Token Where Email and Password Match at DB
    AuthClass authenticationState = AuthClass('TOKEN', true);
    return authenticationState;
  } else {
    return AuthClass('', false);
  }
}

AuthClass registerUser(String email, String password, String name, bool terms) {
  //TODO: Generate token and add user to DB.
  if (generateToken() == 'TOKEN') {
    return AuthClass('TOKEN', true);
  }
  return AuthClass('', false);
}

class AuthClass {
  String token = '';
  bool isAuthenticated = false;

  AuthClass(this.token, this.isAuthenticated);
}
