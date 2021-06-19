import 'dart:async';
import 'dart:convert';
import 'package:buy_sale/widgets/CategoryList.dart';
import 'package:buy_sale/widgets/FoodsWidget.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/CategoryList.dart';

Future<List<Data>> fetchData() async {
  var url = Uri.parse('http://192.168.154.44:8000/api/ads/all');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Data {
  final int id;
  final String ads_title;
  final String categories;
  final String ads_details;
  final String ads_price;
  final List<dynamic> image_name;
  final String user_id;

  Data(
      {required this.id,
      required this.ads_title,
      required this.categories,
      required this.ads_details,
      required this.ads_price,
      required this.image_name,
      required this.user_id});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      ads_title: json['ads_title'],
      categories: json['categories'],
      ads_details: json['ads_details'],
      ads_price: json['ads_price'],
      image_name: json['image_name'],
      user_id: json['user_id'],

    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late Future<List<Data>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 30,
          child: Text('My Location:'),
        ),
        SizedBox(
          height: 100,
          width: 1000,
          child: Carousel(
            images: [
              Image.network(
                  'https://image.flaticon.com/icons/png/512/3487/3487037.png')
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          height: 5,
          width: 500,
          margin: EdgeInsets.only(top: 10),
          color: Colors.pinkAccent,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: CategoryListWidget(),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            'Featured',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          height: 5,
          width: 500,
          margin: EdgeInsets.only(top: 10),
          color: Colors.blue,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: FutureBuilder<List<Data>>(
            future: futureData,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                List<Data> data = snapshot.data!;
                return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          color: Colors.white,
                          child: FoodsWidget(
                            data[index].id,
                              data[index].ads_title,
                              data[index].categories,
                              data[index].ads_details,
                              data[index].ads_price,
                            data[index].image_name[0],
                            data[index].user_id));
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default show a loading spinner.
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ]),
    );
  }
}
