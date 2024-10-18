// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import 'loadmore_controller.dart';

class ListController extends LoadMoreController {
  final List _tasks = [];
  List get tasks => _tasks;

  void addTasks(List _tasks) {
    this._tasks.addAll(_tasks);
    notifyListeners();
  }

  getListApi(String baseUrl, double controllerPosition) async {
    //void _firstLoad() async {
    if (true) {
      page == 0 ? setIsFirstLoadRunning(true) : setIsLoadMoreRunning(true);

      try {
        // ignore: avoid_print
        print("url  : " + "$baseUrl?_page=$page&_limit=$limit");
        final res = await http
            .get(Uri.parse("$baseUrl?_page=$page&_limit=$limit"))
            .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
        var list = json.decode(res.body);
        increamentPageCount();
        if (list.isNotEmpty) {
          addTasks(list);
        } else {
          setHasNextPage(false);
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong');
        }
      }
      page - 1 == 0
          ? setIsFirstLoadRunning(false)
          : setIsLoadMoreRunning(false);
      //notifyListeners();
    }
  }
}
