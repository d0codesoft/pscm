
class ServerInfo {
  late int id;
  late String? name;
  late String? descr;
  late String? token;
  late String? userName;
  late String? userPassword;
  late String? serverAddress;
  late String? serverPort;
  late bool? isActive;

  ServerInfo({required this.id, this.name, this.descr, this.token, this.userName,
      this.userPassword, this.serverAddress, this.serverPort, this.isActive});

  Map<String, dynamic> toMapDB() {
    return {
      'name': name,
      'description': descr,
      'token': token,
      'username': userName,
      'password': userPassword,
      'server': serverAddress,
      'inactive': isActive==true ? 0 : 1,
    };
  }
}