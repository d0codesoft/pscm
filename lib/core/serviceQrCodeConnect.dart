import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;


import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'model/connectAccessToken.dart';
import 'model/oAuthResult.dart';
import 'serverRemoteAPI.dart';

class serviceQrCodeConnect {
  final _logger = Logger('pscm');
  late ConnectAccessToken? dataConnect;

  serviceQrCodeConnect.fromAccessConnect(ConnectAccessToken accessConnect)
  {
    dataConnect = accessConnect;
  }

  serviceQrCodeConnect.fromRawString(String rawStringQrCode)
  {
    dataConnect = fromStringQrCode(rawStringQrCode);
  }

  bool isValidQrCode()
  {
    return dataConnect!=null;
  }

  Future<OAuthResult?> getConnectedToken()
  async {
    if (isValidQrCode()) {
      final uri2 = Uri.parse(dataConnect!.baseUrl);
      final uri3 = Uri(
                  scheme: uri2.scheme,
                  host: uri2.host,
                  port: uri2.port,
                  path: uri2.path,
                  queryParameters: {'tokenConnect': dataConnect!.token});
      developer.log("Get token to access server $uri3");
      final response = await http
          .post(uri3, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      });

      developer.log("Response ${response.statusCode} ${response.body}");
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData.containsKey("status") &&
            jsonData["status"].toString().toLowerCase() == "ok") {
          return OAuthResult.fromJson(jsonData["token"]);
        }
      }
    }
    return null;
  }

  static ConnectAccessToken? fromStringQrCode(String rawStringQrCode)
  {
    try {
      final decodeBase64Json = base64.decode(rawStringQrCode);
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