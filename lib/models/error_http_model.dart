import 'dart:convert';

class ErrorHttp {
  ErrorHttp({
    required this.statusCode,
    required this.message,
    required this.error,
  });

  int statusCode;
  String message;
  String error;

  factory ErrorHttp.fromRawJson(String str) =>
      ErrorHttp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorHttp.fromJson(Map<String, dynamic> json) => ErrorHttp(
        statusCode: json["statusCode"],
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "error": error,
      };
}
