// util/api.dart

// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'constants.dart';

Future<List<Map<String, dynamic>>> getCategoryNames() async {
  try {
    final response = await http
        .get(Uri.parse(
            'https://currentaffairs.topexamer.com/api.php?key=getCategoryPostsCount'))
        .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
    if (response.statusCode == 200) {
      final dynamic jsonResponse = json.decode(response.body);

      // Check if the response is a map and contains the expected key
      if (jsonResponse is Map<String, dynamic> &&
          jsonResponse.containsKey('message')) {
        final List<dynamic> categoryList = jsonResponse['message'];
        final List<Map<String, dynamic>> categories = [];
        for (var category in categoryList) {
          if (category is Map<String, dynamic>) {
            // Check if each item is a map
            categories.add({
              'name': category['CategoryName'],
              'count': category['Posts'],
            });
          }
        }
        return categories;
      } else {
        throw Exception(
            'Invalid response format: Expected a map with a "message" key');
      }
    } else {
      print(
          'Failed to load category names. Status code: ${response.statusCode}');
      throw Exception('Failed to load category names');
    }
  } catch (e) {
    print('Error fetching category names: $e');
    rethrow;
  }
}
