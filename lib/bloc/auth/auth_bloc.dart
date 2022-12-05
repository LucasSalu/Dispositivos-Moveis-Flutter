import 'dart:math';

import 'package:atividade_2/repositories/session_data_repository.dart';
import 'package:atividade_2/repositories/user_repository.dart';
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
  UserRepository users = UserRepository();
  String sessionToken = '';
  users.validateToken(token).then((value) => sessionToken = value);
  return sessionToken;
}

String clearToken(String token) {
  SessionDataRepository sessionDataRepository = SessionDataRepository();
  if (token.isNotEmpty && sessionDataRepository.currentToken.isNotEmpty) {
    sessionDataRepository.deleteCurrentToken();
    return sessionDataRepository.currentToken;
  } else {
    return '';
  }
}

String generateToken() {
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  return getRandomString(15);
}

AuthClass loginUser(String email, String password) {
  UserRepository users = UserRepository();
  String userToken = '';
  var allUsers;
  users.getAll().then((value) => allUsers = value);
  List<String> usersList = users.emails;
  List<String> tokensList = users.tokens;
  users.getUserToken(email, password).then((value) => userToken = value);

  print('User token: $userToken');
  print('User names: $usersList');
  print('User tokens: $tokensList');
  print('getAll ${allUsers}');

  return AuthClass(userToken, userToken.isNotEmpty);
}

AuthClass registerUser(String email, String password, String name, bool terms) {
  UserRepository users = UserRepository();
  String token = generateToken();
  users.insertUser(name, email, password, token);
  return AuthClass(token, true);
}

class AuthClass {
  String token = '';
  bool isAuthenticated = false;

  AuthClass(this.token, this.isAuthenticated);
}
