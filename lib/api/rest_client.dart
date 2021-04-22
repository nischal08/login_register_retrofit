import 'package:merogames/api/api_url.dart';
// import 'package:merogames/models/login_request.dart';
import 'package:merogames/models/login/login_response.dart';
import 'package:merogames/models/register/register_response.dart';
import 'package:merogames/models/register_otp/otp_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: ApiUrl.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio) {
    dio.options = BaseOptions(receiveTimeout: 20000, connectTimeout: 20000);
    return _RestClient(dio, baseUrl: ApiUrl.baseUrl);
  }

  @POST(ApiUrl.loginUrl)
  Future<LoginResponse> userSignIn(@Body() Map<String, dynamic> map);

  @POST(ApiUrl.registerUrl)
  Future<RegisterResponse> userRegister(@Body() Map<String, dynamic> map);
  
  @POST(ApiUrl.otpRegisterUrl)
  Future<OtpResponse> userVerifyOtp(@Body() Map<String, dynamic> map);
}
