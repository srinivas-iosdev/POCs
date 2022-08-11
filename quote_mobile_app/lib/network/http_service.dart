import 'package:http/http.dart' as http;

class HttpService {
  static final HttpService sharedInstance = HttpService._internal();
  factory HttpService() {
    return sharedInstance;
  }

  HttpService._internal();

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
