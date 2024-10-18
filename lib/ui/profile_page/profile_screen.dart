// ignore_for_file: use_super_parameters, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/common_widgets/common-widgets.dart';
import 'package:top_examer/providers/profile_provider.dart';
import 'package:top_examer/ui/login_page/login_page.dart';
import 'package:top_examer/utils/shared_preference_utils.dart';
import 'package:top_examer/utils/themes.dart';

import '../../utils/analytics_engine.dart';
import '../categories_page/select_categories_page.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileProvider userProfileProvider;

  @override
  void initState() {
    AnalyticsEngine.setCurrentScreen("Profile Settings Page");
    super.initState();
    userProfileProvider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      changeStatusBarColor();
    });
  }

  void changeStatusBarColor() {
    final colorScheme = Theme.of(context).colorScheme;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: colorScheme.error, // Change the color whatever you want
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.error,
        leading: null,
        automaticallyImplyLeading: false,
        title: const Text(
          'Settings',
          style: Themes.appBarHeader,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 18),
            child: IconButton(
              onPressed: () {
                Provider.of<ProfileProvider>(context, listen: false)
                    .editModeEnabled = true;
              },
              icon: SvgPicture.asset(
                height: 23.5,
                width: 19.77,
                'assets/edit.svg',
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 18),
            child: InkWell(
              onTap: () async {
                CommonWidgets().openMessageDialogue(
                  "Are you sure you want to logout?",
                  true,
                  true,
                  logOutCallBack,
                  context,
                );
              },
              child: SvgPicture.asset(
                height: 23.5,
                width: 23.5,
                'assets/logout.svg',
                color: colorScheme.onPrimary,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const EditProfileScreen(
              isFirstTime: false,
              isEditEnabled: false,
            ),
            Consumer<ProfileProvider>(
              builder: (context, model, child) => Visibility(
                visible: !model.isLoading,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SelectCategories(),
                        ),
                      );
                    },
                    child: Card(
                      surfaceTintColor: colorScheme.surface,
                      color: colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Update Preferences",
                                          style: Themes.MenuTitleTextStyle
                                              .copyWith(
                                            color: colorScheme.onSurface,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          width: 13,
                                          height: 13,
                                          'assets/cat_arrow.svg',
                                          color: colorScheme.onSurface,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "Customize your experience by selecting preferred categories and language, empowering tailored content consumption.",
                                        style: TextStyle(
                                          fontFamily: Themes.fontFamily,
                                          fontSize: 14.0,
                                          color: colorScheme.onSurface,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logOutCallBack(bool isLogout) async {
    if (isLogout) {
      await SharedPreferenceUtils.removeAllFromSP();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void showProfileUpdateMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Your profile is updated',
          style: TextStyle(color: Themes.red_color),
        ),
      ),
    );
  }
}
