import 'dart:async';

import 'package:buy_sale/routes/Api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class PostAdsUpload extends StatefulWidget {
  final int id;
  final String name;

  PostAdsUpload(this.id, this.name);

  @override
  _PostAdsUploadState createState() => _PostAdsUploadState();
}

class _PostAdsUploadState extends State<PostAdsUpload> {
  final _controller = TextEditingController();
  List<Asset> _images = [];

  Widget buildGridView() {
    return GridView.count(
      padding: EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: List.generate(_images.length, (index) {
        Asset asset = _images[index];
        return AssetThumb(
          asset: asset,
          width: 500,
          height: 500,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: TextField(
                  maxLength: 40,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.title,color: Colors.redAccent,),
                      hintText: 'Your ads Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLength: 500,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: 'Ads Details',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.price_check,color: Colors.redAccent,),
                      hintText: 'Price',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black45,
                      child: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.not_listed_location_sharp),
                        color: Colors.red,
                      )
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: GestureDetector(
                        onTap: () => {loadAssets()},
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 200, child: buildGridView())
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: Container(
            width: 400,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'SUBMIT',
                style: TextStyle(fontSize: 18, color: Colors.blueAccent),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> loadAssets() async {
    // print('sadasd');
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: _images,
        materialOptions: MaterialOptions(
          selectionLimitReachedText: 'Error',
          textOnNothingSelected: 'Please Select an Image',
          allViewTitle: 'All Photos',
          useDetailsView: false,
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;
    setState(() {
      _images = resultList;
      // print(_images);
    });
  }

  void postAds() async {
    List<MultipartFile> multipartImageList = [];
    if (_images != null) {
      for (Asset asset in _images) {
        // print('test');
        // asset.metadata.then((value) => print('test '+value));

        ByteData byteData = await asset.getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        MultipartFile multipartFile = new MultipartFile.fromBytes(
          imageData,
          filename: 'asdasd',
          contentType: MediaType('image', 'jpeg'),
        );
        multipartImageList.add(multipartFile);
      }
      print(multipartImageList);
      FormData formData = FormData.fromMap({
        'image_name[]': multipartImageList,
        'ads_title': 'ads_title',
        'categories': 'Cars',
        'ads_details': 'ads_details',
        'ads_price': '3445',
        'user_id': '1'
      });
      Dio dio = new Dio();
      var res = await dio.post(Routes.POST_ADS, data: formData);
      print(res);
    }
  }
}
