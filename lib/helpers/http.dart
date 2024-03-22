import 'package:dio/dio.dart';
import 'package:flutter_api_rest/helpers/http_response.dart';
import 'package:flutter_api_rest/utils/logs.dart';

class Http {
  late Dio _dio;
  late bool _logsEnable;

  Http({
    required Dio dio,
    required bool logsEnable,
  }) {
    _dio = dio;
    _logsEnable = logsEnable;
  }

  Future<HttpResponse<T>> request<T>(
    String path, {
    String method = 'GET',
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? formData,
    Map<String, dynamic>? headers,
    T Function(dynamic data)? parser,
  }) async {
    try {

      final response = await _dio.request(
        path,
        options: Options(
          method: method,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: formData != null? FormData.fromMap(formData) : data,
      );
      Logs.p.i(response.data);

      if (parser != null) {
        return HttpResponse.success<T>(parser(response.data));
      }

      return HttpResponse.success<T>(response.data);
    } catch (e) {
      Logs.p.e(e);

      int statusCode = 0;
      String message = 'unknown error';
      dynamic data;

      if (e is DioException) {
        statusCode = -1;
        message = e.message.toString();
        if (e.response != null) {
          statusCode = e.response!.statusCode!;
          message = e.response!.statusMessage!;
          data = e.response!.data;
        }
      }
      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }
}
