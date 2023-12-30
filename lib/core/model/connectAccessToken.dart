import 'package:json_annotation/json_annotation.dart';

part 'connectAccessToken.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ConnectAccessToken {
  late String baseUrl;
  late String token;
  late DateTime expireUtc;

  ConnectAccessToken(this.baseUrl,this.token,this.expireUtc);

  factory ConnectAccessToken.fromJson(Map<String, dynamic> json) => _$ConnectAccessTokenFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectAccessTokenToJson(this);
}