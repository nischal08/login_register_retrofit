import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merogames/api/post_usecase.dart';
import 'package:merogames/exception_handling/base_model.dart';
import 'package:merogames/models/register/register_request.dart';
import 'package:merogames/models/register/register_response.dart';
import 'package:merogames/screen/login-screen.dart';
import 'package:merogames/screen/otp-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends ChangeNotifier {
  String _responseId;
  String _responseMessage;
  String get responseId => this._responseId;
  bool isLoading = false;

  set responseId(String value) => this._responseId = value;

  get responseMessage => this._responseMessage;

  set responseMessage(value) => this._responseMessage = value;

  void onClickbackBtn(BuildContext context) {
    Navigator.pop(context);
    // notifyListeners();
  }

  void onClickLogin(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  dynamic onClickCreateAccount(
      {fname, lname, phoneNumber, password, confirmPassword, context}) async {
    BaseModel response;
    if (password == confirmPassword) {
      isLoading = true;
      notifyListeners();
      RegisterRequest _registerRequest;
      _registerRequest = RegisterRequest(
          firstName: fname,
          lastName: lname,
          phoneNumber: phoneNumber,
          password: password,
          confirmPassword: confirmPassword,
          referrer: "String",
          termsOfService: true,
          role: 0);

      response = await PostUsecase().userSignUp(_registerRequest.toJson());

      if (response.data != null) {
        isLoading = false;
      notifyListeners();
        debugPrint("id: ${response.data.id}");
        debugPrint("response: ${response.data.message}");

        _responseId = response.data.id;
        _responseMessage = response.data.message;
        SharedPreferences _sharedStore = await SharedPreferences.getInstance();
        _sharedStore.setString("id", _responseId);
        notifyListeners();
        print("SharedPreferences id:" + _sharedStore.get("id"));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OtpScreen(number: phoneNumber, userRegisteredId: _responseId),
          ),
        );
      } else {
          isLoading = false;
      notifyListeners();
        print(response.getException);
      }
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => LoginScreen(),
    //   ),
    // );
  }
}
