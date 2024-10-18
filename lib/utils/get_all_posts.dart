// api_util.dart
// ignore_for_file: library_prefixes, avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:html/dom.dart' as htmlDom;
// html_util.dart
import 'package:html/parser.dart' as htmlParser;
import 'package:http/http.dart' as http;

import 'constants.dart';

class ApiUtil {
  static Future<List<Map<String, dynamic>>> fetchData(String key) async {
    try {
      final response = await http
          .get(Uri.parse(
              'https://currentaffairs.topexamer.com/api.php?key=getAllPosts'))
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
      ;

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody.containsKey('message')) {
          final dynamic message = responseBody['message'];
          if (message is List) {
            return List<Map<String, dynamic>>.from(message);
          } else if (message is Map<String, dynamic>) {
            return [message];
          } else {
            throw Exception('Invalid data format: $message');
          }
        } else {
          throw Exception('Missing "message" field in response');
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      rethrow;
    }
  }
}

class HtmlUtil {
  static String extractVisibleText(String htmlString) {
    var document = htmlParser.parse(htmlString);
    String text = '';

    void extractTextFromNode(htmlDom.Node node) {
      if (node.nodeType == htmlDom.Node.TEXT_NODE) {
        text += node.text!;
      } else if (node.nodeType == htmlDom.Node.ELEMENT_NODE) {
        var element = node as htmlDom.Element;
        if (element.localName == 'br') {
          text += '\n'; // Add line break for <br> tags
        }
        for (var childNode in element.nodes) {
          extractTextFromNode(childNode);
        }
      }
    }

    document.body!.nodes.forEach((node) {
      extractTextFromNode(node);
    });

    return text;
  }
}
