import 'package:dio/dio.dart';
import 'package:merogames/api/rest_client.dart';
import 'package:merogames/exception_handling/base_model.dart';
import 'package:merogames/exception_handling/server_error.dart';
import 'package:merogames/models/login_response.dart';

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
      print(ServerError.withError(error: err).getErrorMessage());
      print("/// Post usecase return ");
      

     return BaseModel()..setException(ServerError.withError(error: err));
    }
    return BaseModel()..data = response;
  }
}
