enum NetworkType {
  wifi,
  cellular,
  bluetooth,
  ethernet,
  vpn,
  none,
  other,
 }

class NetworkInfoData {
  final NetworkType type;
  final String? ip;

  NetworkInfoData({required this.type, this.ip});

  Map<String, dynamic> toJson() => {'type': type.index, if (ip != null) 'ip': ip};
}
