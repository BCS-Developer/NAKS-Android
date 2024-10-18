import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/providers/language_provider.dart';
class Language {
  final String name;
  bool selected;

  Language({required this.name, required this.selected});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json['language'] ?? '',
      selected: false,
    );
  }
}
class LanguagePreferences extends StatefulWidget {
  const LanguagePreferences({Key? key}) : super(key: key);

  @override
  _LanguagePreferencesState createState() => _LanguagePreferencesState();
}

class _LanguagePreferencesState extends State<LanguagePreferences> {
  @override
  void initState() {
    super.initState();
    Provider.of<LanguageProvider>(context, listen: false).fetchLanguages(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Preferences'),
      ),
      body: Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) {
          var languages = languageProvider.languages;

          return languages.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    ...languages.map((language) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Card(
                          elevation: 4,
                          color: Colors.white,
                          child: ListTile(
                            title: CheckboxListTile(
                              title: Text(language.name),
                              value: language.selected,
                               onChanged:
                                  language.name.toLowerCase() == 'english'
                                      ? null // Disable checkbox for English
                                      : (bool? value) {
                                          languageProvider.updateLanguage(
                                              language.name, value ?? false);
                                        },
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 55),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              List<String> selectedLanguages = languages
                                  .where((language) => language.selected)
                                  .map((language) => language.name)
                                  .toList();
                              if (selectedLanguages.isNotEmpty) {
                                print(selectedLanguages);
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please select at least one language'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
