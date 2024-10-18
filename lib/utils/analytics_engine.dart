import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsEngine {
  static final _instance = FirebaseAnalytics.instance;

  static void setCurrentScreen(String screenName) {
    _instance.logScreenView(
      screenName: screenName,
    );
  }

  static void logCategoryClickEvent(String catId, String catName) {
    _instance.logEvent(
        name: "Category_Click", parameters: {"id": catId, "name": catName});
  }

  static void logLike(bool status) {
    _instance.logEvent(
        name: "Like_Clicked", parameters: {"status": status.toString()});
  }

  static void shareClick(String reelId, String CatId) {
    _instance.logEvent(name: "Share_Clicked");
  }
}
