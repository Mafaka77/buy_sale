import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;

class Data {
  final int id;
  final String image_name;

  Data(this.id, this.image_name);
}

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  List<dynamic> images = [];

  Future<List> _myData() async {
    var url = Uri.parse('http://10.180.243.49:8000/api/banner/all');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body)[0]['image_name'];

    for (var u in jsonResponse) {
      images.add(NetworkImage(u));
    }
    print(images);
    return jsonResponse;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _myData(),
      builder: (BuildContext context, snapshot) {
        print(snapshot);
        if (snapshot.hasData) {
          return Carousel(
            images: images,
            boxFit: BoxFit.cover,
            showIndicator: false,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error'),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
