import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:meal_planet/constants/http_constants.dart';

final String baseUrl = dotenv.env['BACKEND_URL']!;

// Function to make an HTTP request
Future<http.Response> request(String method, String urlString,
    {Map<String, dynamic>? queryParams,
    Map<String, dynamic>? payload,
    Map<String, String>? headers}) async {
  var uri = Uri.https(baseUrl, urlString);

  headers?['Content-type'] = 'application/json';

  switch (method) {
    case HttpConstants.GET:
      // Perform a GET request
      return await http.get(uri, headers: headers);
    case HttpConstants.POST:
      // Perform a POST request
      final payloadData = jsonEncode(payload);
      return await http.post(uri, headers: headers, body: payloadData);
    case HttpConstants.PUT:
      // Perform a PUT request
      final payloadData = jsonEncode(payload);
      return await http.put(uri, headers: headers, body: payloadData);
    case HttpConstants.DELETE:
      // Perform a DELETE request
      return await http.delete(uri, headers: headers);
    default:
      // If an invalid method is provided, fallback to a GET request
      return http.get(uri, headers: headers);
  }
}

// Function to make an authenticated request by adding an access token to the headers
Future<http.Response> authRequest(String method, String urlString,
    {Map<String, dynamic>? queryParams, Map<String, dynamic>? payload}) async {
  var headers = getHeaderWithAuthentication();
  // Delegate the request to the `request` function with the added headers
  return await request(method, urlString,
      queryParams: queryParams, payload: payload, headers: headers);
}

// Function to generate headers with authentication by adding an access token
Map<String, String> getHeaderWithAuthentication() {
  Map<String, String> headers = {};
  String accessToken = "Dummy Token";
  headers['Authorization'] = "Bearer $accessToken";
  return headers;
}
