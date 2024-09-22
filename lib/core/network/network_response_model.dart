class HTTPResponse<T> {
  T? data;
  int? statusCode;
  String? message;

  HTTPResponse({this.data, this.message, this.statusCode});
}
