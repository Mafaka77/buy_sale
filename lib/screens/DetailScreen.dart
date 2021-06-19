import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

// class Data {
//   final String ads_title;
//   final String ads_details;
//   final String categories;
//   final String ads_price;
//   final String user_id;
//   final String user_name;
//   final String user_address;
//
//   Data(this.ads_title, this.ads_details, this.ads_price, this.categories,
//       this.user_id, this.user_name, this.user_address);
// }
//
// class Images {
//   final String image_name;
//
//   Images(this.image_name);
// }

class DetailScreen extends StatefulWidget {
  final int id;
  final String ads_title;
  final String ads_details;
  final String categories;
  final String ads_price;
  final String user_id;


  DetailScreen(this.id, this.ads_title, this.categories, this.ads_details,
       this.ads_price, this.user_id);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categories)),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: Carousel(
                  images: [],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text('${widget.ads_title}'),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text('₹ ${widget.ads_price}'),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 2,
                width: 500,
                color: Colors.purpleAccent,
              ),
              Container(
                margin: EdgeInsets.only(top:10 ),
                child: Text('Details'),
              ),
              Container(
                margin: EdgeInsets.only(top:10 ),
                child: Text(widget.ads_details),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('Seller'),
                    ),
                    Container(
                      child: Text('Address'),
                    ),
                    Container(
                      child: Text('ID:${widget.user_id}'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
