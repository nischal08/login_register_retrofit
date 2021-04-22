import 'package:dio/dio.dart';
import 'package:merogames/api/rest_client.dart';
import 'package:merogames/exception_handling/base_model.dart';
import 'package:merogames/exception_handling/server_error.dart';
import 'package:merogames/models/login/login_response.dart';
import 'package:merogames/models/register/register_response.dart';
import 'package:merogames/models/register_otp/otp_response.dart';

class PostUsecase {
  Dio dio;
  RestClient restClient;

  PostUsecase() {
    dio = new Dio();
    restClient = new RestClient(dio);
  }

  Future<BaseModel<LoginResponse>> userLogIn(Map<String, dynamic> map) async {
    LoginResponse response;

    try {
      response = await restClient.userSignIn(map);
    } catch (err, stacktrace) {
      print("Exception occured From PostUsecase: $err stackTrace:$stacktrace");
      print("/// Post usecase return ");
      // print(ServerError.withError(error: err).getErrorMessage());

      return BaseModel()..setException(ServerError.withError(error: err));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<RegisterResponse>> userSignUp(
      Map<String, dynamic> map) async {
    RegisterResponse response;
    try {
      response = await restClient.userRegister(map);
      print("/// Post usecase try");
    print(response.id);
    print(response.message);
      print("/// Post usecase try");
    } catch (err, stacktrace) {
      print("Exception occured from PostUsecase: $err stackTrace:$stacktrace");
      print("/// Post usecase catch ");
      print(ServerError.withError(error: err).getErrorMessage());

      return BaseModel()..setException(ServerError.withError(error: err));
    }

    return BaseModel()..data = response;
  }
  Future<BaseModel<OtpResponse>> userVerifyOtp(
      Map<String, dynamic> map) async {
    OtpResponse response;
    try {
      response = await restClient.userVerifyOtp(map);
      print("/// Post usecase try");
    print(response.message);
      print("/// Post usecase try");
    } catch (err, stacktrace) {
      print("Exception occured from PostUsecase: $err stackTrace:$stacktrace");
      print("/// Post usecase catch ");
      print(ServerError.withError(error: err).getErrorMessage());

      return BaseModel()..setException(ServerError.withError(error: err));
    }

    return BaseModel()..data = response;
  }
}
