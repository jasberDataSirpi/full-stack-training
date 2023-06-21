class TaskVariablesTypes {
  var companyName = "Datasirpi";
  late int amount = 300;
  static const int phNo = 8989786756;
  String description = "Datasirpi is a software company";
  bool isLoaded = true;

  dynamic employee = {"name": "Jasberraja", "EmployeeId": "E007"};

  Map<String, dynamic> mapData = {"name": "Jasberraja", "phNo": 8978677867};

  List<String> employees = ["Jasber", "Prathaban", "Dixon", "Prabu"];

  List<Map<String, dynamic>> employeesWithDetail = [
    {"name": "Jasberraja", "phNo": 8978677867},
    {"name": "Prathaban", "phNo": 8978677844},
    {"name": "Dixon", "phNo": 8978677899},
    {"name": "Prabu", "phNo": 8978677833},
  ];
}
