import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/models/category_model.dart';
import 'package:top_examer/utils/themes.dart';

import '../../providers/categories_provider.dart';

class LanguageSelectionWidget extends StatelessWidget {
  const LanguageSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var provider = Provider.of<CategoriesProvider>(context, listen: false);

    List<ValueItem<Languages>> languagesValuesList = [];
    ValueItem<Languages>? englishLanguageItem;
    if (provider?.model?.languages != null) {
      for (var item in provider.model!.languages ?? <ValueItem<Languages>>[]) {
        if (item != null) {
          ValueItem<Languages> valueItem =
              ValueItem(label: (item as Languages).language ?? "", value: item);
          languagesValuesList.add(valueItem);

          if (valueItem.label.toLowerCase() == 'english') {
            englishLanguageItem = valueItem;
          }
        }
      }
    }
    // Ensure "English" is always selected
    if (englishLanguageItem != null &&
        !provider.selectedLanguages.contains(englishLanguageItem)) {
      provider.selectedLanguages.add(englishLanguageItem);
    }

    return Card(
      surfaceTintColor:  colorScheme.surface,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child:
                    Text("Select Languages", style: Themes.MenuTitleTextStyle),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: MultiSelectDropDown<Languages>(
                onOptionSelected: (List<ValueItem<Languages>> selectedOptions) {
                  // Ensure English is always in the selected options and remove any duplicates
                  if (englishLanguageItem != null) {
                    selectedOptions.removeWhere(
                        (item) => item.label.toLowerCase() == 'english');
                    selectedOptions.add(englishLanguageItem);
                  }
                  provider.selectedLanguages = selectedOptions;
                },
                options: languagesValuesList,
                selectedOptions: provider.selectedLanguages,
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(
                    wrapType: WrapType.wrap,
                    backgroundColor: Color.fromRGBO(248, 156, 28, 1)),
                dropdownHeight: 300,
                optionTextStyle: const  TextStyle(
                  fontFamily: Themes.fontFamily,
                  fontSize: 14, color: Themes.black_color,
                ),
                selectedOptionIcon:   Icon(
                  Icons.check_circle, color: colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
