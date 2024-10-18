import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:top_examer/common_widgets/common-widgets.dart';
import 'package:top_examer/ui/preference_selection/language_preferences_screen.dart';
import 'package:top_examer/utils/constants.dart';

class LanguageProvider extends ChangeNotifier {
  List<Language> _languages = [];

  List<Language> get languages => _languages;

  set languages(List<Language> value) {
    _languages = value;
    notifyListeners();
  }

  Future<void> fetchLanguages(BuildContext context) async {
    try {
      final url = Uri.https(
        AppConstants.baseUrl,
        AppConstants.apiUrl,
        {'key': AppConstants.getAllLanguages},
      );

      final response = await http
          .get(url)
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('message')) {
          languages = List<Map<String, dynamic>>.from(data['message'])
              .map((json) => Language.fromJson(json))
              .toList();
          // Ensure English is always selected
          for (var lang in _languages) {
            if (lang.name.toLowerCase() == 'english') {
              lang.selected = true;
            }
          }
        } else {
          throw Exception('No language data found in the response');
        }
      } else {
        throw Exception('Failed to load languages: ${response.statusCode}');
      }
    } catch (e) {
     new CommonWidgets().showSnackbar(AppConstants.unknownError, context);
    }
  }

  void updateLanguage(String name, bool selected) {
    final index = _languages.indexWhere((language) => language.name == name);
    if (index != -1 && name.toLowerCase() != 'english') {
      _languages[index].selected = selected;
      notifyListeners();
    }
  }
}
