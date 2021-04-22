// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
    LoginRequest({
        this.identity,
        this.password,
        this.returnUrl,
    });

    final String identity;
    final String password;
    final String returnUrl;

    factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        identity: json["identity"],
        password: json["password"],
        returnUrl: json["returnUrl"],
    );

    Map<String, dynamic> toJson() => {
        "identity": identity,
        "password": password,
        "returnUrl": returnUrl,
    };
}
