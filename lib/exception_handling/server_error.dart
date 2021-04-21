import 'package:dio/dio.dart';

class ServerError implements Exception {
  int _errorCode;
   String  _errorMessage;
 

  ServerError.withError({DioError error}) {
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        _errorMessage = "The request has been cancelled";
        break;

      case DioErrorType.CONNECT_TIMEOUT:
        _errorMessage = "The connection time exceeded";
        break;

      case DioErrorType.RECEIVE_TIMEOUT:
        _errorMessage = "The receive timeout exceeded";
        break;

      case DioErrorType.DEFAULT:
        _errorMessage = "The connection failed due to internet connection";
        break;

      case DioErrorType.SEND_TIMEOUT:
        _errorMessage = "The send timeout exceeded";
        break;

      case DioErrorType.RESPONSE:
        _errorMessage =
            "Recieved Invalid Username or Password";
            // "Recieved Invalid status Code ${error.response.statusCode}";
        break;
    }
    return _errorMessage;
  }
}
