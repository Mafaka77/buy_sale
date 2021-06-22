import 'package:flutter/material.dart';
class CategoryWise extends StatefulWidget {
  final String name;
  CategoryWise(this.name);

  @override
  _CategoryWiseState createState() => _CategoryWiseState();
}

class _CategoryWiseState extends State<CategoryWise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.name),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Container(),
      ),
    );
  }
}
