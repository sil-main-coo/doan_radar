import 'dart:convert';

class Account {
  String fullName, useName, password, role;

  Account({this.fullName, this.password, this.useName, this.role});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        fullName: json['fullName'],
        password: json['password'],
        useName: json['useName'],
        role: json['role']);
  }

  factory Account.fromRawData(String jsonString) {
    return Account.fromJson(jsonDecode(jsonString));
  }

  String toRawData() {
    return jsonEncode(this.toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': this.fullName,
      'password': this.password,
      'useName': this.useName,
      'role': this.role
    };
  }
}
