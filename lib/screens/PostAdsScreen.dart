import 'package:buy_sale/widgets/PostAdsWidget.dart';
import 'package:flutter/material.dart';
class PostAdsScreen extends StatelessWidget {
  const PostAdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Ads'),
      ),
      body: SingleChildScrollView(child: PostAdsWidget(),),
    );
  }
}
