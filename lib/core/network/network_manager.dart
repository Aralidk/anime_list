import 'dart:convert';
import 'package:dio/dio.dart';
import 'http_enums.dart';
import 'network_response_model.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();

  factory NetworkManager() {
    return _instance;
  }

  NetworkManager._internal();

  Future<HTTPResponse> get(String url,
      {Map<String, dynamic>? queryParams}) async {
    return _sendRequest(url,
        method: RequestMethod.GET, queryParams: queryParams);
  }

  Future<HTTPResponse> post(String url,
      {dynamic body, Map<String, dynamic>? queryParams}) async {
    return _sendRequest(url,
        method: RequestMethod.POST, body: body, queryParams: queryParams);
  }

  Future<HTTPResponse> put(String url,
      {dynamic body, Map<String, dynamic>? queryParams}) async {
    return _sendRequest(url,
        method: RequestMethod.PUT, body: body, queryParams: queryParams);
  }

  Future<HTTPResponse> delete(String url,
      {dynamic body, Map<String, dynamic>? queryParams}) async {
    return _sendRequest(url,
        method: RequestMethod.DELETE, body: body, queryParams: queryParams);
  }

  Future<HTTPResponse> _sendRequest(String url,
      {required RequestMethod method,
      dynamic body,
      Map<String, dynamic>? queryParams}) async {
    Dio dio = Dio();
    Options options = Options(
      headers: {"Access-Control-Allow-Origin": "*"},
    );
    try {
      HTTPResponse response;
      switch (method) {
        case RequestMethod.GET:
          var res = await dio.get(url,
              options: options, queryParameters: queryParams);
          response = HTTPResponse(
              data: res.data["data"],
              message: res.statusMessage,
              statusCode: res.statusCode);
          break;
        case RequestMethod.PUT:
          var res = await dio.put(
            url,
            data: body != null ? jsonEncode(body) : null,
            queryParameters: queryParams,
            options: options,
          );
          response = HTTPResponse(
              data: json.decode(
                utf8.decode(res.data),
              ),
              message: res.statusMessage,
              statusCode: res.statusCode);
          break;
        case RequestMethod.POST:
          var res = await dio.post(url,
              queryParameters: queryParams,
              options: options,
              data: body != null ? jsonEncode(body) : null);
          response = HTTPResponse(
              data: json.decode(
                utf8.decode(res.data),
              ),
              message: res.statusMessage,
              statusCode: res.statusCode);
          break;
        case RequestMethod.DELETE:
          var res = await dio.delete(url,
              queryParameters: queryParams,
              options: options,
              data: body != null ? jsonEncode(body) : null);
          response = HTTPResponse(
              data: json.decode(
                utf8.decode(res.data),
              ),
              message: res.statusMessage,
              statusCode: res.statusCode);
          break;
        default:
          throw Exception('Invalid request method.');
      }
      return HTTPResponse(
        data: response.data,
        message: response.message,
        statusCode: response.statusCode,
      );
    } catch (e) {
      return HTTPResponse(statusCode: 400);
    }
  }
}
