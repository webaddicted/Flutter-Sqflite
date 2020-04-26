import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersqflite/global/constant/color_constant.dart';
import 'package:fluttersqflite/global/constant/string_constant.dart';
import 'package:fluttersqflite/global/utils/validation_helper.dart';
import 'package:fluttersqflite/global/utils/widget_helper.dart';
import 'package:fluttersqflite/model/db/user_table.dart';
import 'package:fluttersqflite/view/login/home.dart';
import 'package:fluttersqflite/view/login/signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  String _emailId = '', _password = '';
  bool passwordVisible = false;

  BuildContext ctx;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
      builder: (context) => _crateUi(context),
    ));
  }

  Widget _crateUi(BuildContext context) {
    ctx = context;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 90),
                    Container(
                        width: 120, height: 120, child: loadImg("context", 0)),
                    SizedBox(height: 10),
                    getTxtAppColor(StrConstant.APP_NAME, 25, FontWeight.bold),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        border: OutlineInputBorder(
                            gapPadding: 30,
                            borderRadius: BorderRadius.circular(30)),
                        hintText: "Email id",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.grey),
                      ),
                      textInputAction: TextInputAction.next,
                      maxLength: 32,
                      validator: ValidationHelper.validateEmail,
                      onSaved: (String val) => _emailId = val,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        border: OutlineInputBorder(
                            gapPadding: 30,
                            borderRadius: BorderRadius.circular(30)),
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      ),
                      obscureText: !passwordVisible,
                      textInputAction: TextInputAction.done,
                      maxLength: 32,
                      validator: ValidationHelper.validatePassword,
                      onSaved: (String val) => _password = val,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              child: Text('Login'),
              onPressed: () {
                _submit();
              },
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 70, right: 70),
              color: ColorConstant.APP_COLOR,
              textColor: ColorConstant.WHITE_COLOR,
              shape: StadiumBorder(),
            ),
            SizedBox(height: 50),
            MaterialButton(
              child: getTxtColor(
                  'Signup', ColorConstant.APP_COLOR, 15, FontWeight.bold),
              onPressed: () {
                navigationPush(context, Signup());
              },
              padding: EdgeInsets.all(20),
              elevation: 2,
              shape: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: ColorConstant.APP_COLOR, width: 3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        isLoading = true;
        _checkUser();
      });
    }
  }

  void _checkUser() async {
    final userList = await UserTable.checkUserExist(_emailId);
    print(userList.toString());
    if (userList != null) {
      isLoading = false;
      navigationPush(ctx, Home());
    } else
      showSnackBar(ctx,
          'User not exist with $_emailId emailId.\nPlease signup with same emailId.');
    isLoading = false;
  }
}
