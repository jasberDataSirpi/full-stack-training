import 'package:flutter/material.dart';
import './api_service.dart';

class TaskAsyncAwait extends StatefulWidget {
  const TaskAsyncAwait({
    super.key,
  });

  @override
  State<TaskAsyncAwait> createState() => _TodoList();
}

class _TodoList extends State<TaskAsyncAwait> {
  List<dynamic> todoList = [];
  bool isLoaded = false;

  fetchData() async {
    todoList = await fetchTodoList();
    print(todoList);
    setState(() {
      isLoaded = todoList.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? const Text("Todo List Loaded. Please check the console")
        : ElevatedButton(
            onPressed: () => {fetchData()}, child: const Text("Get Todo List"));
  }
}
