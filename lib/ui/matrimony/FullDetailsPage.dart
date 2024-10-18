// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_examer/utils/themes.dart';

class FullDetailsPage extends StatelessWidget {
  final SizedBox _verticalSpacing = const SizedBox(height: 8);
  final TextStyle _textStyle14 = const TextStyle(
    fontFamily: Themes.fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  final TextStyle _textStyle18 = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, fontFamily: Themes.fontFamily);
  final String name;
  final String description;
  final String gender;
  final String job;
  final int age;
  final String visa;
  final String DOB;
  final String number;
  final String imagePath;
  final String TimeofBirth;
  final String PlaceofBirth;
  final String Nationality;
  final String Religion;
  final String Color;
  final String EducationQualification;
  final String Company;
  final String Designation;
  final String AnnualSalary;
  final String USAAddress;
  final String MaritalStatus;
  final String EmailAddress;
  final String Rashinakshatram;
  final String Gothram;
  final String FatherName;
  final String FatherOccupation;
  final int FatherContactNumber;
  final String MotherName;
  final String MotherOccupation;
  final int MotherContactNumber;
  final String SiblingName;
  final int SiblingContactNumber;
  final String NativePlaceAddress;
  final String LookingFor;
  final String PartnerPreferences;

  FullDetailsPage({
    required this.name,
    required this.description,
    required this.gender,
    required this.job,
    required this.age,
    required this.number,
    required this.visa,
    required this.imagePath,
    required this.DOB,
    required this.TimeofBirth,
    required this.PlaceofBirth,
    required this.Nationality,
    required this.Religion,
    required this.Color,
    required this.EducationQualification,
    required this.Company,
    required this.Designation,
    required this.AnnualSalary,
    required this.USAAddress,
    required this.MaritalStatus,
    required this.EmailAddress,
    required this.Rashinakshatram,
    required this.Gothram,
    required this.FatherName,
    required this.FatherOccupation,
    required this.FatherContactNumber,
    required this.MotherName,
    required this.MotherOccupation,
    required this.MotherContactNumber,
    required this.SiblingName,
    required this.SiblingContactNumber,
    required this.NativePlaceAddress,
    required this.LookingFor,
    required this.PartnerPreferences,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        // backgroundColor: Color.fromARGB(255, 235, 213, 19),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/arrow_back.svg',
            width: 10.45,
            height: 18.96,
            color: Themes.red_color,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: const IconThemeData(
          color: Themes.red_color,
        ),
        title: const Text(
          "Full Details",
          style: Themes.appBarHeader,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section (30% Flex, Full-Width Display)
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FullScreenImage(imagePath: imagePath);
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.23,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Scrollable Details Section
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: Themes.fontFamily,
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Description: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: description,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Gender: ',
                                        style: _textStyle18,
                                      ),
                                      TextSpan(
                                        text: gender,
                                        style: _textStyle14,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 17),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Age: ',
                                        style: _textStyle18,
                                      ),
                                      TextSpan(
                                        text: '$age',
                                        style: _textStyle14,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 17),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Visa: ',
                                        style: _textStyle18,
                                      ),
                                      TextSpan(
                                        text: visa,
                                        style: _textStyle14,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Job: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: job,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Phone: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: number,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'DOB: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: DOB,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Time of Birth: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: TimeofBirth,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Place of Birth: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: PlaceofBirth,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Nationality: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: Nationality,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Religion: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: Religion,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Color: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: Color,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Education Qualification: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: EducationQualification,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Company: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: Company,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Designation: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: Designation,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Annual Salary: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: AnnualSalary,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'USA Address: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: USAAddress,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Marital Status: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: MaritalStatus,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Email Address: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: EmailAddress,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Rashinakshatram: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: Rashinakshatram,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Gothram: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: Gothram,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Father Name: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: FatherName,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Father Occupation: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: FatherOccupation,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Father Contact Number: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: '$FatherContactNumber',
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Mother Name: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: MotherName,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Mother Occupation: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: MotherOccupation,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Mother Contact Number: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: '$MotherContactNumber',
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Sibling Name: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: SiblingName,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Sibling Contact Number: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: '$SiblingContactNumber',
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Native Place Address: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: NativePlaceAddress,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Looking For: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: LookingFor,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Partner Preferences: ',
                                style: _textStyle18,
                              ),
                              TextSpan(
                                text: PartnerPreferences,
                                style: _textStyle14,
                              ),
                            ],
                          ),
                        ),
                        _verticalSpacing,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//ANIMATION EFFERE FOR CLOSING THE IMAGE...
class FullScreenImage extends StatefulWidget {
  final String imagePath;

  FullScreenImage({required this.imagePath});

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _offsetAnimation = Tween<Offset>(
            begin: Offset.zero, end: const Offset(0, 1))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    // If user drags down or up significantly, close the dialog
    if (details.primaryDelta! > 10) {
      _controller.forward().then((_) => Navigator.pop(context));
    } else if (details.primaryDelta! < -10) {
      _controller.forward().then((_) => Navigator.pop(context));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _onVerticalDragUpdate,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: InteractiveViewer(
              panEnabled: true, // Enables panning
              boundaryMargin: const EdgeInsets.all(
                  80), // Allow more panning space in all directions
              minScale: 0.8, // Allow zoom out a bit
              maxScale: 4.0, // Zoom in up to 4 times
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover, // Fit image in the screen
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
