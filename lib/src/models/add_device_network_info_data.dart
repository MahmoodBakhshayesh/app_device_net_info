import '../../app_device_net_info.dart';

class AppDeviceNetworkData {
  final AppInfoData app;
  final DeviceInfoData device;
  final NetworkInfoData network;

  AppDeviceNetworkData({
    required this.app,
    required this.device,
    required this.network,
  });

  Map<String, dynamic> toJson() => {
    'app': app.toJson(),
    'device': device.toJson(),
    'network': network.toJson(),
  };
}
