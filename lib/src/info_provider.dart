import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:uuid/uuid.dart';
import '../app_device_net_info.dart';
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDeviceNetworkInfo {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  static final NetworkInfo _networkInfo = NetworkInfo();

  static Future<AppInfoData> getAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    // String versionKey = Platform.isAndroid ? info.buildNumber : info.buildNumber;
    String buildNumber = (!Platform.isAndroid) ? info.buildNumber : info.buildNumber.replaceFirst(info.version.replaceAll(".", ""), "");

    return AppInfoData(
      name: info.appName,
      id: info.packageName,
      versionKey: buildNumber,
      versionNumber: info.version,
    );
  }

  static Future<String> _getOrCreateDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'unique_device_id';
    var id = prefs.getString(key);
    if (id == null) {
      id = const Uuid().v4();
      await prefs.setString(key, id);
    }
    return id;
  }

  static String? _getScreenResolution() {
    final window = WidgetsBinding.instance.platformDispatcher.views.firstOrNull ?? ui.PlatformDispatcher.instance.implicitView!;
    final width = window.physicalSize.width ~/ window.devicePixelRatio;
    final height = window.physicalSize.height ~/ window.devicePixelRatio;


    return '${width}x$height';
  }


  static Size? _getRealScreenResolution() {
    final physicalSize = ui.PlatformDispatcher.instance.implicitView?.physicalSize;
    if (physicalSize == null) return null;

    final width = physicalSize.width.toInt();
    final height = physicalSize.height.toInt();
    return Size(width.toDouble(), height.toDouble());
  }

  static String _getDeviceLanguage() {
    return WidgetsBinding.instance.platformDispatcher.locale.toLanguageTag();
  }

  static Future<DeviceInfoData> getDeviceInfo() async {
    try {
      final fallbackId = await _getOrCreateDeviceId();

      if (Platform.isAndroid) {
        final android = await _deviceInfo.androidInfo;
        return DeviceInfoData(
          company: android.manufacturer,
          type: DeviceType.mobile,
          id: android.id ?? fallbackId,
          model: android.model,
          os: OSType.android,
          osVersion: android.version.release,
          screenResolution: _getRealScreenResolution(),
          language: _getDeviceLanguage(),
        );
      } else if (Platform.isIOS) {
        final ios = await _deviceInfo.iosInfo;
        return DeviceInfoData(
          company: "Apple",
          type: DeviceType.mobile,
          id: ios.identifierForVendor ?? fallbackId,
          model: ios.utsname.machine,
          os: OSType.ios,
          osVersion: ios.systemVersion,
          screenResolution: _getRealScreenResolution(),
          language: _getDeviceLanguage(),
        );
      } else {
        return DeviceInfoData(
          type: DeviceType.other,
          id: fallbackId,
          os: OSType.other,
          screenResolution: _getRealScreenResolution(),
          language: _getDeviceLanguage(),
        );
      }
    }catch(e){
      log(e.toString());
      rethrow;
    }
  }

  static Future<NetworkInfoData> getNetworkInfo() async {
    final connectivity = await Connectivity().checkConnectivity();
    final ip = await _networkInfo.getWifiIP();

    final type = switch (connectivity) {
      ConnectivityResult.wifi => NetworkType.wifi,
      ConnectivityResult.mobile => NetworkType.cellular,
      _ => NetworkType.other,
    };

    return NetworkInfoData(type: type, ip: ip);
  }

  static Future<AppDeviceNetworkData> getAll() async {
    final app = await getAppInfo();
    final device = await getDeviceInfo();
    final network = await getNetworkInfo();
    return AppDeviceNetworkData(app: app, device: device, network: network);
  }
}
