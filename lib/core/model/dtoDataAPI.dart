// -- dto_system_information.dart --

import 'package:json_annotation/json_annotation.dart';

part 'dtoDataAPI.g.dart';

@JsonSerializable()
class DTOSystemInformation {
  String version;
  String caption;
  String countryCode;
  String csName;
  int currentTimeZone;
  String description;
  int foregroundApplicationBoost;
  int freePhysicalMemory;
  int freeSpaceInPagingFiles;
  int freeVirtualMemory;
  DateTime installDate;
  DateTime lastBootUpTime;
  DateTime localDateTime;
  String locale;
  String manufacturer;
  String name;
  int numberOfProcesses;
  int numberOfUsers;
  String osArchitecture;
  String serialNumber;
  String status;
  int totalVirtualMemorySize;
  int totalVisibleMemorySize;

  DTOSystemInformation(this.version,this.caption,this.countryCode,this.csName,this.currentTimeZone,this.description,this.foregroundApplicationBoost,this.freePhysicalMemory,this.freeSpaceInPagingFiles,this.freeVirtualMemory,this.installDate,this.lastBootUpTime,this.localDateTime,this.locale,this.manufacturer,this.name,this.numberOfProcesses,this.numberOfUsers,this.osArchitecture,this.serialNumber,this.status,this.totalVirtualMemorySize,this.totalVisibleMemorySize,);

  factory DTOSystemInformation.fromJson(Map<String, dynamic> json) => _$DTOSystemInformationFromJson(json);

  Map<String, dynamic> toJson() => _$DTOSystemInformationToJson(this);
}
// -- dto_rdp_information.dart --

@JsonSerializable()
class DTORdpInformation {
  String caption;
  bool fEnableTerminal;
  int loggedOnUsers;
  String terminalName;

  DTORdpInformation(this.caption,this.fEnableTerminal,this.loggedOnUsers,this.terminalName,);

  factory DTORdpInformation.fromJson(Map<String, dynamic> json) => _$DTORdpInformationFromJson(json);

  Map<String, dynamic> toJson() => _$DTORdpInformationToJson(this);
}

@JsonSerializable()
class DTOInformationSystem {
  DTOSystemInformation osInfo;
  List<DTORdpInformation>? rdp;

  DTOInformationSystem(this.osInfo,this.rdp,);

  factory DTOInformationSystem.fromJson(Map<String, dynamic> json) => _$DTOInformationSystemFromJson(json);

  Map<String, dynamic> toJson() => _$DTOInformationSystemToJson(this);
}
