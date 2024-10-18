import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_examer/common_widgets/custom_button.dart';
import 'package:top_examer/common_widgets/custom_text_field.dart';
import 'package:top_examer/common_widgets/custome_textformfield.dart';
import 'package:top_examer/utils/themes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobApplicationFormPage extends StatefulWidget {
  @override
  _JobApplicationFormPageState createState() => _JobApplicationFormPageState();
}

class _JobApplicationFormPageState extends State<JobApplicationFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController skillController = TextEditingController();
  String? gender;

  final SizedBox _verticalSpacing = SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.error,
        title: const Text('Job Application', style: Themes.appBarHeader),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/arrow_back.svg',
            width: 10.45,
            height: 18.96,
            color: Themes.back_arrow,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: const IconThemeData(
          color: Themes.back_arrow,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _verticalSpacing,
                      textFormField(
                        controller: firstNameController,
                        label: 'First Name', hint: "enter your first name",
                        height: 75,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {}, // Add onChanged
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter your first name';
                          }
                          return null;
                        },
                      ),
                      _verticalSpacing,
                      textFormField(
                        controller: lastNameController,
                        label: "Last Name", hint: "enter your last name",
                        height: 75,
                        onChanged: (value) {}, // Add onChanged
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      _verticalSpacing,
                      DropdownButtonFormField<String>(
                        value: gender,
                        decoration: InputDecoration(
                          labelText: "Gender",
                          labelStyle: TextStyle(
                            color: isDarkMode
                                ? colorScheme.onSurface
                                : colorScheme.onSurface,
                          ),
                          errorStyle: TextStyle(
                            color: colorScheme.onPrimary,
                            fontFamily: Themes.fontFamily,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: colorScheme.onSurface,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: colorScheme.secondary,
                              width: 1.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: colorScheme.onSurface,
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: colorScheme.onSurface,
                              width: 1.0,
                            ),
                          ),
                        ),
                        items:
                            ['Male', 'Female', 'Other'].map((String category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(
                              category,
                              style: TextStyle(color: colorScheme.onSurface),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select a gender' : null,
                      ),
                      _verticalSpacing,
                      _verticalSpacing,
                      textFormField(
                        controller: experienceController,
                        label: "Experience", hint: "Experience",
                        height: 75,
                        onChanged: (value) {}, // Add onChanged
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your experience';
                          }
                          return null;
                        },
                      ),
                      _verticalSpacing,
                      textFormField(
                        controller: skillController,
                        label: "Skills", hint: "Skills",
                        height: 75,
                        onChanged: (value) {}, // Add onChanged
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your skills';
                          }
                          return null;
                        },
                      ),
                      _verticalSpacing,
                      textFormField(
                        controller: emailController,
                        label: "Email", hint: "Enter your email address",
                        height: 75,
                        onChanged: (value) {}, // Add onChanged
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      _verticalSpacing,
                      CustomTextField(
                        label: 'Enter Mobile Number',
                        hint: 'Mobile Number',
                        onChanged: (String value) {},
                        height: 75.0,
                      ),
                      _verticalSpacing,
                      textFormField(
                        controller: descriptionController,
                        label: "Description", hint: "Description",
                        height: 75,

                        onChanged: (value) {}, // Add onChanged
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              CustomElevatedButton(
                buttonText: 'Submit',
                onPress: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Your profile was submitted successfully"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
