import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/ui/login_page/getpostbycat.dart';
import 'package:top_examer/ui/login_page/otp_widget.dart';
import 'package:top_examer/ui/login_page/registration.dart';
import 'package:top_examer/utils/constants.dart';
import 'package:top_examer/utils/themes.dart';

import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../providers/send_otp_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _controller;
  String _mobile = "";

  @override
  Widget build(BuildContext context) {
    SendOTPProvider auth = Provider.of<SendOTPProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: colorScheme.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: colorScheme.background,
          elevation: 0,
        ),
        body: SafeArea(
            child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                      height: 121.86,
                      width: 101.5,
                      image: AssetImage('assets/aira_login.png')),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    'Welcome to ${AppConstants.appName} !',
                    style: Themes.loginpagetext,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  CustomTextField(
                    label: 'Enter Mobile Number',
                    hint: 'Mobile Number',
                    onChanged: (String value) {
                      _mobile = value;
                      debugPrint(_mobile);
                    },
                    height: 75.0,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    auth.error != null ? auth.error! : '',
                    style: TextStyle(
                        fontSize: 10.0,
                        color: colorScheme.error,
                        fontFamily: Themes.fontFamily),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomElevatedButton(
                    buttonText: auth.isLoading ? 'LOADING..' : 'LOGIN',
                    onPress: () {
                      if (_mobile.length < 10 || _mobile.isEmpty) {
                        auth.setError('Invalid mobile number.');
                        return;
                      } else {
                        auth.setError(null);
                      }
                      auth.sendOTP(_mobile).then(
                            (value) => {
                              if (value.status == 200)
                                {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(value.result!.otp ?? ""),
                                    duration: const Duration(seconds: 3),
                                  )),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OTPWidget(
                                          otp: value.result!.otp ?? ""),
                                    ),
                                  )
                                }
                            },
                          );
                    },
                  ),
                  SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Registration(),
                          ),
                        );
                      },
                      child: Text("Creat account")),
                      SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostsScreen(),
                          ),
                        );
                      },
                      child: Text("get post"))
                ],
              ),
            ),
          ),
        )));
  }
}
