class UserRegisterModel {

  final String _username;
  final String _email;
  final String _password;

  UserRegisterModel({
    required String username,
    required String email,
    required String password
  }) : _password = password,
        _email = email,
        _username = username;

  String get username => _username;
  String get email => _email;
  String get password => _password;

}