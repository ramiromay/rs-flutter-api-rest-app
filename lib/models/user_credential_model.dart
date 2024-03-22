class UserCredentialModel {

  final String _email;
  final String _password;

  UserCredentialModel({
    required String email,
    required String password
  }) : _password = password,
        _email = email;

  String get email => _email;
  String get password => _password;

}