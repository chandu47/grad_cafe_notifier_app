import 'dart:convert';

class User {
  final String deviceId;
  final String device_token;
  final String device_type;
  final bool notif_consent;
  final DateTime created_at;
  final DateTime last_notif_at;

  User({this.deviceId, this.device_token, this.device_type, this.notif_consent,
      this.created_at, this.last_notif_at});


  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
    deviceId: json["deviceId"],
    device_token: json["device_token"],
    device_type: json["device_type"],
    notif_consent: json["notif_consent"]);

  Map<String, dynamic> toJson() => {"deviceId": deviceId, "device_token": device_token, "device_type": device_type, "notif_consent": notif_consent};
  
}