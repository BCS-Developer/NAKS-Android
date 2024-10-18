import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/providers/global_provider.dart';
import 'package:top_examer/providers/posts_provider.dart';
import 'package:top_examer/providers/profile_provider.dart';
import 'package:top_examer/ui/categories_page/categories_page.dart';
import 'package:top_examer/ui/matrimony/MatrimonyPage.dart';
import 'package:top_examer/ui/profile_page/profile_screen.dart';
import 'package:top_examer/ui/reels_page/reels_tab_page.dart';
import 'package:top_examer/utils/constants.dart';
import 'package:top_examer/utils/shared_preference_utils.dart';
import 'package:top_examer/utils/themes.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;

  const HomePage({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GlobalProvider globalProvider;
  late ProfileProvider profileProvider;
  late ColorScheme defaultColorScheme;
  @override
  void initState() {
    globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      defaultColorScheme = Theme.of(context).colorScheme;
      globalProvider.selectedTabIndex = widget.initialIndex;
      globalProvider.isToolbarVisible = (globalProvider.selectedTabIndex == 0);

      bool? isFromAppLink = await SharedPreferenceUtils.getBoolFromSp(
          AppConstants.IS_APPLINK_NAVIGATED);
      if (isFromAppLink == true) {
        //app opened by link
        globalProvider.selectedTabIndex = 1; // show reels tab
        //clear all
        SharedPreferenceUtils.removeStringFromSP(
            AppConstants.IS_APPLINK_NAVIGATED);
        SharedPreferenceUtils.removeStringFromSP(AppConstants.POST_ID);
        SharedPreferenceUtils.removeStringFromSP(AppConstants.CATEGORY_ID);
      }
    });
    super.initState();
  }

  Widget _buildIcon(
      String assetName, int index, GlobalProvider globalProvider) {
    return SvgPicture.asset(
      assetName,
      width: 24.39,
      height: 24.39,
      color: globalProvider.selectedTabIndex == index
          ? Themes.bottombarselectedicon
          : Themes.bottombarunselectedicon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Consumer<GlobalProvider>(
      builder: (context, globalProvider, child) => Scaffold(
        extendBody: true,
        appBar: globalProvider.selectedTabIndex == 1
            ? AppBar(
                backgroundColor: defaultColorScheme.error,
                leading: null,
                automaticallyImplyLeading: false,
                title: const Text('Reels', style: Themes.appBarHeader),
              )
            : globalProvider.isToolbarVisible
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(100.0),
                    child: AppBar(
                      backgroundColor: defaultColorScheme.error,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      toolbarHeight: 100,
                      leading: null,
                      automaticallyImplyLeading: false,
                      title: FutureBuilder(
                        future: profileProvider.getProfileDetails(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting &&
                              profileProvider.profileDetailsModel == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Text("");
                          } else {
                            return Consumer<ProfileProvider>(
                              builder: (context, profileProvider, child) {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          style: Themes.HomePageText,
                                          children: [
                                            const TextSpan(
                                              text: 'Hi, ',
                                            ),
                                            TextSpan(
                                              text: '${profileProvider.name} ,',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Themes.red_color),
                                            ),
                                            const TextSpan(
                                              text: ' Welcome to ',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 16.0),
                                      child: Text(AppConstants.appName,
                                          style: Themes.homepageAppname),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  )
                : PreferredSize(
                    preferredSize: const Size.fromHeight(0), // Set height to 0
                    child: AppBar(
                      backgroundColor: defaultColorScheme.error,
                    ), // Empty container
                  ),
        body: SafeArea(
          child: Container(
            color: colorScheme.onSurface,
            child: Center(
              child: IndexedStack(
                  index: globalProvider.selectedTabIndex,
                  children: [
                    CategoriesPage(false, key: globalProvider.pageKeys[0]),
                    ChangeNotifierProvider<PostsProvider>(
                      create: (_) => PostsProvider(),
                      child: ReelsPage(
                        key: globalProvider.pageKeys[1],
                      ),
                    ),
                    MatrimoniePage(),
                    ProfileScreen(key: globalProvider.pageKeys[3]),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Themes.bottomNavigationBar,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _buildIcon('assets/home.svg', 0, globalProvider),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon('assets/book.svg', 1, globalProvider),
                label: 'Articles',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon('assets/wedding.svg', 2, globalProvider),
                label: 'matrimony',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon('assets/settings.svg', 3, globalProvider),
                label: 'Settings',
              ),
            ],
            selectedLabelStyle: const TextStyle(
                fontFamily: Themes.fontFamily,
                fontSize: 10,
                fontWeight: FontWeight.w400),
            unselectedLabelStyle: const TextStyle(
                fontFamily: Themes.fontFamily,
                fontSize: 10,
                fontWeight: FontWeight.w400),
            currentIndex: globalProvider.selectedTabIndex,
            selectedItemColor: Themes.bottombarselectedicon,
            unselectedItemColor: Themes.bottombarunselectedicon,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    var globalProvider = context.read<GlobalProvider>();
    globalProvider.selectedCategoryId = 0;
    globalProvider.isToolbarVisible = (index == 0);
    globalProvider.selectedTabIndex = index;
  }
}
