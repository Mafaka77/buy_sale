import 'package:buy_sale/screens/CategoryWiseScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Data {
  final int id;
  final String name;
  final String icon;

  Data({required this.id, required this.name, required this.icon});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(id: json['id'], name: json['name'], icon: json['icon']);
  }
}


class CategoryListWidget extends StatefulWidget {
  CategoryListWidget({Key? key}) : super(key: key);
  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  Future<List<Data>> fetchData() async {
    var url = Uri.parse('http://192.168.154.44:8000/api/categories/all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new Data.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  late Future<List<Data>> futureData;

  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Data>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Data> data = snapshot.data!;
            return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 4 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: GestureDetector(
                      onTap: ()=>{
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (c)=>CategoryWise(data[index].name)
                        ))
                      },
                      child: GridTile(
                        child: Image.network(
                          data[index].icon,
                          fit: BoxFit.contain,
                        ),
                        footer: GridTileBar(
                          backgroundColor: Colors.black45,
                          title: Center(child: Text(data[index].name)),
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('Error');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
