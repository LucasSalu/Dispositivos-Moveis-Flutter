class AuthState {
  String token;
  bool isAuthenticated;
  String name;
  String email;

  AuthState(
      {this.token = '',
      this.isAuthenticated = false,
      this.name = '',
      this.email = ''});
}
