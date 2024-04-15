import 'package:flutter/material.dart';

const patternUrl =
    'https://i.pinimg.com/564x/26/79/21/2679218ab031e9bd24f8a805238e7029.jpg';

class ArticleImageWidget extends StatefulWidget {
  const ArticleImageWidget({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    required this.radius,
    required this.id,
  });

  final String imageUrl;
  final double height;
  final double width;
  final double radius;
  final int id;

  @override
  ArticleImageWidgetState createState() => ArticleImageWidgetState();
}

class ArticleImageWidgetState extends State<ArticleImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.imageUrl + widget.id.toString(),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.network(
              widget.imageUrl,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.network(patternUrl);
              },
            ),
          ),
        ),
      ),
    );
  }
}
