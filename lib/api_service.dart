import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List> fetchTodoList() async {
  // Free API from typecode
  var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');

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
