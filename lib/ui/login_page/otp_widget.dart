import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/providers/send_otp_provider.dart';
import 'package:top_examer/providers/verify_otp_provider.dart';
import 'package:top_examer/utils/constants.dart';
import 'package:top_examer/utils/shared_preference_utils.dart';
import 'package:top_examer/utils/themes.dart';

import '../../common_widgets/custom_button.dart';
import '../profile_page/edit_profile_screen.dart';

 class OTPWidget extends StatefulWidget {
  final String otp;

  const OTPWidget({Key? key, required this.otp}) : super(key: key);

  @override
  State<OTPWidget> createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  late TextEditingController pinController;
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController(text: widget.otp); // Removed auto allocation of OTP here
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    SendOTPProvider mobileNumberProvider =
        Provider.of<SendOTPProvider>(context);

    VerifyOTPProvider verifyOTPProvider =
        Provider.of<VerifyOTPProvider>(context);

    String otpText =
        "Enter the OTP sent to +${mobileNumberProvider.mobileNumber}";

    return Scaffold(
        backgroundColor: colorScheme.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: colorScheme.background,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/otp.svg",
                      height: 127.24,
                      width: 123.16,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      'Verify Your Number',
                      style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: Themes.fontFamily), textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      otpText,
                      style:  TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: Themes.fontFamily,color: colorScheme.onSurface),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: pinController,
                        focusNode: focusNode,
                        length: 6,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        defaultPinTheme: Themes.defaultPinTheme.copyWith(
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: colorScheme.onSurface,
                            ),
                          ),textStyle: TextStyle(
                          color: colorScheme.onSurface , fontSize: 20.0,
                        ),
                        ),
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 30,
                              height: 1,
                              color: colorScheme.primary,
                            ),
                          ],
                        ),
                        focusedPinTheme: Themes.defaultPinTheme.copyWith(
                          decoration:
                              Themes.defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border:
                            Border.all(   color: colorScheme.secondary),
                              ), textStyle: TextStyle(
                          color: colorScheme.onSurface,fontSize: 20.0,
                        ),
                        ),
                        submittedPinTheme: Themes.defaultPinTheme.copyWith(
                          decoration:
                              Themes.defaultPinTheme.decoration!.copyWith(
                            color: Themes.fillColor,
                            borderRadius: BorderRadius.circular(19),
                            border:
                            Border.all(color: colorScheme.secondary),
                              ), textStyle: TextStyle(
                          color: colorScheme.onSurface,fontSize: 20.0,
                        ),
                        ),
                        errorPinTheme: Themes.defaultPinTheme.copyBorderWith(
                          border: Border.all(color: colorScheme.error),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      verifyOTPProvider.error != null
                          ? verifyOTPProvider.error!
                          : '',
                      style:  TextStyle(
                          fontSize: 10.0,
                          color: colorScheme.error,
                          fontFamily: Themes.fontFamily),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    CustomElevatedButton(
                      buttonText: verifyOTPProvider.isLoading
                          ? 'LOADING..'
                          : 'VALIDATE',
                      onPress: () {
                        focusNode.unfocus();
                        if (formKey.currentState!.validate()) {
                          verifyOTPProvider
                              .verifyOTP(mobileNumberProvider.mobileNumber,
                                  pinController.text)
                              .then(
                                (value) => {
                                  if (value?.status == 200)
                                    {
                                      SharedPreferenceUtils.saveStringToSP(
                                          AppConstants.MOBILE_NUMBER,
                                          mobileNumberProvider.mobileNumber
                                                  .substring(2) ??
                                              ""),
                                      if (value?.result?.isVerified == "1" &&
                                          value?.result?.isRegistered == null)
                                        {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const EditProfileScreen(
                                                        isFirstTime: true,
                                                        isEditEnabled: true)),
                                          )
                                        }
                                      else if (value?.result?.isVerified ==
                                              "1" &&
                                          value?.result?.isRegistered == "1")
                                        {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/home',
                                              (Route<dynamic> route) => false)
                                        }
                                    }
                                  else
                                    {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                        AppConstants.unknownError,
                                        style: TextStyle(
                                            fontFamily: Themes.fontFamily),
                                      )))
                                    },
                                },
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}