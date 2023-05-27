// To parse this JSON data, do
//
//     final otpVerificationResponse = otpVerificationResponseFromJson(jsonString);

import 'dart:convert';

OtpVerificationResponse otpVerificationResponseFromJson(String str) => OtpVerificationResponse.fromJson(json.decode(str));

String otpVerificationResponseToJson(OtpVerificationResponse data) => json.encode(data.toJson());

class OtpVerificationResponse {
    bool status;
    bool profileExists;
    String jwt;

    OtpVerificationResponse({
        required this.status,
        required this.profileExists,
        required this.jwt,
    });

    factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) => OtpVerificationResponse(
        status: json["status"],
        profileExists: json["profile_exists"],
        jwt: json["jwt"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "profile_exists": profileExists,
        "jwt": jwt,
    };
}
