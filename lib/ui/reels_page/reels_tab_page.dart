// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/common_widgets/common-widgets.dart';
import 'package:top_examer/models/reel_model.dart';
import 'package:top_examer/providers/posts_provider.dart';
import 'package:top_examer/ui/reels_page/image_reel_widget.dart';
import 'package:top_examer/ui/reels_page/video_reel_widget.dart';
import 'package:top_examer/utils/constants.dart';

import '../../utils/analytics_engine.dart';
import '../../utils/shared_preference_utils.dart';

class ReelsPage extends StatefulWidget {
  ReelsPage({key}) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  final PageController controller = PageController();
  late PostsProvider postsProvider;
  int currentIndex = 0;
  var eventBus;
  @override
  void initState() {
    super.initState();
    AnalyticsEngine.setCurrentScreen("Reels Page");
    postsProvider = Provider.of<PostsProvider>(context, listen: false);
    postsProvider.reset();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      getData();
    });
  }

  getData() async {
    await postsProvider.getReels(context);
    await SharedPreferenceUtils.removeStringFromSP(AppConstants.POST_ID);
    await SharedPreferenceUtils.removeStringFromSP(
        AppConstants.IS_APPLINK_NAVIGATED);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.background,
      child: Consumer<PostsProvider>(
          builder: (context, model, child) => model.isLoading
              ? new CommonWidgets().circularProgressIndicator()
              : PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: controller,
                  onPageChanged: (int index) {
                    currentIndex = index;
                    setState(() {
                      if (index == model.reelsList.length - (model.limit / 2)) {
                        model.getReels(context);
                      }
                    });
                  },
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 15,
                        surfaceTintColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: getView(model?.reelsList?[position]),
                      ),
                    );
                  },
                  itemCount: model.reelsList?.length, // Can be null
                )),
    );
  }

  getView(Message? data) {
    if (data?.assetDetails?.videoUrl != null &&
        data?.assetDetails?.videoUrl != "") {
      return VideoReelWidget(
        data,
        () {
          //onvideo completed
          controller.nextPage(
              duration: const Duration(
                milliseconds: 400,
              ),
              curve: Curves.easeIn);
        },
      );
    } else {
      return ImageReelWidget(data, false);
    }
  }
}
