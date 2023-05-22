class TaskScopes {
  String globalData = "My data";

  showData() {
    const String localData = "Data inside the function";
    print(localData);
    print(globalData);
  }
}
