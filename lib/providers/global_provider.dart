import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  int selectedCategoryId = 0;
  String selectedCategoryName = "";
  List<UniqueKey> pageKeys = List<UniqueKey>.generate(4, (_) => UniqueKey());
  String langId = ""; // Add langId here
  String notificationRoutePage = "";
  void setNotificationRoutePage(String routePage) {
    notificationRoutePage = routePage;
  }

  String? fcmToken = null;
  void setFcmToken(String token) {
    fcmToken = token;
  }

  // Method to update langId
  void setLangId(String id) {
    langId = id;
    notifyListeners();
  }

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;
  set selectedTabIndex(int index) {
    _selectedTabIndex = index;
    if (_isRefreshPage) {
      pageKeys[index] = UniqueKey();
      _isRefreshPage = false;
    }
    notifyListeners();
  }

  bool _isRefreshPage = false;
  bool get isRefreshPage => _isRefreshPage;
  set isRefreshPage(bool isRefresh) {
    _isRefreshPage = isRefresh;
    //notifyListeners();
  }

  bool _isToolbarVisible = true;
  bool get isToolbarVisible => _isToolbarVisible;
  set isToolbarVisible(bool isVisible) {
    _isToolbarVisible = isVisible;
    notifyListeners();
  }

  bool _editModeEnabled = true;
  bool get editModeEnabled => _editModeEnabled;
  set editModeEnabled(bool isVisible) {
    _editModeEnabled = isVisible;
    notifyListeners();
  }

  showHomeTab() {
    _isToolbarVisible = false;
    selectedTabIndex = 0;
  }

  set showReelsTab(int categoryId) {
    selectedCategoryId = categoryId;
    _isToolbarVisible = false;
    selectedTabIndex = 1;
  }

  showProfileTab() {
    _isToolbarVisible = false;
    selectedTabIndex = 3;
  }
}
