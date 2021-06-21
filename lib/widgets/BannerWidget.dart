import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;


class Data{
  final int id;
  final String image_name;
  Data(this.id,this.image_name);
}
class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  List<dynamic> ban=[];
  Future<List<Data>> _myData() async{
    var url=Uri.parse('http://192.168.154.109:8000/api/banner/all');
    var response=await http.get(url);
    var jsonResponse=jsonDecode(response.body)[0];

    for(var u in jsonResponse){
      ban.add(NetworkImage(u));
    }
    print(ban);
    return jsonResponse;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _myData(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return Carousel(
            images: ban,
          );
        }else if(snapshot.hasError){
          return Center(child: Text('Error'),);
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
      
  }
}
