import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/common_widgets/common-widgets.dart';
import 'package:top_examer/models/AppUpdateResponseModel.dart';
import 'package:top_examer/providers/global_provider.dart';
import 'package:top_examer/ui/categories_page/banners.dart';
import 'package:top_examer/ui/profile_page/language_selection_widget.dart';
import 'package:top_examer/utils/analytics_engine.dart';

import '../../models/LanguagesModel.dart';
import '../../providers/categories_provider.dart';
import '../../utils/helper.dart';
import '../../utils/themes.dart';

class CategoriesPage extends StatefulWidget {
  final bool enableSelectMode; //if true hide the banners.
  CategoriesPage(this.enableSelectMode, {key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List cardColors = [
    Color.fromARGB(255, 191, 73, 18),
    Color.fromARGB(255, 8, 133, 4),
    Color.fromARGB(255, 151, 153, 8),
  ];
  Random random = new Random();
  bool _showFab = true;
  ScrollController _scrollController = new ScrollController();
  Message? selectedLanguage;
  late GlobalProvider globalProvider;
  var categoryProvider;

  @override
  void initState() {
    super.initState();
    globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    categoryProvider = Provider.of<CategoriesProvider>(context, listen: false);
    AnalyticsEngine.setCurrentScreen(widget.enableSelectMode
        ? "Select Categories Page"
        : "Categories Home Page");
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      getData();
    });
  }

  getData() async {
    AppUpdateResponseModel? result =
        await categoryProvider.checkApiUpdate(context);
    if (result != null &&
        (result.softUpdate == "1" || result.hardUpdate == "1")) {
      new CommonWidgets().showUpdateDialog(result, context);
    }
    await categoryProvider.getCategories(widget.enableSelectMode, context);
  }

  void showFloationButton() {
    setState(() {
      _showFab = true;
    });
  }

  void hideFloationButton() {
    setState(() {
      _showFab = false;
    });
  }

  void handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideFloationButton();
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloationButton();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
          child: model.isLoading
              ? Align(
                  alignment: Alignment.center,
                  child: CommonWidgets().circularProgressIndicator())
              : model?.model?.categories == null ||
                      model?.model?.categories?.isEmpty == true
                  ? const Center(
                      child: Text(
                        'No active categories & posts',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        !widget.enableSelectMode
                            ? const Banners()
                            : Container(),
                        !widget.enableSelectMode
                            ? Container()
                            : const LanguageSelectionWidget(),
                        !widget.enableSelectMode
                            ? Container()
                            : const Padding(
                                padding:
                                    EdgeInsets.only(top: 8, right: 8, left: 8),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Select Categories",
                                    style: Themes.MenuTitleTextStyle,
                                  ),
                                ),
                              ),
                        FutureBuilder(
                          future: isTablet(context),
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            return snapshot.data == true
                                ? Expanded(
                                    child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          2, // number of items in each row
                                      mainAxisSpacing:
                                          0.0, // spacing between rows
                                      crossAxisSpacing:
                                          8.0, // spacing between columns
                                      mainAxisExtent: 100,
                                    ),
                                    padding: const EdgeInsets.all(
                                        8.0), // padding around the grid
                                    itemCount: model?.model?.categories
                                        ?.length, // total number of items
                                    itemBuilder: (context, index) {
                                      return categoryView(model, index);
                                    },
                                  ))
                                : Expanded(
                                    child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: model?.model?.categories?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return categoryView(model, index);
                                    },
                                  ));
                          },
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  categoryView(CategoriesProvider model, int index) {
    final category = model?.model?.categories?[index];
    return GestureDetector(
      onTap: () {
        if (widget.enableSelectMode) {
          model.updateSelectedList(category?.id ?? "");
        } else {
          globalProvider.selectedCategoryId =
              isInteger(category?.id ?? "") ? int.parse(category?.id ?? "") : 0;
          globalProvider.selectedCategoryName = category?.id ?? "";
          globalProvider.isToolbarVisible = false;
          globalProvider.isRefreshPage = true;
          globalProvider.selectedTabIndex = 1;
          AnalyticsEngine.logCategoryClickEvent(
              globalProvider.selectedCategoryId.toString(),
              globalProvider.selectedCategoryId != 0
                  ? category?.categoryName ?? ""
                  : "");
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: [
            Card(
              elevation: 3,
              surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
              color: cardColors[index % cardColors.length],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: const AssetImage(
                      "assets/cat_mask.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 17, bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Visibility(
                                          visible: widget.enableSelectMode
                                              ? model.isCategorySelected(model
                                                      ?.model
                                                      ?.categories?[index]
                                                      ?.id ??
                                                  "")
                                              : model.model?.categories?[index]
                                                      .isSelected ==
                                                  1,
                                          child: SvgPicture.asset(
                                            "assets/tick.svg",
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                              category?.categoryName
                                                      ?.toString() ??
                                                  "",
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  Themes.homepageCategoryName),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 7,
                              // ),
                              const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5, left: 8),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        width:
                                            0, // You can control the width as needed
                                        height:
                                            0, // If required, adjust the height
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: SizedBox(
                                      width:
                                          0, // Same for Articles text, just keeping space
                                      height: 0,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: SvgPicture.asset('assets/cat_arrow.svg',
                                color: Themes.white_color),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
