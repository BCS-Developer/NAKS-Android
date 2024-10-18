// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/common_widgets/common-widgets.dart';
import 'package:top_examer/models/LanguagesModel.dart';
import 'package:top_examer/providers/profile_provider.dart';
import 'package:top_examer/ui/categories_page/select_categories_page.dart';
import 'package:top_examer/utils/constants.dart';
import 'package:top_examer/utils/shared_preference_utils.dart';

import '../../providers/verify_otp_provider.dart';
import '../../utils/helper.dart';
import '../../utils/themes.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.isFirstTime,
    required this.isEditEnabled,
  });

  final bool isFirstTime;
  final bool isEditEnabled;

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? selectedGender;
  Message? selectedLanguage;
  DateTime? selectedDate;
  var profileProvider;
  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      profileProvider.editModeEnabled = widget.isEditEnabled;
      try {
        await profileProvider.getLanguages(context);
        if (widget.isFirstTime) {
          //populate the mobile number from login page.
          numbercontroller.text = (await SharedPreferenceUtils.getStringFromSp(
              AppConstants.MOBILE_NUMBER))!;
        } else {
          var result = await profileProvider.getProfileDetails(context);
          if (result) {
            nameController.text =
                profileProvider.profileDetailsModel?.message?.fullname ?? '';
            emailController.text =
                profileProvider.profileDetailsModel?.message?.email ?? '';
            numbercontroller.text =
                profileProvider.profileDetailsModel?.message?.phonenumber ?? '';
            selectedGender = capitalizeFirstLetter(profileProvider
                    .profileDetailsModel?.message?.gender
                    ?.toLowerCase() ??
                'male');
            if (profileProvider.profileDetailsModel?.message?.dob != null) {
              DateTime dateTime = DateTime.parse(
                  profileProvider?.profileDetailsModel?.message?.dob ?? '');
              selectedDate = dateTime;
            }
          }
        }

        //for first time user the default language selected should be English
        selectedLanguage = profileProvider.languagesModel?.message?.firstWhere(
            (m) => m.language?.toLowerCase() == "English".toLowerCase());
      } catch (e) {}
      //}
      if (selectedDate != null) {
        birthDateController.text =
            DateFormat('yyyy-MM-dd').format(selectedDate!);
      }
    });
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numbercontroller = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> genders = [
    'Male'.toString(),
    'Female'.toString(),
    'Not disclose'.toString(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return widget.isFirstTime
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: colorScheme.onError,
              title: const Text(
                'Registration',
                style: Themes.appBarHeader,
              ),
              automaticallyImplyLeading: false,
              leading: null,
              actions: [
                GestureDetector(
                  onTap: () async {
                    updateProfile(widget.isFirstTime);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text('DONE', style: Themes.appbarDoneButton),
                  ),
                )
              ],
            ),
            body: profileBody(context, colorScheme),
          )
        : profileBody(context, colorScheme);
  }

  bool validateForm() {
    // Add your form validation logic here
    return true;
  }

  updateProfile(bool isFirstTime) async {
    var userProfileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      userProfileProvider.name = nameController.text;
      userProfileProvider.phone = numbercontroller.text;
      userProfileProvider.gender = selectedGender;
      userProfileProvider.email = emailController.text;
      userProfileProvider.dob = selectedDate != null
          ? DateFormat('yyyyMMdd').format(selectedDate!)
          : null;
      if (selectedDate == null ||
          DateTime.now().difference(selectedDate!).inDays < 365 * 13) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppConstants.ageEligiblity)),
        );
        return;
      }
      var result =
          await userProfileProvider.signUpOrupdateProfile(isFirstTime, context);
      if (result) {
        if (isFirstTime) {
          VerifyOTPProvider verifyOTPProvider =
              Provider.of<VerifyOTPProvider>(context, listen: false);
          await SharedPreferenceUtils.saveStringToSP(AppConstants.USER_ID,
              verifyOTPProvider?.verifyOtpModel?.result?.userId ?? "");
          //appears after login authentication, hence navigate to category selection page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => SelectCategories(),
            ),
          );
        } else {
          //disable edit mode.
          userProfileProvider.editModeEnabled = false;
        }
      }
    }
  }

  Widget profileBody(BuildContext context, ColorScheme colorScheme) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<ProfileProvider>(
      builder: (context, model, child) => model.isLoading
          ? Padding(
              padding: EdgeInsets.only(
                  top: model.editModeEnabled ? 8 : screenHeight / 2.5),
              child: new CommonWidgets().circularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Visibility(
                          visible: !widget.isFirstTime,
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 16.0),
                              child: Text("Profile",
                                  style: Themes.MenuTitleTextStyle),
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                style: const TextStyle(
                                    fontFamily: Themes.fontFamily,
                                    fontSize: 16),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z]")),
                                ],
                                enabled: model.editModeEnabled,
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    color: model.editModeEnabled
                                        ? colorScheme.onSurface
                                        : colorScheme.onSurface
                                            .withOpacity(0.3),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: colorScheme
                                          .onSurface, // Default border color for outline border
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: colorScheme
                                          .onSurface, // Set the border color for enabled state
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: colorScheme
                                          .secondary, // Set the border color for focused state
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  } else if (value.length < 3) {
                                    return 'Name must be at least 3 characters long';
                                  } else if (!RegExp(
                                          r'^[A-Z][a-zA-Z]*(\.[a-zA-Z]+)?$')
                                      .hasMatch(value)) {
                                    if (!RegExp(r'^[A-Z]').hasMatch(value)) {
                                      return 'First letter must be capital';
                                    } else {
                                      return 'Only alphabets are allowed';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                style: const TextStyle(
                                    fontFamily: Themes.fontFamily,
                                    fontSize: 16),
                                enabled: widget.isFirstTime,
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: widget.isFirstTime
                                        ? colorScheme.onSurface
                                        : colorScheme.onSurface
                                            .withOpacity(0.3),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: widget.isFirstTime
                                          ? colorScheme.onSurface
                                          : colorScheme.onSurface
                                              .withOpacity(0.3),
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: widget.isFirstTime
                                          ? colorScheme.onSurface
                                          : colorScheme.onSurface
                                              .withOpacity(0.3),
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: colorScheme
                                          .secondary, // Set the border color for focused state
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'Please enter your email';
                                //   } else if (!RegExp(
                                //           r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                //       .hasMatch(value)) {
                                //     return 'Please enter a valid email address';
                                //   }
                                //   return null;
                                // },

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!value.contains('@')) {
                                    // return 'Email must contain the @ symbol';
                                    return 'Invalid email format.';
                                  } else if (value.indexOf('@') !=
                                      value.lastIndexOf('@')) {
                                    // return 'Email must contain only one @ symbol';
                                    return 'Invalid email format.';
                                  } else {
                                    final domainPart = value.split('@')[1];
                                    final dotCount =
                                        domainPart.split('.').length - 1;
                                    if (dotCount != 1) {
                                      // return 'Email domain must contain exactly one dot.';
                                      return 'Invalid email format.';
                                    } else if (!RegExp(
                                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                        .hasMatch(value)) {
                                      return 'Invalid email format.';
                                    } else if (!value.endsWith('.com')) {
                                      // return 'Email must end with .com';
                                      return 'Invalid email format.';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                style: const TextStyle(
                                    fontFamily: Themes.fontFamily,
                                    fontSize: 16),
                                enabled: model.editModeEnabled,
                                readOnly: true,
                                controller: birthDateController,
                                decoration: InputDecoration(
                                  labelText: 'Date of Birth',
                                  labelStyle: TextStyle(
                                    color: model.editModeEnabled
                                        ? colorScheme.onSurface
                                        : colorScheme.onSurface
                                            .withOpacity(0.3),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: colorScheme
                                          .onSurface, // Default border color for outline border
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: colorScheme
                                          .onSurface, // Set the border color for enabled state
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: colorScheme
                                          .secondary, // Set the border color for focused state
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  final DateTime currentDate = DateTime.now();
                                  final DateTime initialDate =
                                      selectedDate ?? currentDate;

                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: initialDate,
                                    firstDate: DateTime(currentDate.year -
                                        1000), // Display all years from 1000 years ago
                                    lastDate: currentDate,
                                  );
                                  if (pickedDate != null &&
                                      pickedDate != selectedDate) {
                                    setState(() {
                                      selectedDate = pickedDate;
                                      birthDateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(selectedDate!);
                                    });
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                    fontFamily: Themes.fontFamily,
                                    fontSize: 16),
                                enabled: false,
                                controller: numbercontroller,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  prefixText: 'IND +91  ',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Circular border radius
                                    borderSide: const BorderSide(
                                      color: Themes.focusedBorderColor,
                                      width:
                                          2.0, // Increase the thickness of the border
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your mobile number';
                                  } else if (value.length != 10) {
                                    return 'Invalid mobile number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  children: [
                                    // First row containing the first two genders
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.center,
                                      children: genders.take(2).map((gender) {
                                        final isSelected =
                                            selectedGender == gender;
                                        return SizedBox(
                                          width:
                                              130, // Adjust the width of the SizedBox
                                          child: GestureDetector(
                                            onTap: () {
                                              if (model.editModeEnabled) {
                                                setState(() {
                                                  selectedGender = gender;
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 45,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                  color: model.editModeEnabled
                                                      ? isSelected
                                                          ? colorScheme
                                                              .error // Selected border color
                                                          : colorScheme
                                                              .onSurface // Unselected border color
                                                      : colorScheme.onSurface
                                                          .withOpacity(
                                                              0.3), // Disabled border color
                                                  width: isSelected
                                                      ? 2
                                                      : 1, // Adjust the border width
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        30, // Adjust the width as needed
                                                    child: Radio<String>(
                                                        value: gender,
                                                        groupValue:
                                                            selectedGender,
                                                        onChanged: model
                                                                .editModeEnabled
                                                            ? (value) {
                                                                setState(() {
                                                                  selectedGender =
                                                                      value!;
                                                                });
                                                              }
                                                            : null,
                                                        activeColor:
                                                            colorScheme.error),
                                                  ),
                                                  Text(
                                                    gender,
                                                    style: TextStyle(
                                                        color: model
                                                                .editModeEnabled
                                                            ? colorScheme
                                                                .onSurface
                                                            : colorScheme
                                                                .onSurface
                                                                .withOpacity(
                                                                    0.3),
                                                        fontFamily:
                                                            Themes.fontFamily,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // Second row containing the third gender
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.center,
                                      children: genders.skip(2).map((gender) {
                                        final isSelected =
                                            selectedGender == gender;
                                        return SizedBox(
                                          width:
                                              150, // Adjust the width of the SizedBox
                                          child: GestureDetector(
                                            onTap: () {
                                              if (model.editModeEnabled) {
                                                setState(() {
                                                  selectedGender = gender;
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 45,
                                              // margin:
                                              //     const EdgeInsets.symmetric(
                                              //         horizontal: 8.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                  color: model.editModeEnabled
                                                      ? isSelected
                                                          ? colorScheme
                                                              .error // Selected border color
                                                          : colorScheme
                                                              .onSurface // Unselected border color
                                                      : colorScheme.onSurface
                                                          .withOpacity(
                                                              0.3), // Disabled border color
                                                  width: isSelected
                                                      ? 2
                                                      : 1, // Adjust the border width
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        30, // Adjust the width as needed
                                                    child: Radio<String>(
                                                        value: gender,
                                                        groupValue:
                                                            selectedGender,
                                                        onChanged: model
                                                                .editModeEnabled
                                                            ? (value) {
                                                                setState(() {
                                                                  selectedGender =
                                                                      value!;
                                                                });
                                                              }
                                                            : null,
                                                        activeColor:
                                                            colorScheme.error),
                                                  ),
                                                  Text(
                                                    gender,
                                                    style: TextStyle(
                                                        color: model
                                                                .editModeEnabled
                                                            ? colorScheme
                                                                .onSurface
                                                            : colorScheme
                                                                .onSurface
                                                                .withOpacity(
                                                                    0.3),
                                                        fontFamily:
                                                            Themes.fontFamily,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: !widget.isFirstTime &&
                                    model.editModeEnabled,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(255, 235, 213, 19),
                                          minimumSize: const Size(327, 50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Adjust the circular border radius
                                          ),
                                          elevation: 10,
                                          shadowColor: Themes.brown_color),
                                      onPressed: () {
                                        updateProfile(widget.isFirstTime);
                                      },
                                      child: const Text('Save',
                                          style: Themes.savebuttonTextStyle),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
