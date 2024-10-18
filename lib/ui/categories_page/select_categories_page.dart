import 'package:flutter/material.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/common_widgets/common-widgets.dart';
import 'package:top_examer/models/category_model.dart';
import 'package:top_examer/providers/categories_provider.dart';
import 'package:top_examer/ui/categories_page/categories_page.dart';
import 'package:top_examer/utils/themes.dart';

import '../home_page/home_page.dart';

class SelectCategories extends StatefulWidget {
  SelectCategories({super.key});

  @override
  State<SelectCategories> createState() => _SelectCategorisState();
}

class _SelectCategorisState extends State<SelectCategories> {
  List<int> originalSelectedCategories = [];
  List<ValueItem<Languages>> originalSelectedLanguages = [];
  late CategoriesProvider provider;
  @override
  void initState() {
    provider = Provider.of<CategoriesProvider>(context, listen: false);
    originalSelectedCategories = provider.selectedCategories.toList();
    originalSelectedLanguages = provider.selectedLanguages.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.error,
        elevation: Themes.elevation,
        shadowColor: Theme.of(context).shadowColor,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Select Categories',
            style: Themes.appBarHeader,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () => {},
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () async {
                  if (provider.selectedLanguages.length < 1) {
                    CommonWidgets()
                        .showSnackbar("Please atleast 1 language.", context);
                  } else if (provider.selectedCategories.length < 3) {
                    CommonWidgets()
                        .showSnackbar("Please atleast 3 categories.", context);
                  } else if (provider.isCategoriesModified(
                              originalSelectedCategories,
                              provider.selectedCategories) ==
                          false &&
                      provider.isLanguagesModified(originalSelectedLanguages,
                              provider.selectedLanguages) ==
                          false) {
                    //no changes, go to home page
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  } else {
                    var result =
                        await provider.updateSelectedCategories(context);
                    if (result) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  }
                },
                child: const Text('DONE', style: Themes.appbarDoneButton),
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: CategoriesPage(true),
    );
  }
}
