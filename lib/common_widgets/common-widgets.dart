import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:top_examer/models/AppUpdateResponseModel.dart';
import 'package:top_examer/utils/themes.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonWidgets {
  Widget circularProgressIndicator() {
    return Center(
      child: Transform.scale(
        scale: 1,
        child: CircularProgressIndicator(),
      ),
    );
  }

  TextStyle titleFontStyle() {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  }

  TextStyle regularFontStyle() {
    return TextStyle();
  }

  Future<void> openWeb(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  showSnackbar(String message, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showUpdateDialog(AppUpdateResponseModel model, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title:   Text("App Update",  style: TextStyle(color: colorScheme.onSurface),),
        content:   Text(
            "An update is now available for our app! 🚀 Please download the latest version to enjoy new features and improvements. "
                "Tap 'Update' to get the latest version now.", style: TextStyle(color: colorScheme.onSurfaceVariant),),
        actions: <Widget>[
          Visibility(
            visible: model.softUpdate == "1",
            child: TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                child:   Text("Cancel", style: TextStyle(
                  color: colorScheme.primary,
                  fontFamily: Themes.fontFamily,
                ),),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              openStore();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child:   Text("Update", style: TextStyle(
                color: colorScheme.primary,
                fontFamily: Themes.fontFamily,
              ),),
            ),
          ),
        ],
      ),
    );
  }

  openMessageDialogue(String message, bool isEnableCancelBtn,
      bool isEnableOkBtn, Function listener, BuildContext context) async {
    final colorScheme = Theme.of(context).colorScheme;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title:   Text(
          "Alert",
          style: TextStyle(
            fontWeight: FontWeight.bold, fontFamily: Themes.fontFamily,  color: colorScheme.onSurface,),
        ),
        content: Text(
          message,
          style: TextStyle(fontFamily: Themes.fontFamily, color: colorScheme.onSurfaceVariant,),
        ),
        actions: <Widget>[
          Visibility(
            visible: isEnableCancelBtn,
            child: TextButton(
              onPressed: () {
                listener(false);
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                child:   Text(
                  "Cancel",
                  style: TextStyle(fontFamily: Themes.fontFamily,  color: colorScheme.primary,),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              listener(true);
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child:   Text(
                "Ok",
                style: TextStyle(fontFamily: Themes.fontFamily, color: colorScheme.primary,),
              ),
            ),
          ),
        ],
      ),
    );
  }

  openStore() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = (await PackageInfo.fromPlatform()).packageName;

      final url = Uri.parse(
        Platform.isAndroid
            ? "market://details?id=$appId"
            : "https://apps.apple.com/app/id$appId",
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
