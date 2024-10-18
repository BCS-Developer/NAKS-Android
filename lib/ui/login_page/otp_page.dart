import 'package:flutter/material.dart';

import 'otp_widget.dart';

class VerifyOTPPage extends StatelessWidget {
  const VerifyOTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: OTPWidget(otp: '',),
        ),
      ),
    ));
  }
}
