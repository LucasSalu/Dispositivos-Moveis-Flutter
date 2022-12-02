abstract class AuthEvent {}

class LoadUser extends AuthEvent {
  final String token;

  LoadUser({required this.token});
}

class LoginUser extends AuthEvent {
  final String email;
  final String password;

  LoginUser({required this.email, required this.password});
}

class RegisterUser extends AuthEvent {
  final String email;
  final String password;
  final bool hasAcceptedTerms;
  final String name;

  RegisterUser(
      {required this.hasAcceptedTerms,
      required this.name,
      required this.email,
      required this.password});
}

class LogoutUser extends AuthEvent {
  final String token;

  LogoutUser({required this.token});
}
