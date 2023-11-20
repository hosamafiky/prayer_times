import 'dart:io';

class ConnectionHelper {
  static Future<bool> hasConnection() async {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  }
}
