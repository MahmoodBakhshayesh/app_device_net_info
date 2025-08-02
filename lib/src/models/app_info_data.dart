
class AppInfoData {
  final String name;
  final String id;
  final String? versionKey;
  final String? versionNumber;

  AppInfoData({required this.name, required this.id, this.versionKey, this.versionNumber});

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    if (versionKey != null) 'versionKey': versionKey,
    if (versionNumber != null) 'versionNumber': versionNumber,
  };
}