import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String? domainUrl = dotenv.env['TYPECODE_BACKEND_URL'];

Future<List> fetchTodoList() async {
  // Free API from typecode
  var url = Uri.parse('$domainUrl/todos');

  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseMap = jsonDecode(utf8.decode(response.bodyBytes));
      return responseMap;
    }
  } catch (e) {
    print('Error: $e');
  }
  return [];
}
