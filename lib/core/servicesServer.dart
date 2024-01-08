
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'database.dart';
import 'model/dataServer.dart';
import 'model/dtoDataAPI.dart';
import 'serverRemoteAPI.dart';

class ServiceServer {
  ServerInfo _dataConnect;
  DTOInformationSystem? data;

  ServiceServer({ required ServerInfo dataConnect }) : _dataConnect = dataConnect;

  ServerInfo get connect => _dataConnect;

  set connect(ServerInfo dataConnect) {
    _dataConnect = dataConnect;
  }

  int get id {
    return _dataConnect.id;
  }

  String getConnectedUrl(String api) {
    String url = _dataConnect.serverAddress?.trim() ?? '';
    if (url.isEmpty)
    {
      throw Exception('Failed server address');
    }
    if (url.contains('https//')) {
      url = url.replaceFirst('https//', 'https://');
    }
    if (url.contains('http//')) {
      url = url.replaceFirst('http//', 'http://');
    }
    url = p.join(url,api);
    return url;
  }

  Future<bool> iaAuthorizeServer() async {
    String url = getConnectedUrl(ServerAPI.restURIGetUser);
    developer.log("Test authorize remote server $url");
    final response = await http
        .get(Uri.parse(url), headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.authorizationHeader: _dataConnect.token ?? '',
        });

    developer.log("Response ${response.statusCode} ${response.body}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['isAuthenticated']==true) {
        return true;
      }
      else {
        _dataConnect.token = '';
        saveTokenAccess();
      }
    }
    return false;
  }

  Future<void> saveTokenAccess() async {
    DBProvider instance = DBProvider.instance;
    await instance.updateTokenAccessServer(_dataConnect.id, _dataConnect.token ?? '');
  }

  Future<bool> authorizedServer() async {
    String url = getConnectedUrl(ServerAPI.restURIAuth);
    developer.log("Authorize server $url");
    final response = await http
        .post(Uri.parse(url), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'Username' : _dataConnect.userName!,
        'Password' : _dataConnect.userPassword!,
        'RememberMe' : true
      })
    );

    developer.log("Response ${response.statusCode} ${response.body}");
    if (response.statusCode == 200) {
      if (response.headers.keys.contains('x-authtoken')) {
        _dataConnect.token = response.headers['x-authtoken'];
        developer.log("Set X-AuthToken ${_dataConnect.token}");
        saveTokenAccess();
        return true;
      }
    }
    return false;
  }

  Future<DTOInformationSystem?> fetchRemoteDataOSInformation() async {
      if (!await iaAuthorizeServer()) {
        if (!await authorizedServer()) {
          return null;
        }
      }
      String url = getConnectedUrl(ServerAPI.restURIOSInfo);
      final response = await http
          .get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: _dataConnect.token ?? '',
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        data = DTOInformationSystem.fromJson(jsonData);
      } else {
        data = null;
        return null;
      }
      return data;
  }
}

abstract class ServiceServers {
  Future<List<ServiceServer>> allServiceServers();
  Future<bool> deleteServerConnect(int id);
}

class ServiceServerRepository implements ServiceServers {
  final DBProvider dbinstance = DBProvider.instance;

  @override
  Future<List<ServiceServer>> allServiceServers() async {
    List<ServerInfo> connectedData = await dbinstance.fetchAllServers();
    return List.generate(connectedData.length, (i) {
      return ServiceServer(dataConnect: connectedData[i]);
    });
  }

  @override
  Future<bool> deleteServerConnect(int id) async {
    return await dbinstance.deleteServerInfo(id);
  }
}
