import 'dart:ui';

enum DeviceType { mobile, tablet, desktop, other }
enum OSType { android, ios, other }

class DeviceInfoData {
  final String? company;
  final DeviceType type;
  final String id;
  final String? model;
  final OSType os;
  final String? osVersion;
  final Size? screenResolution;
  final String? language;
  final String? timeZoneName;
  final int? timeZoneOffsetMinutes;
  final String? currentDeviceTime;
  final String? keyboardLocale;

  DeviceInfoData({
    this.company,
    required this.type,
    required this.id,
    this.model,
    required this.os,
    this.osVersion,
    this.screenResolution,
    this.language,
    this.timeZoneName,
    this.timeZoneOffsetMinutes,
    this.currentDeviceTime,
    this.keyboardLocale,
  });

  Map<String, dynamic> toJson() => {
    if (company != null) 'company': company,
    'type': type.index,
    'id': id,
    if (model != null) 'model': model,
    'os': os.index,
    if (osVersion != null) 'osVersion': osVersion,
    if (screenResolution != null) 'screenResolution': {"width":screenResolution!.width,"height":screenResolution!.height},
    if (language != null) 'deviceLanguage': language,
    if (timeZoneName != null) 'timezone': timeZoneName,
    if (timeZoneOffsetMinutes != null) 'timezoneOffset': timeZoneOffsetMinutes,
    if (currentDeviceTime != null) 'deviceTime': currentDeviceTime,
    if (keyboardLocale != null) 'keyboardLocale': keyboardLocale,
  };
}
