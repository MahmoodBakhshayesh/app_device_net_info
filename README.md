# 📱 app_device_network_info

A Flutter plugin that provides structured access to application, device, and network information — all in JSON-serializable format. Ideal for logging, analytics, debugging, or tagging API requests with environment metadata.

> ⚙️ Works on **Android** and **iOS**. No permissions required.

---

## ✨ Features

- ✅ App info: name, version, build number, platform, environment
- ✅ Device info: model, OS, manufacturer, screen resolution, language, unique ID
- ✅ Network info: IP address, connection type (Wi-Fi, cellular)
- ✅ All data serialized to clean, nested `Map<String, dynamic>`

---

## 🚀 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  app_device_network_info: ^0.0.1
```

Then run:

```bash
flutter pub get
```

---

## 🧠 Usage

```dart
import 'package:app_device_network_info/app_device_network_info.dart';

void main() async {
  final info = await AppDeviceNetworkInfo.getAll();
  print(info.toJson());
}
```

### 📦 Output (Sample)

```json
{
  "app": {
    "name": "ExampleApp",
    "id": "com.example.app",
    "versionKey": "42",
    "versionNumber": "1.2.3"
  },
  "device": {
    "manufacturer": "Apple",
    "type": 0,
    "id": "1e2d4f7b-bc90-41ea-9af6-21fd02be41c0",
    "model": "iPhone13,3",
    "os": 1,
    "osVersion": "17.2",
    "screen_resolution": "1125x2436",
    "device_language": "en-US"
  },
  "network": {
    "type": 0,
    "ip": "192.168.1.105"
  }
}
```

---

## 🛠 Fields

### App Info
| Field          | Type    | Example           |
|----------------|---------|-------------------|
| name           | String  | `ExampleApp`      |
| id             | String  | `com.example.app` |
| versionKey     | String  | `42`              |
| versionNumber  | String  | `1.2.3`           |

### Device Info
| Field              | Type    | Example             |
|--------------------|---------|---------------------|
| manufacturer       | String  | `Samsung`, `Apple`  |
| type               | int     | `0 = mobile`        |
| id (UUID)          | String  | `1e5rt71e...`        |
| model              | String  | `iPhone13,3`        |
| os                 | int     | `0 = Android, 1 = iOS` |
| osVersion          | String  | `17.2`, `12`        |
| screen_resolution  | String  | `1125x2436`         |
| device_language    | String  | `en-US`, `fa-IR`    |

### Network Info
| Field       | Type   | Example        |
|-------------|--------|----------------|
| type        | int    | `0 = WiFi`     |
| ip          | String | `192.168.1.105`|

---

## 📎 Notes

- The device ID is a persistent UUID stored using `shared_preferences`, if no reliable platform-specific ID is available.
- No location or push token is collected — keeping it simple and permission-free.
- Platform detection is inferred from device info (e.g., iOS vs Android).

---

## 🔐 Permissions

None required! This plugin works without runtime permission prompts.

---

## 📄 License

MIT

---

## 💡 Contributions

Pull requests, bug reports, and feedback are welcome!

---

## 📣 Author

Developed by ABOMIS · ✉️ [mike.backshaw@abomis.com]
