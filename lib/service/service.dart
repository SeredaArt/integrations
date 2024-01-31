import 'package:flutter/services.dart';

class PlatformService {
  static const platform = MethodChannel('CALL_METHOD');

  @override
  Future<String> sendMessage(String message) async {
    try {
      var arguments = {
        'text': message,
      };
      return await platform.invokeMethod('CALL', arguments);
     } on PlatformException catch (e) {
      return e.message ?? '';
    }
  }
  
}