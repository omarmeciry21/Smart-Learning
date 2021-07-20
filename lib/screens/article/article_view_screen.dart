import 'package:flutter/material.dart';
import 'package:smart_learning/images.dart';
import 'package:smart_learning/models/article.dart';
import 'package:smart_learning/constants.dart';

class ArticleViewScreen extends StatelessWidget {
  final Article article;
  ArticleViewScreen({@required this.article});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 350.0,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: FadeInImage(
                    placeholder: AssetImage(LocalImages.imgPhoto),
                    image: NetworkImage(
                      article.imageUrl,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${article.title}',
                      style: kArticleTitleStyle,
                    ),
                    Text(
                      '${article.date}',
                      textAlign: TextAlign.end,
                      style: kArticalDateStyle,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    article.body != null
                        ? Text(
                            '${article.body}',
                            textAlign: TextAlign.justify,
                            style: kArticleBodyStyle,
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
