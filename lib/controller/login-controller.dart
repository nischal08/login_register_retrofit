// import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:merogames/api/post_usecase.dart';
import 'package:merogames/exception_handling/base_model.dart';

import 'package:merogames/models/login/login_request.dart';
// import 'package:merogames/api/auth-service.dart';
import 'package:merogames/models/login/login_response.dart';
import 'package:merogames/screen/all-home.dart';
// import 'package:merogames/screen/home-screen.dart';
// import 'package:merogames/screen/home-screen.dart';
import 'package:merogames/screen/register-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  bool showLoading = false;

  LoginResponse _loginResponse;
  String loginResponseData;
  String loginResponseError;

  get loginResponse => this._loginResponse;

  set loginResponse(value) => this._loginResponse = value;

  String response;
  var authInfo;
  void onClickBackBtn(BuildContext context) {
    Navigator.pop(context);
    // notifyListeners();
  }

  Future onClickSaveBtn({
    String identity,
    String password,
    BuildContext context,
  }) async {
    LoginRequest _loginRequest;
    _loginRequest = LoginRequest(
        identity: identity, password: password, returnUrl: "String");
    showLoading = true;
    notifyListeners();
    BaseModel response = await PostUsecase().userLogIn(
      _loginRequest.toJson(),
    );

    if (response.data != null) {
      showLoading = false;
      notifyListeners();
      loginResponseData = response.data.sessionToken;
      loginResponseError = null;
      
      notifyListeners();
      // SharedPreferences _sharedPref=new SharedPreferences().g
      print("Login Controller Response Data:: " + loginResponseData);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AllHome(),
        ),
      );
    } else {
      showLoading = false;
      notifyListeners();
      loginResponseError = response.getException;
      await Future.delayed(
        Duration(seconds: 3),
      );
      loginResponseError=null;
      loginResponseData = null;
      notifyListeners();
      print("Login Controller Response Error:: " + loginResponseError);
    }
  }

  void onClickCreateAcc(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
  }
}
