import 'package:shared_preferences/shared_preferences.dart';

// Save a value in secure storage
Future<void> saveInSecureStorage(String key, dynamic value) async {
  final sharedPreferences = await SharedPreferences.getInstance();

  // Check the type of the value and save accordingly
  if (value is int) {
    await sharedPreferences.setInt(key, value);
  } else if (value is bool) {
    await sharedPreferences.setBool(key, value);
  } else {
    await sharedPreferences.setString(key, value.toString());
  }
}

// Fetch a value from secure storage
Future<Object?> fetchFromSecureStorage(String key) async {
  return (await SharedPreferences.getInstance()).get(key);
}

// Fetch a string value from secure storage
Future<String> fetchStringFromSecureStorage(String secureKey) async {
  Object? object = await fetchFromSecureStorage(secureKey);
  return object != null ? object as String : '';
}

// Fetch a boolean value from secure storage
Future<bool> fetchBoolFromSecureStorage(String secureKey) async {
  Object? object = await fetchFromSecureStorage(secureKey);
  return object != null ? object as bool : false;
}

// Fetch an integer value from secure storage
Future<int> fetchIntFromSecureStorage(String secureKey) async {
  Object? object = await fetchFromSecureStorage(secureKey);
  return object != null ? object as int : 0;
}
