import 'task_constructor.dart';
import 'task_functions.dart';
import 'task_scopes.dart';
import 'task_variables_types.dart';

void main() {
  // Task functions
  TaskFunctions funObj = TaskFunctions();
  print(funObj.getAdditionValue());
  funObj.setValues(40, 60);
  print(funObj.getAdditionValue());

  // Task construnctor
  TaskConstructor constructorObj = TaskConstructor("Hello Datasirpi");
  print(constructorObj.getText());

  // Task scope
  TaskScopes scopeObj = TaskScopes();
  scopeObj.showData();

  // Task variables
  TaskVariablesTypes taskVariablesTypes = TaskVariablesTypes();
  for (var employee in taskVariablesTypes.employeesWithDetail) {
    print("Name is ${employee['name']}. Phone number is ${employee['phNo']}");
  }
}
