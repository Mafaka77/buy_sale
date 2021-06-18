import 'package:flutter/material.dart';

class FoodsWidget extends StatelessWidget {
  // const FoodsWidget(id, {Key? key}) : super(key: key);
  final String ads_title;
  final String image_url1;
  FoodsWidget(this.ads_title,this.image_url1);

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Image.network(image_url1,fit: BoxFit.contain,),
        footer: GridTileBar(
          backgroundColor:Colors.black45,
          title: Text(ads_title),
        ),
      );
  }
}
