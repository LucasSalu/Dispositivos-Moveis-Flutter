import 'dart:math';

import 'package:atividade_2/repositories/session_data_repository.dart';
import 'package:atividade_2/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthState initialState) : super(initialState) {
    on<LoadUser>((event, emit) async {
      emit(AuthState(token: await authenticate(event.token)));
    });
    on<LoginUser>((event, emit) async {
      AuthClass authenticationState =
          await loginUser(event.email, event.password);
      emit(AuthState(
          email: event.email,
          name: authenticationState.name,
          token: authenticationState.token,
          isAuthenticated: authenticationState.isAuthenticated));
    });
    on<RegisterUser>((event, emit) async {
      AuthClass authenticationState = await registerUser(
          event.email, event.password, event.name, event.hasAcceptedTerms);
      emit(AuthState(
          email: event.email,
          name: authenticationState.name,
          token: authenticationState.token,
          isAuthenticated: authenticationState.isAuthenticated));
    });
    on<LogoutUser>((event, emit) {
      emit(AuthState(token: clearToken(event.token)));
    });
  }
}

Future<String> authenticate(String token) async {
  UserRepository users = UserRepository();
  String sessionToken = await users.validateToken(token);

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

Future<AuthClass> loginUser(String email, String password) async {
  UserRepository users = UserRepository();
  String userToken = await users.getUserToken(email, password);
  String userName = await users.getUserNameByEmail(email);

  return AuthClass(userToken, userToken.isNotEmpty, userName);
}

Future<AuthClass> registerUser(
    String email, String password, String name, bool terms) async {
  UserRepository users = UserRepository();
  String token = generateToken();
  await users.insertUsers(name, email, password, token);
  String userName = await users.getUserNameByEmail(email);

  return AuthClass(token, true, userName);
}

class AuthClass {
  String token = '';
  bool isAuthenticated = false;
  String name = '';

  AuthClass(this.token, this.isAuthenticated, [this.name = '']);
}
