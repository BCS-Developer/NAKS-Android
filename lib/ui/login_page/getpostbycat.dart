import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:top_examer/models/reel_model.dart';
import 'package:top_examer/utils/themes.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late Future<ReelModel> futureReels;

  @override
  void initState() {
    super.initState();
    futureReels = fetchReels();
  }

  Future<ReelModel> fetchReels() async {
    final response = await http.get(Uri.parse(
        'https://currentaffairs.topexamer.com/api.php?key=getPostsByCategory&page=1&limit=10&categoryId=10&lang_id=1'));

    if (response.statusCode == 200) {
      return ReelModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load reels');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: FutureBuilder<ReelModel>(
        future: futureReels,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.message!.isEmpty) {
            return Center(child: Text("No posts available"));
          } else {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.message!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data!.message![index];
                return PostCard(post: post);
              },
            );
          }
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final double LINE_HEIGHT = 1.5;
  final double DES_FONT_SIZE = 14;
  final Message post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(post.assetDetails?.imageUrl ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                post.assetDetails?.imageTitle ?? "No Title",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: DescriptionWidget(
                    description: post.assetDetails?.imageDescription ?? "",
                    post: post),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptionWidget extends StatefulWidget {
  final String description;
  final Message post;

  const DescriptionWidget(
      {Key? key, required this.description, required this.post})
      : super(key: key);

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  static const double LINE_HEIGHT = 1.5;
  static const double DES_FONT_SIZE = 14;

  int calculateMaxLines(BuildContext context) {
    double textDescriptionHeight =
        (MediaQuery.of(context).size.height * 25) / 100;
    int lines = (textDescriptionHeight / (LINE_HEIGHT * DES_FONT_SIZE)).toInt();
    return lines;
  }

  String _removeHtmlTags(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ').trim();
  }

  @override
  Widget build(BuildContext context) {
    final cleanedDescription = _removeHtmlTags(widget.description);
    final colorScheme = Theme.of(context).colorScheme;

    int maxLines = calculateMaxLines(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          cleanedDescription,
          style: const TextStyle(fontSize: 14),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        ClipRRect(
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
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullReelPage(post: widget.post),
                  ),
                );
              },
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
      ],
    );
  }
}

class FullReelPage extends StatelessWidget {
  final Message post;

  const FullReelPage({Key? key, required this.post}) : super(key: key);

  // Function to remove HTML tags, same as in DescriptionWidget
  String _removeHtmlTags(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ').trim();
  }

  @override
  Widget build(BuildContext context) {
    final cleanedDescription = _removeHtmlTags(
        post.assetDetails?.imageDescription ?? "No Description");
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text("Full Reel")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full image with similar height and decoration as in PostCard
            Container(
              height: MediaQuery.of(context).size.height * 0.23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(post.assetDetails?.imageUrl ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),

            Text(
              post.assetDetails?.imageTitle ?? "No Title",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  cleanedDescription,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
