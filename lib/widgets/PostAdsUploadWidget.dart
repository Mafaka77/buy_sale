import 'package:flutter/material.dart';

class PostAdsUpload extends StatefulWidget {
  final int id;
  final String name;

  PostAdsUpload(this.id, this.name);

  @override
  _PostAdsUploadState createState() => _PostAdsUploadState();
}

class _PostAdsUploadState extends State<PostAdsUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Container(
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
                decoration: InputDecoration(
                    hintText: 'Ads Details',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Price',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
