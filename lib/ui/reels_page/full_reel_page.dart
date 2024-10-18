import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/models/reel_model.dart';

import '../../providers/posts_provider.dart';
import '../../utils/themes.dart';
import 'image_reel_widget.dart';

class FullReelPage extends StatefulWidget {
  final Message? reelData;

  FullReelPage(this.reelData, {Key? key}) : super(key: key);
  @override
  State<FullReelPage> createState() => _FullReelPageState();
}

class _FullReelPageState extends State<FullReelPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.error,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/arrow_back.svg',
            width: 10.45,
            height: 18.96,
            color: Themes.back_arrow,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: const IconThemeData(
          color: Themes.back_arrow,
        ),
        title: const Text(
          'News Details',
          style: Themes.appBarHeader,
        ),
      ),
      body: Consumer<PostsProvider>(
          builder: (context, model, child) =>
              ImageReelWidget(widget.reelData, true)),
    );
  }
}
