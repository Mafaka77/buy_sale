
import 'package:buy_sale/widgets/FoodsWidget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

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
        user_id: json['user_id']);
  }
}

class CategoryWise extends StatefulWidget {
  final String name;

  CategoryWise(this.name);

  @override
  _CategoryWiseState createState() => _CategoryWiseState();
}

class _CategoryWiseState extends State<CategoryWise> {
  Future<List<Data>> _myData() async {
    var cat = this.widget.name;
    print(cat);
    var url = Uri.parse('http://10.180.243.55:8000/api/ads/cat/$cat');
    var response = await http.get(url);
    List jsonData = jsonDecode(response.body);
    return jsonData.map((e) => new Data.fromJson(e)).toList();
  }

  late Future<List<Data>> _futureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureData = _myData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: FutureBuilder<List<Data>>(
                  future: _futureData,
                  builder: (BuildContext c, snapshot) {
                    print(snapshot);
                    if (snapshot.hasData) {
                      List<Data> data = snapshot.data!;
                      return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              color: Colors.deepPurple,
                              child: FoodsWidget(
                                  data[index].id,
                                  data[index].ads_title,
                                  data[index].categories,
                                  data[index].ads_details,
                                  data[index].ads_price,
                                  data[index].image_name[0],
                                  data[index].user_id),
                            );
                          });
                    }else if(snapshot.hasError){
                      return Center(child: Text('No Data'),);
                    }return Center(child: CircularProgressIndicator(),);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
