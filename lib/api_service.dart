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
  }
  return [];
}
