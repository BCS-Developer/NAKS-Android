// posts_provider.dart
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:top_examer/models/like_update_response.dart';
import 'package:top_examer/models/reel_model.dart';
import 'package:top_examer/providers/global_provider.dart';
import 'package:top_examer/utils/shared_preference_utils.dart';

import '../utils/constants.dart';
import '../utils/helper.dart';

class PostsProvider extends ChangeNotifier {
  bool isLoading = false;
  //ReelModel? reelModel;
  List<Message> reelsList = [];
  late LikeUpdateResponse updateLikeResponseModel;
  int page = 1;
  int limit = 20;
  bool noData = false;

  reset() {
    page = 1;
    limit = 20;
    noData = false;
    reelsList.clear();
  }

  Future<void> getReels(BuildContext context) async {
    if (noData) {
      return;
    }
    try {
      isLoading = (page == 1) ? true : false;
      notifyListeners();
      print("RRR getReels page : " + page.toString() + "  ");

      var params = null;
      var isNavigatedFromApplink = await SharedPreferenceUtils.getBoolFromSp(
          AppConstants.IS_APPLINK_NAVIGATED);

      var appLinkPostId =
          await SharedPreferenceUtils.getStringFromSp(AppConstants.POST_ID);
      var globalProvider = Provider.of<GlobalProvider>(context, listen: false);
      var userId =
          await SharedPreferenceUtils.getStringFromSp(AppConstants.USER_ID);
      params = {
        'key': AppConstants.getReelsUrl,
        'userId': userId,
        'page': page.toString(),
        'limit': limit.toString(),
        //'lang_id': globalProvider.langId
      };

      if (globalProvider.selectedCategoryId != 0) {
        params = {
          'key': AppConstants.getPostsByCategory,
          'userId': userId,
          'page': page.toString(),
          'limit': limit.toString(),
          'categoryId': globalProvider.selectedCategoryId.toString()
        };
      } else if (isNavigatedFromApplink == true) {
        params = {
          'key': AppConstants.sharedReel,
          'userId': userId,
          'postId': appLinkPostId,
          'page': page.toString(),
          'limit': limit.toString(),
        };
      }

      var url = Uri.https(AppConstants.baseUrl, AppConstants.apiUrl, params);
      print("getReels : params : " + params.toString());
      var response = await http
          .get(url)
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
      ;
      if (response.statusCode == 200) {
        page = page + 1;
        if (response.body.isNotEmpty) {
          print("getReels length 1 " + reelsList.length.toString());

          reelsList.addAll(
              ReelModelFromJson(response.body).message as Iterable<Message>);
          print("getReels reelsList " + response.body.toString());
          print("getReels length 2: " + reelsList.length.toString());
        } else {
          throw Exception(response.reasonPhrase);
        }
      } else if (response.statusCode == 404) {
        print("reels nodata " + reelsList.length.toString());
        noData = true;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  updateReelObject(Message? reelData) {
    Message reel =
        reelsList.firstWhere((obj) => obj.postId == reelData!.postId);
    if (reel != null) {
      reel.likes =
          updateLikeCount(reelData?.isLiked == "yes", reel!.likes!).toString();
      reel.isLiked = reelData?.isLiked == "yes" ? "no" : "yes";
    }

    notifyListeners();
  }

  updateLikeCount(bool isLiked, String count) {
    var newCount = 0;
    if (isInteger(count)) {
      newCount = int.parse(count);
      newCount = !isLiked ? newCount + 1 : newCount - 1;
    }

    return newCount;
  }

  Future<bool> updateLikeApi(String postId, bool isLiked) async {
    try {
      var url = Uri.https(AppConstants.baseUrl, AppConstants.apiUrl,
          {'key': AppConstants.updateLikesCount});
      var userId =
          await SharedPreferenceUtils.getStringFromSp(AppConstants.USER_ID);

      final req = http.MultipartRequest('POST', url)
        ..fields['postId'] = postId
        ..fields['userId'] = userId!
        ..fields['flag'] = isLiked ? "unlike" : "like";

      final stream = await req.send();
      final response = await http.Response.fromStream(stream)
          .timeout(const Duration(seconds: AppConstants.HTTP_TIME_OUT));
      final status = response.statusCode;
      if (status == 200) {
        if (response.body.isNotEmpty) {
          updateLikeResponseModel = likeUpdateResponseFromJson(response.body);
          debugPrint(response.reasonPhrase);
          return true;
        } else {
          debugPrint(response.reasonPhrase);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
}
