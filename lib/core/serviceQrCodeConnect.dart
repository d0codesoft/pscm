import 'dart:convert';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'model/connectAccessToken.dart';

class serviceQrCodeConnect {
  final _logger = Logger('pscm');
  late ConnectAccessToken? dataConnect;

  serviceQrCodeConnect(Map<String, dynamic> data)
  {
    try {
      dataConnect = ConnectAccessToken.fromJson(data);
    }
    catch(e, stackTrace) {
      _logger.log(Level.ALL, 'Error decode QR code from json');
    }
  }

  static ConnectAccessToken? fromStringQrCode(String dataQrCode)
  {
    try {
      final decodeBase64Json = base64.decode(dataQrCode);
      final decodeZipJson = gzip.decode(decodeBase64Json);
      final originalJson = utf8.decode(decodeZipJson);
      final jsonData = jsonDecode(originalJson) as Map<String, dynamic>;
      return ConnectAccessToken.fromJson(jsonData);
    }
    catch (e) {
      return null;
    }
  }
}