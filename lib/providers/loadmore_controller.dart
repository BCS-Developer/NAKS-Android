// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LoadMoreController with ChangeNotifier{

  final String _name = "he";
  String get name => _name;

  // At the beginning, we fetch the first 20 posts
  int _page = 0;
  int get page => _page;

  void increamentPageCount(){
    this._page += 1;
  }

  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 20;
  int get limit => _limit;

  // There is next page or not
  bool _hasNextPage = true;
  bool get hasNextPage => _hasNextPage;

  void setHasNextPage(bool status){
    this._hasNextPage = status;
    notifyListeners();
  }

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;
  bool get isFirstLoadRunning => _isFirstLoadRunning;

  void setIsFirstLoadRunning(bool status){
    this._isFirstLoadRunning = status;
    notifyListeners();
  }

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;
  bool get isLoadMoreRunning => _isLoadMoreRunning;

  void setIsLoadMoreRunning(bool status){
    this._isLoadMoreRunning = status;
    notifyListeners();
  }


  bool loadMore(double contollerPosition)  {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        //_controller.position.extentAfter < 300) {
        contollerPosition < 300) {

      return true;

    }

    return false;
  }

}