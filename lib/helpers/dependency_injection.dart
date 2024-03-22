import 'package:dio/dio.dart';
import 'package:flutter_api_rest/api/account_api.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/helpers/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjection {
  static void initialize() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.1.65:9000/api/v1',
      ),
    );
    final Http http = Http(
      dio: dio,
      logsEnable: true,
    );
    final _secureStorage = FlutterSecureStorage();

    final authenticationApi = AuthenticationApi(http);
    final authenticationClient = AuthenticationClient(_secureStorage, authenticationApi);
    final accountApi = AccountApi(http, authenticationClient);

    GetIt getIt = GetIt.instance;
    getIt.registerSingleton<AuthenticationApi>(authenticationApi);
    getIt.registerSingleton<AuthenticationClient>(authenticationClient);
    getIt.registerSingleton<AccountApi>(accountApi);

  }
}
