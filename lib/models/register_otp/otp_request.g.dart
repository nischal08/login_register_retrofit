// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpRequest _$OtpRequestFromJson(Map<String, dynamic> json) {
  return OtpRequest(
    id: json['id'] as String,
    resetMethod: json['resetMethod'] as int,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$OtpRequestToJson(OtpRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'resetMethod': instance.resetMethod,
    };
