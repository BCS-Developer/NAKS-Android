import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:top_examer/ui/TokenManager.dart';
import 'package:top_examer/utils/constants.dart';

bool isInteger(String s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
}

String capitalizeFirstLetter(String word) {
  if (word.isEmpty) {
    return word; // Return empty string if the word is empty
  }
  return word.substring(0, 1).toUpperCase() +
      word.substring(
          1); // Capitalize the first letter and concatenate with the rest of the word
}

shareArticle(String postId, String catId) {
  var jsonObj = {
    AppConstants.POST_ID: postId,
    AppConstants.CATEGORY_ID: catId,
  };
  String jsonString = jsonEncode(jsonObj);

  // Encrypt and convert to base64
  String encryptedText =
      xorEncryptDecrypt(jsonString, AppConstants.ENCRYPTION_KEY);
  String encryptedBase64Text = toBase64(encryptedText);

/*  // Convert from base64 and Decrypt
  String decryptedBase64Text = fromBase64(encryptedBase64Text);
  String decryptedText = xorEncryptDecrypt(decryptedBase64Text, key);
  print('Decrypted: $decryptedText');*/
//https://currentaffairs.topexamer.com/

  //ca://currentaffairs/applinks/$encryptedBase64Text

  print("""Applink : ca://currentaffairs/$encryptedBase64Text""");
/*  var msg = """Check out this interesting article I found!
 Click to open https://currentaffairs.topexamer.com?key=$encryptedBase64Text
 -
 You can view it in $AppConstants.appName app.
 If you don't have the app yet, you can download it from the Play Store.
  https://play.google.com/store/apps/details?id=com.apps.airanews""";*/

  var msg =
      """Check out this interesting article I found! Click to open https://currentaffairs.topexamer.com/news-details.php?nid=$postId
 -
You can view it in ${AppConstants.appName} app.
If you don't have the app yet, you can download it from the Play Store.
https://play.google.com/store/apps/details?id=com.apps.airanews""";

  Share.share(msg);
}

String xorEncryptDecrypt(String input, String key) {
  final keyRunes = key.runes.toList();
  int keyIndex = 0;
  final output = <int>[];

  for (int rune in input.runes) {
    output.add(rune ^ keyRunes[keyIndex]);
    keyIndex = (keyIndex + 1) % keyRunes.length;
  }

  return String.fromCharCodes(output);
}

String toBase64(String data) {
  return base64.encode(utf8.encode(data));
}

String fromBase64(String data) {
  return utf8.decode(base64.decode(data));
}

String removeAllHtmlTags(String htmlText) {
  return htmlText.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
}

Future<bool> isTablet(BuildContext context) async {

    if (Platform.isIOS) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      return iosInfo.model.toLowerCase() == "ipad";
    } else {
      // The equivalent of the "smallestWidth" qualifier on Android.
      var shortestSide = MediaQuery.of(context).size.shortestSide;

      // Determine if we should use mobile layout or not, 600 here is
      // a common breakpoint for a typical 7-inch tablet.
      return shortestSide > 600;
    }
  }
   Map<String, String> getHeaders() {
  String? tenetId = TokenManager.getTenetId();

  return {
    'Content-Type': 'application/json',
    if (tenetId != null) 'tenant_id': tenetId,
  };
}
