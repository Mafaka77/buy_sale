import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'dart:async';
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
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Your ads Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
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
                      hintText: 'Price',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
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
                    )
                  ],
                ),
              ),
              Container(
                height: 200,

                  child: buildGridView())
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: _images,
        materialOptions: MaterialOptions(
          allViewTitle: 'All Photos',
          useDetailsView: false,
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if(!mounted) return;
    setState(() {
      _images=resultList;
      print(_images);
    });

  }

// Future<void> _showDialog() async {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: [
//                 TextButton(
//                     onPressed: () async {
//                       await chooseImageFromCamera()
//                           .then((value) => Navigator.of(context).pop());
//                     },
//                     child: Text('Take Picture')),
//                 TextButton(
//                     onPressed: () async {
//                       await chooseImageFromGallery()
//                           .then((value) => Navigator.of(context).pop());
//                     },
//                     child: Text('Choose from Gallery')),
//               ],
//             ),
//           ),
//         );
//       });
// }

// Future chooseImageFromCamera() async {
//   final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
//   setState(() {
//     if (pickedFile != null) {
//       _images.removeAt(0);
//       _images.insert(0,File(pickedFile.path));
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('No Image Picked')));
//     }
//   });
// }
//
// Future chooseImageFromGallery() async {
//   final pickedFile =
//       await ImagePicker().getImage(source: ImageSource.gallery);
//   setState(() {
//     if (pickedFile != null) {
//       _images.removeAt(0,File(pickedFile.path));
//       print(_images);
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('No image picked')));
//     }
//   });
// }
}
