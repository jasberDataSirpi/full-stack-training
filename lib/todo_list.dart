import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodoList extends StatefulWidget {
  const TodoList({
    super.key,
  });

  @override
  State<TodoList> createState() => _TodoList();
}

class _TodoList extends State<TodoList> {
  List<dynamic> todoList = [];

  fetchData() async {
    // Free API from typecode
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseMap =
            jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        setState(() {
          todoList = responseMap;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(), // The asynchronous operation
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return todoList.isNotEmpty
            ? ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        "${todoList[index]['title']} - ${todoList[index]['completed'] ? 'Completed' : 'Not completed'}"),
                  );
                },
              )
            : const Text("Loading");
      },
    );
  }
}
