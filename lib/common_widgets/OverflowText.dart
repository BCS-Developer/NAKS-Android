import 'package:flutter/material.dart';

class OverflowText extends StatelessWidget {
  const OverflowText({super.key, required this.text, this.style});

  final TextStyle? style;
  final String text;

  double _heightRequired(
    String text,
    TextStyle? style,
    double maxWidth,
    TextScaler textScaler,
  ) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
    )..layout(maxWidth: maxWidth);
    return tp.size.height;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final heightRequired = _heightRequired(
          text,
          style,
          constraints.maxWidth,
          media.textScaler,
        );
        final willTruncate = heightRequired > constraints.maxHeight;
        if (willTruncate) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: style,
                  overflow: TextOverflow.fade,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  minimumSize: const Size(0, 0),
                ),
                child: const Text(
                  'Read More',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }
        return Text(text, style: style);
      },
    );
  }
}
