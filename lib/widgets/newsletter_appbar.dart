import 'package:flutter/material.dart';
import 'package:smart_learning/constants.dart';
import 'package:smart_learning/images.dart';

class NewsletterBar extends StatelessWidget {
  const NewsletterBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0),
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(LocalImages.imgNewsletter),
              width: 40.0,
              height: 40.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Newsletter',
              style: TextStyle(
                fontFamily: 'Raleway-SemiBold',
                fontSize: 25.0,
                color: kBrightBlueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
