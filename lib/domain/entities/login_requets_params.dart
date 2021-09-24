class LoginRequestParams {
  final String userName;
  final String password;

  LoginRequestParams({
    this.userName,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'password': password,
    };
  }
}
