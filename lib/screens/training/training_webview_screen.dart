import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_learning/constants.dart';
import 'package:smart_learning/models/training.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrainingWebviewScreen extends StatefulWidget {
  final Training training;
  TrainingWebviewScreen({@required this.training});
  @override
  _TrainingWebviewScreenState createState() => _TrainingWebviewScreenState();
}

class _TrainingWebviewScreenState extends State<TrainingWebviewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.training.title,
          style: kCardTitleStyle.copyWith(fontSize: 25.0),
        ),
        backgroundColor: kBrightBlueColor,
      ),
      body: WebView(
        initialUrl: widget.training.courseUrl,
        onProgress: (progress) {
          return CircularProgressIndicator(
            value: progress.toDouble(),
            backgroundColor: kBrightBlueColor,
          );
        },
        onWebViewCreated: (WebViewController webviewController) {
          _controller.complete(webviewController);
        },
      ),
    );
  }
}
