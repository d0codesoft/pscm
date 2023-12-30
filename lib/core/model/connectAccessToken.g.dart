// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectAccessToken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectAccessToken _$ConnectAccessTokenFromJson(Map<String, dynamic> json) =>
    ConnectAccessToken(
      json['base_url'] as String,
      json['token'] as String,
      DateTime.parse(json['expire_utc'] as String),
    );

Map<String, dynamic> _$ConnectAccessTokenToJson(ConnectAccessToken instance) =>
    <String, dynamic>{
      'base_url': instance.baseUrl,
      'token': instance.token,
      'expire_utc': instance.expireUtc.toIso8601String(),
    };
