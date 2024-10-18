import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/models/reel_model.dart';
import 'package:top_examer/ui/reels_page/full_reel_page.dart';
import 'package:top_examer/ui/reels_page/reel_menu_options.dart';

import '../../providers/posts_provider.dart';
import '../../utils/helper.dart';
import '../../utils/themes.dart';

class ImageReelWidget extends StatelessWidget {
  final double LINE_HEIGHT = 1.5;
  final double DES_FONT_SIZE = 14;

  final Message? reelData;
  final bool showFullArticle;
  ImageReelWidget(this.reelData, this.showFullArticle, {super.key});
  @override
  Widget build(BuildContext buildContext) {
    final colorScheme = Theme.of(buildContext).colorScheme;
    int lines = calculateMaxLines(buildContext);
    return Column(
      children: [
        Expanded(
          flex: 30,
          child: SizedBox(
            height: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: showFullArticle
                    ? const Radius.circular(0)
                    : const Radius.circular(15.0),
                topRight: showFullArticle
                    ? const Radius.circular(0)
                    : const Radius.circular(15.0),
              ),
              child: CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: reelData?.assetDetails?.imageUrl ?? "",
                placeholder: (context, url) => Container(
                  color: Themes.black_color12,
                  child: Center(
                    child: Icon(
                      Icons.cloud_download_sharp,
                      color: colorScheme.onBackground,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Themes.black_color12,
                  child: Center(
                    child: Icon(
                      Icons.error,
                      color: colorScheme.onBackground,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 70,
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
            ),
            child: Padding(
              padding: showFullArticle
                  ? const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0)
                  : const EdgeInsets.all(0.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 4),
                              decoration: BoxDecoration(
                                color: Themes.categoryName_background,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                reelData?.categoryName ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: Themes.fontFamily,
                                  color: colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            ReelMenuOptions(reelData),
                          ],
                        ),
                      ),

                      Text(
                        reelData?.assetDetails?.imageTitle ?? "",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: Themes.fontFamily,
                            color: colorScheme.onSurface,
                            height: 1.2),
                      ),
                      const SizedBox(height: 8),
                      // Description
                      !showFullArticle
                          ? Text(
                              maxLines: showFullArticle ? null : lines,
                              overflow: showFullArticle
                                  ? null
                                  : TextOverflow.ellipsis,
                              removeAllHtmlTags(
                                  reelData?.assetDetails?.imageDescription ??
                                      ""),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: Themes.fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: colorScheme.onSurface,
                              ),
                              softWrap: true,
                            )
                          : HtmlWidget(
                              reelData?.assetDetails?.imageDescription ?? "",
                              textStyle: TextStyle(
                                color: colorScheme.onSurface,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: !showFullArticle,
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  buildContext,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider.value(
                      value: Provider.of<PostsProvider>(buildContext,
                          listen: false),
                      child: FullReelPage(reelData),
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: colorScheme.onSurface,
                        width: 1.5,
                      ),
                    ),
                    color: colorScheme.surface,
                  ),
                  height: 35,
                  child: Center(
                    child: Text(
                      "Tap to Read Full Story",
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.tertiary,
                        fontFamily: Themes.fontFamily,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  int calculateMaxLines(BuildContext context) {
    double textDescriptionHeight =
        (MediaQuery.of(context).size.height * 25) / 100;
    int lines = (textDescriptionHeight / (LINE_HEIGHT * DES_FONT_SIZE)).toInt();
    return lines;
  }
}
