import 'local_storage_service.dart';

Future<bool> isAuthorised() async {
  String? loginSessionInfo = await fetchStringFromSecureStorage("access_token");
  return (loginSessionInfo.isNotEmpty);
}
