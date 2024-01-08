import 'dart:core';

abstract interface class ServerAPI {
  static String restURIOSInfo = "api/SystemManagment/OSInfo";
  static String restURIRDPSession = "api/SystemManagment/RDPSession";
  static String restURISetRDPConn = "api/SystemManagment/SetRDPConn?allow={0}";
  static String restURIPausedRDP = "api/SystemManagment/PausedRDP";
  static String restURIResumeRDP = "api/SystemManagment/ResumeRDP";
  static String restURIRemoteShutdown = "api/SystemManagment/RemoteShutdown";
  static String restURITSInfo = "api/SystemManagment/GetTSInfo";
  static String restURIGetUserAccounts = "api/SystemManagment/GetUserAccounts";
  static String restURIBlockUserAccount = "api/SystemManagment/BlockUserAccount";
  static String restURIUnblockUserAccount = "api/SystemManagment/UnblockUserAccount";
  static String restURIActive = "api/SystemManagment/Active";
  static String restURIAuth = "api/Auth/LoginUser";
  static String restURIGetUser = "api/Auth/GetUser";
  static String restURIGetConnectParam = "api/Auth/GetConnectParam";
}