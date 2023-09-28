// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dtoDataAPI.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOSystemInformation _$DTOSystemInformationFromJson(
        Map<String, dynamic> json) =>
    DTOSystemInformation(
      json['version'] as String,
      json['caption'] as String,
      json['countryCode'] as String,
      json['csName'] as String,
      json['currentTimeZone'] as int,
      json['description'] as String,
      json['foregroundApplicationBoost'] as int,
      json['freePhysicalMemory'] as int,
      json['freeSpaceInPagingFiles'] as int,
      json['freeVirtualMemory'] as int,
      DateTime.parse(json['installDate'] as String),
      DateTime.parse(json['lastBootUpTime'] as String),
      DateTime.parse(json['localDateTime'] as String),
      json['locale'] as String,
      json['manufacturer'] as String,
      json['name'] as String,
      json['numberOfProcesses'] as int,
      json['numberOfUsers'] as int,
      json['osArchitecture'] as String,
      json['serialNumber'] as String,
      json['status'] as String,
      json['totalVirtualMemorySize'] as int,
      json['totalVisibleMemorySize'] as int,
    );

Map<String, dynamic> _$DTOSystemInformationToJson(
        DTOSystemInformation instance) =>
    <String, dynamic>{
      'version': instance.version,
      'caption': instance.caption,
      'countryCode': instance.countryCode,
      'csName': instance.csName,
      'currentTimeZone': instance.currentTimeZone,
      'description': instance.description,
      'foregroundApplicationBoost': instance.foregroundApplicationBoost,
      'freePhysicalMemory': instance.freePhysicalMemory,
      'freeSpaceInPagingFiles': instance.freeSpaceInPagingFiles,
      'freeVirtualMemory': instance.freeVirtualMemory,
      'installDate': instance.installDate.toIso8601String(),
      'lastBootUpTime': instance.lastBootUpTime.toIso8601String(),
      'localDateTime': instance.localDateTime.toIso8601String(),
      'locale': instance.locale,
      'manufacturer': instance.manufacturer,
      'name': instance.name,
      'numberOfProcesses': instance.numberOfProcesses,
      'numberOfUsers': instance.numberOfUsers,
      'osArchitecture': instance.osArchitecture,
      'serialNumber': instance.serialNumber,
      'status': instance.status,
      'totalVirtualMemorySize': instance.totalVirtualMemorySize,
      'totalVisibleMemorySize': instance.totalVisibleMemorySize,
    };

DTORdpInformation _$DTORdpInformationFromJson(Map<String, dynamic> json) =>
    DTORdpInformation(
      json['caption'] as String,
      json['fEnableTerminal'] as bool,
      json['loggedOnUsers'] as int,
      json['terminalName'] as String,
    );

Map<String, dynamic> _$DTORdpInformationToJson(DTORdpInformation instance) =>
    <String, dynamic>{
      'caption': instance.caption,
      'fEnableTerminal': instance.fEnableTerminal,
      'loggedOnUsers': instance.loggedOnUsers,
      'terminalName': instance.terminalName,
    };

DTOInformationSystem _$DTOInformationSystemFromJson(
        Map<String, dynamic> json) =>
    DTOInformationSystem(
      DTOSystemInformation.fromJson(json['osInfo'] as Map<String, dynamic>),
      (json['rdp'] as List<dynamic>?)
          ?.map((e) => DTORdpInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DTOInformationSystemToJson(
        DTOInformationSystem instance) =>
    <String, dynamic>{
      'osInfo': instance.osInfo,
      'rdp': instance.rdp,
    };
