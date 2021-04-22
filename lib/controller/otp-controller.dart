import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merogames/api/post_usecase.dart';
import 'package:merogames/exception_handling/base_model.dart';
import 'package:merogames/models/register_otp/otp_request.dart';

import 'package:merogames/screen/home-screen.dart';

class OtpController extends ChangeNotifier {
  String otpTokenCode;
  String userRegisteredId;
  String otpResponseMsg;
  String otpErrorMsg;
  bool isLoading = false;

  void setOtpAndUserResgisteredId(
      {String otpCode, String userRegisteredId}) async {
    this.otpTokenCode = otpCode;
    this.userRegisteredId = userRegisteredId;
    notifyListeners();

    // print("id: " + userRegisteredId + "\n" + "otpCode: " + otpCode);
  }

  void onClickOtpSend(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    OtpRequest _otpReq;
    _otpReq =
        OtpRequest(id: userRegisteredId, resetMethod: 0, token: otpTokenCode);

    BaseModel response = await PostUsecase().userVerifyOtp(_otpReq.toJson());
    otpTokenCode = "";
      notifyListeners();
    if (response.data != null) {
      otpResponseMsg = response.data.message;
     
      notifyListeners();
      print(otpResponseMsg);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      otpErrorMsg = response.getException;
      isLoading = false;
      notifyListeners();
      print(otpErrorMsg);
    }
  }

  void onCLickBackBtn(BuildContext context) {
    Navigator.of(context).pop();
  }
}
