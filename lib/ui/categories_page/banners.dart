import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_examer/utils/themes.dart';
import '../../../providers/banners_provider.dart';
import '../../providers/global_provider.dart';

class Banners extends StatefulWidget {
  const Banners({super.key});

  @override
  State<Banners> createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  double width = 0;
  double height = 0;
  double bannerHeight = 0;
  CarouselController buttonCarouselController = CarouselController();
  late GlobalProvider globalProvider;

  @override
  void initState() {
    globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<BannersProvider>(context, listen: false).getBanners(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    //bannerHeight = width * 0.50;
     bannerHeight = MediaQuery.of(context).orientation == Orientation.portrait
         ? width * 0.50
         : height * 0.25;
    final bannersProvider = context.watch<BannersProvider>();
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
          height: bannerHeight,
          child:
              bannersProvider.isLoading ? null : bannersView(bannersProvider)),
    );
  }

  Widget bannersView(BannersProvider bannersProvider) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        height: bannerHeight,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        viewportFraction: 1,
        padEnds: true,
        enableInfiniteScroll: true,
      ),
      carouselController: buttonCarouselController,
      items: bannersProvider.bannersModel?.message.map((message) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                SizedBox(
                  width: width - 50,
                  height: bannerHeight - 20,
                  child: GestureDetector(
                    onTap: () {
                      var postId =
                          bannersProvider.getReelIdFromUrl(message.postUrl);
                      if (postId != null) {
                        globalProvider.isRefreshPage = true;
                        globalProvider.selectedTabIndex = 1;
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: CachedNetworkImage(
                        imageUrl: message.imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          color: Color(0xFFB9B9B9),
                          child: const Center(
                            child: Icon(
                              Icons.cloud_download_sharp,
                              color: Themes.black_color,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Color(0xFFB9B9B9),
                          child: const Center(
                            child: Icon(
                              Icons.error,
                              color: Themes.black_color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }
}
