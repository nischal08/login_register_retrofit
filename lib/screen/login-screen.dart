// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:merogames/constants/constants.dart';
import 'package:merogames/controller/login-controller.dart';
import 'package:merogames/widgets/custom-textfield.dart';
import 'package:merogames/widgets/general-elevated-button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  LoginController _loginStateController;

  @override
  Widget build(BuildContext context) {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _loginStateController = Provider.of<LoginController>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: _loginStateController.showLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                          onTap: () {
                            _loginStateController.onClickBackBtn(context);
                          },
                          child: _backBtn(context)),

                     Image.asset('assets/login.jpg',scale: 4,),
                     SizedBox(
                        height: 20,
                      ),
                      _titleDesc(context),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextfield(
                        controller: _emailController,
                        label: 'Enter Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextfield(
                        obscureText: true,
                        controller: _passwordController,
                        label: 'Enter Password',
                        icon: Icons.lock_outline,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _loginStateController.loginResponseError == null
                          ? SizedBox()
                          : Text(
                              _loginStateController.loginResponseError,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    color: red,
                                  ),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      _generalBtn(context)
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _generalBtn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GeneralElevatedButton(
          label: 'Get Login',
          onPressed: () {
            _loginStateController.onClickSaveBtn(
              identity: _emailController.text,
              password: _passwordController.text,
              context: context,
            );
            // .then((response) {
            // print(response.sessionToken);
            // });
            // LoginResponse user = await loginUser(
            //     identity: _emailController.text,
            //     password: _passwordController.text);
            // print(user.sessionToken);
            // print(_emailController.text);
            // print(_passwordController.text);

            //  await  _loginStateController.onClickSaveBtn(
            //     context: context,
            //     identity: _emailController.text,
            //     password: _passwordController.text,
            //   );
          },
        ),
        SizedBox(
          height: 20,
        ),
        GeneralElevatedButton(
          bgColor: Colors.white,
          label: 'Create Account',
          onPressed: () {
            _loginStateController.onClickCreateAcc(context);
          },
        )
      ],
    );
  }

  Widget _backBtn(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.arrow_back),
        SizedBox(
          width: 3,
        ),
        Text(
          'Back',
          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 16),
        ),
      ],
    );
  }

  _titleDesc(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Keep Connected".toUpperCase(),
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 340,
          child: Text(
            'Enter your email and password to get access your account',
            // textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 16,
                  height: 1.6,
                ),
          ),
        )
      ],
    );
  }
}
