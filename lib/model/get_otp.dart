// To parse this JSON data, do
//
//     final getOtpResponse = getOtpResponseFromJson(jsonString);

import 'dart:convert';

GetOtpResponse getOtpResponseFromJson(String str) => GetOtpResponse.fromJson(json.decode(str));

String getOtpResponseToJson(GetOtpResponse data) => json.encode(data.toJson());

class GetOtpResponse {
    bool status;
    String response;
    String requestId;

    GetOtpResponse({
        required this.status,
        required this.response,
        required this.requestId,
    });

    factory GetOtpResponse.fromJson(Map<String, dynamic> json) => GetOtpResponse(
        status: json["status"],
        response: json["response"],
        requestId: json["request_id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "response": response,
        "request_id": requestId,
    };
}
