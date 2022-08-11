import 'package:http/http.dart' as http;

class HttpManager {
  static final HttpManager sharedInstance = HttpManager._internal();
  factory HttpManager() {
    return sharedInstance;
  }

  HttpManager._internal();

  final Map<String, String>? headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  Future<http.Response> makeGetAPICall(
    Uri url,
    Map<String, String> headers,
  ) {
    return http.get(url, headers: headers);
  }

  Future<APIResponse> apiGetRequest(
    Map<String, dynamic> request,
    String endPoint,
    String baseURL,
  ) async {
    var uri = Uri.https(baseURL, endPoint, request);
    var response = await http.get(uri, headers: headers);
    return APIResponse(response.statusCode, response.body);
  }
}

class APIResponse {
  int statusCode;
  dynamic response;
  APIResponse(this.statusCode, this.response);
}
