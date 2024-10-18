import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/models/reel_model.dart';
import 'package:top_examer/providers/global_provider.dart';
import 'package:top_examer/ui/job_application/JobApplicationFormPage.dart';
import 'package:top_examer/utils/analytics_engine.dart';
import 'package:top_examer/utils/themes.dart';

import '../../providers/posts_provider.dart';
import '../../utils/helper.dart';

class ReelMenuOptions extends StatefulWidget {
  final Message? reelData;

  const ReelMenuOptions(this.reelData, {super.key});
  @override
  State<ReelMenuOptions> createState() => _ReelMenuOptionsState();
}

class _ReelMenuOptionsState extends State<ReelMenuOptions> {
  late PostsProvider postsProvider;
  late GlobalProvider globalProvider;
  final String jobCategory = "114";
  final String matrimonyCategory = "114";
  @override
  void initState() {
    super.initState();
    postsProvider = Provider.of<PostsProvider>(context, listen: false);
    globalProvider = Provider.of<GlobalProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext buildContext) {
    final colorScheme = Theme.of(buildContext).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 0, right: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.reelData?.categoryId == jobCategory)
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JobApplicationFormPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: Themes.categoryName_background,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "Apply Job",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: Themes.fontFamily,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ),

          IconButton(
              icon: SvgPicture.asset(
                'assets/share.svg',
                color: Themes.like_share,
                width: 21.86,
                height: 21.12,
              ),
              onPressed: () {
                AnalyticsEngine.shareClick(widget.reelData!.postId.toString(),
                    globalProvider.selectedCategoryName);
                shareArticle(widget.reelData?.postId ?? "",
                    widget.reelData?.categoryId ?? "");
              }),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  var isUpdated = await postsProvider.updateLikeApi(
                      widget.reelData!.postId!,
                      widget.reelData?.isLiked == "yes");
                  if (isUpdated) {
                    AnalyticsEngine.logLike(
                        !(widget.reelData?.isLiked == "yes"));
                    postsProvider.updateReelObject(widget.reelData);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: widget.reelData?.isLiked == "yes"
                      ? const Icon(
                          Icons.thumb_up,
                          color: Themes.like_share,
                        )
                      : SvgPicture.asset(
                          'assets/un_like.svg',
                          color: Themes.like_share,
                          width: 22,
                          height: 22,
                        ),
                ),
              ),
              Visibility(
                visible: (widget.reelData?.likes != null &&
                    widget.reelData?.likes != "0"),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    widget.reelData?.likes ?? "",
                    style: const TextStyle(
                        fontFamily: Themes.fontFamily, fontSize: 14),
                  ),
                ),
              )
            ],
          ), // Conditionally display an additional icon for the specific category
        ],
      ),
    );
  }
}
