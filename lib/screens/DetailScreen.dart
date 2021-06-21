import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_icons/flutter_icons.dart';
class Data {
  final String ads_title;
  final String ads_details;
  final String categories;
  final String ads_price;
  final String user_id;

  Data(this.ads_title, this.ads_details, this.ads_price, this.categories,
      this.user_id);
}

//
class Users {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String address;

  Users({required this.id, required this.name, required this.email, required this.mobile, required this.address});
  factory Users.fromJson(Map<String, dynamic> json){
    return Users(
      id:json['id'],
      name:json['name'],
      email:json['email'],
      mobile:json['mobile'],
      address:json['address']
    );
  }
}

class DetailScreen extends StatefulWidget {
  final int id;
  final String ads_title;
  final String ads_details;
  final String categories;
  final String ads_price;
  final String user_id;

  DetailScreen(this.id, this.ads_title, this.categories, this.ads_details,
      this.ads_price, this.user_id);

  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<dynamic> images = [];

  Future<List> _myData() async {
    var myId = this.widget.id;
    // print(myId);
    var url = Uri.parse('http://192.168.154.44:8000/api/ads/details/$myId');
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body)['data'][0]['image_name'];
    // print(images);
    for (var u in jsonData) {
      images.add(NetworkImage(u));
    }
    return jsonData;
  }

  Future<Users> _myUsers() async {
    var uid = this.widget.user_id;
    var url = Uri.parse('http://192.168.154.44:8000/api/auth/user/$uid');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body)[0];
    return Users.fromJson(jsonData);
    // print(jsonData);
    // List<Users> users = [];
    //
    // for (var a in jsonData) {
    //   Users us =
    //       Users(a['id'], a['name'], a['email'], a['mobile'], a['address']);
    //   users.add(us);
    // }
    //
    // return users;
  }
  late Future<Users> fu;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fu=_myUsers();
    print(fu);
  }

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
              Container(
                  child: FutureBuilder(
                future: _myData(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        height: 200,
                        child: Carousel(
                          images: images,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error'));
                  }
                  return Center(child: CircularProgressIndicator());
                },
              )),
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
                margin: EdgeInsets.only(top: 10),
                child: Text('Details'),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(widget.ads_details),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: FutureBuilder<Users>(
                  future: fu,
                  builder: ( context,  snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(FontAwesome.mobile),
                                Text(snapshot.data!.mobile)
                              ],
                            ),
                          ),
                          Container(
                            child: Text('Address'),
                          ),
                          Container(
                            child: Text('ID:${widget.user_id}'),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error'));
                    }
                    return Center(child: CircularProgressIndicator());
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
