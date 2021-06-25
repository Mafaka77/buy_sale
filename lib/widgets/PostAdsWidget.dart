import 'package:buy_sale/widgets/PostAdsUploadWidget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Categories.dart';
Future<List<Data>> fetchData() async {
  var url = Uri.parse('http://192.168.154.109:8000/api/categories/all');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => new Data.fromJson(e)).toList();
  } else {
    throw Exception('Error Occured');
  }
}


class PostAdsWidget extends StatefulWidget {
  const PostAdsWidget({Key? key}) : super(key: key);

  @override
  _PostAdsWidgetState createState() => _PostAdsWidgetState();
}

class _PostAdsWidgetState extends State<PostAdsWidget> {
  late Future<List<Data>> _futureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 40, left: 15),
          child: Text(
            'Please Select Item you want to sell:',
            style: TextStyle(fontSize: 15),
          ),
        ),
        Container(
          margin: EdgeInsets.all(15),
          child: FutureBuilder<List<Data>>(
            future: _futureData,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                List<Data> data = snapshot.data!;
                return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (a) => PostAdsUpload(data[i].id,data[i].name)))
                          },
                          child: GridTile(
                            child: Image.network(
                              data[i].icon,
                              fit: BoxFit.contain,
                            ),
                            footer: GridTileBar(
                              backgroundColor: Colors.black45,
                              title: Center(
                                child: Text(data[i].name),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
