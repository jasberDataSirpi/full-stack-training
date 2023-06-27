import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String domainUrl = "${dotenv.env['TYPECODE_BACKEND_URL']}/mealplanet";

Future<List> getBrands() async {
  var url = Uri.parse('$domainUrl/brands');

  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final List responseData = jsonDecode(response.body);
      return responseData.cast<dynamic>();
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
  return [];
}

Future<bool> addBrand(payload) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  var url = Uri.parse('$domainUrl/brands');

  try {
    var response = await http.post(
      url,
      headers: headers,
      body: payload,
    );
    if (response.statusCode == 200) {
      return true;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
  return false;
}

Future getBrandById(int id) async {
  var url = Uri.parse('$domainUrl/brands/$id');

  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      return responseData;
    }
  } catch (e) {
    print('Error: $e');
    return {};
  }
  return {};
}

Future<bool> updateBrand(int id, payload) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  var url = Uri.parse('$domainUrl/brands/$id');

  try {
    var response = await http.put(
      url,
      headers: headers,
      body: payload,
    );
    if (response.statusCode == 200) {
      return true;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
  return false;
}
