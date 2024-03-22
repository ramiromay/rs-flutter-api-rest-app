import 'package:flutter_api_rest/models/user_credential_model.dart';
import 'package:flutter_api_rest/models/user_register_model.dart';
import 'package:flutter_api_rest/helpers/http.dart';
import 'package:flutter_api_rest/helpers/http_response.dart';
import 'package:flutter_api_rest/models/authentication_response.dart';

class AuthenticationApi {

  final Http _http;

  AuthenticationApi(this._http);

  Future<HttpResponse<AuthenticationResponse>> register({
    required UserRegisterModel userRegister,
  }) {
    return _http.request<AuthenticationResponse>(
      '/register',
      method: 'POST',
      data: {
        "username": userRegister.username,
        "email": userRegister.email,
        "password": userRegister.password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

  Future<HttpResponse<AuthenticationResponse>> login({
    required UserCredentialModel userCredential,
  }) async {
    return _http.request<AuthenticationResponse>(
      '/login',
      method: 'POST',
      data: {
        "email": userCredential.email,
        "password": userCredential.password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

  Future<HttpResponse<AuthenticationResponse>> refreshToken(String expiredToken) {
    return _http.request<AuthenticationResponse>(
      '/refresh-token',
      method: 'POST',
      headers: {
        'token': expiredToken,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

}
