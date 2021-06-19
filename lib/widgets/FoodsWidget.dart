import 'package:flutter/material.dart';
import '../screens/DetailScreen.dart';

class FoodsWidget extends StatelessWidget {
  // const FoodsWidget(id, {Key? key}) : super(key: key);
  final int id;
  final String ads_title;
  final String image_name;
  final String ads_price;
  final String ads_details;
  final String categories;
  final String user_id;

  FoodsWidget(
    this.id,
    this.ads_title,
    this.categories,
    this.ads_details,
    this.ads_price,
    this.image_name,
    this.user_id,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => DetailScreen(id, ads_title, categories, ads_details,
                ads_price,user_id)))
      },
      child: GridTile(
        child: Image.network(
          image_name,
          fit: BoxFit.contain,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Center(
              child: Text(
            ads_title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
