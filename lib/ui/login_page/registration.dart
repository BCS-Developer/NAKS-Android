import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_examer/common_widgets/custom_button.dart';
import 'package:top_examer/common_widgets/custom_text_field.dart';
import 'package:top_examer/common_widgets/custome_textformfield.dart';
import 'package:top_examer/utils/themes.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController posttitleController = TextEditingController();
  final TextEditingController JobIntruductionController =
      TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController DescriptionController = TextEditingController();
  final TextEditingController LocationController = TextEditingController();
  final TextEditingController SkillsController = TextEditingController();
  final TextEditingController JobTypeController = TextEditingController();
  final TextEditingController CompanyController = TextEditingController();
  final TextEditingController ExperienceController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController skillController = TextEditingController();
  String? gender;
  File? _profileImage;

  final SizedBox _verticalSpacing = SizedBox(height: 16);
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.error,
        title: const Text('Registration', style: Themes.appBarHeader),
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
                      Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "Personal details",
                                style: Themes.textfieldText
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: posttitleController,
                                label: 'First Name', hint: "enter first name",

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
                                controller: posttitleController,
                                label: 'Middle Name', hint: "enter middle name",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter your middle name';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: posttitleController,
                                label: 'Last Name', hint: "enter last name",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter your last name';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: EmailController,
                                label: "Email", hint: "Enter Email",

                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Email';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              CustomTextField(
                                counterText: "",
                                label: 'Enter Mobile Number',
                                hint: 'Mobile Number',
                                onChanged: (String value) {},
                                height: 75.0,
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: posttitleController,
                                label: 'Profession', hint: "enter Profession",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter your Profession';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      _verticalSpacing,
                      Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "U.S Address",
                                style: Themes.textfieldText
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'Address Line 1',
                                hint: "enter Address Line 1",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter Address Line 1';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'Address Line 2',
                                hint: "enter Address Line 2",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter Address Line 2';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'City',
                                hint: "enter City",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter City';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'State',
                                hint: "enter State",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter State';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'Zipcode',
                                hint: "enter Zipcode",

                                keyboardType: TextInputType.number,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter Zipcode';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      _verticalSpacing,
                      Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "Indian Address",
                                style: Themes.textfieldText
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'Indian Address',
                                hint: "enter Address",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter Address';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'District',
                                hint: "enter District",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter District';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'Mandal',
                                hint: "enter Mandal",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter Mandal';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'Town',
                                hint: "enter Town",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter Town';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'Referred By',
                                hint: "enter Referred By",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter Referred By';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      _verticalSpacing,
                      Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "Spouse Details",
                                style: Themes.textfieldText
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'First Name',
                                hint: "enter first name",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter first name';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'Last name',
                                hint: "enter Last name",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter Last name';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              CustomTextField(
                                counterText: "",
                                label: 'Enter Mobile Number',
                                hint: 'Mobile Number',
                                onChanged: (String value) {},
                                height: 75.0,
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'Email',
                                hint: "enter email address",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter email address';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'Profession',
                                hint: "enter Profession",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter Profession';
                                  }
                                  return null;
                                },
                              ),
                              _verticalSpacing,
                              textFormField(
                                controller: jobTitleController,
                                label: 'Speciality',
                                hint: "enter Speciality",

                                keyboardType: TextInputType.text,
                                onChanged: (value) {}, // Add onChanged
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter Speciality';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
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
                        content: Text("Job Posted successfully"),
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
