import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_examer/common_widgets/custom_button.dart';
import 'package:top_examer/common_widgets/custom_text_field.dart';
import 'package:top_examer/common_widgets/custome_textformfield.dart';
import 'package:top_examer/utils/themes.dart';
import 'package:image_picker/image_picker.dart';

class Applyjjob extends StatefulWidget {
  const Applyjjob({super.key});

  @override
  State<Applyjjob> createState() => _ApplyjjobState();
}

class _ApplyjjobState extends State<Applyjjob> {
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
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  final SizedBox _verticalSpacing = SizedBox(height: 16);
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.error,
        title: const Text('Post Job', style: Themes.appBarHeader),
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
                        controller: posttitleController,
                        label: 'Post Title', hint: "enter name of Job",

                        keyboardType: TextInputType.text,
                        onChanged: (value) {}, // Add onChanged
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter name of Job';
                          }
                          return null;
                        },
                      ),
                      _verticalSpacing,
                      textFormField(
                        controller: JobIntruductionController,
                        label: "Job Intruduction",
                        hint: "Job Intruduction",
                        minLines: 3,
                        maxLines: 20,
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Job Intruduction';
                          }
                          return null;
                        },
                      ),
                      _verticalSpacing,
                      textFormField(
                        controller: jobTitleController,
                        label: 'job Title', hint: "enter title of Job",

                        keyboardType: TextInputType.text,
                        onChanged: (value) {}, // Add onChanged
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter title of Job';
                          }
                          return null;
                        },
                      ),
                      _verticalSpacing,
                      textFormField(
                        controller: DescriptionController,
                        label: "Description",
                        hint: "Description",
                        minLines: 3,
                        maxLines: 20,
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      _verticalSpacing,
                      textFormField(
                        controller: LocationController,
                        label: "Location", hint: "enter Job Location",

                        onChanged: (value) {}, // Add onChanged
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Job Location';
                          }
                          return null;
                        },
                      ),
                      _verticalSpacing,
                      textFormField(
                        controller: SkillsController,
                        label: "Skills", hint: "Skills",

                        onChanged: (value) {}, // Add onChanged
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Skills';
                          }
                          return null;
                        },
                      ),
                      _verticalSpacing,
                      textFormField(
                        controller: JobTypeController,
                        label: "Job Type", hint: "Job Type",

                        onChanged: (value) {}, // Add onChanged
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Job Type';
                          }
                          return null;
                        },
                      ),
                      _verticalSpacing,
                      textFormField(
                        controller: CompanyController,
                        label: "Company", hint: "Enter Company",

                        onChanged: (value) {}, // Add onChanged
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Company';
                          }
                          return null;
                        },
                      ),
                      _verticalSpacing,
                      textFormField(
                        controller: ExperienceController,
                        label: "Experience", hint: "Enter Experience",

                        onChanged: (value) {}, // Add onChanged
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Experience';
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
                        label: 'Enter Mobile Number',
                        hint: 'Mobile Number',
                        onChanged: (String value) {},
                        height: 75.0,
                      ),
                      _verticalSpacing,
                      Column(
                        children: [
                          if (_profileImage != null)
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: FileImage(_profileImage!),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                            ),
                          _verticalSpacing,
                          GestureDetector(
                              onTap: _pickImage,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minWidth: 100, minHeight: 50),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _pickImage();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.tertiary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                      _profileImage == null
                                          ? 'Add Image'
                                          : 'Change Image',
                                      style: Themes.loginbuttonTextStyle
                                          .copyWith(color: Colors.white)),
                                ),
                              )),
                        ],
                      ),
                      _verticalSpacing,
                      _verticalSpacing,
                    ],
                  ),
                ),
              ),
              CustomElevatedButton(
                buttonText: 'Submit',
                onPress: () {
                  //  if (_formKey.currentState?.validate() ?? false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Job Posted successfully"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context);
                  //}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
