import 'package:flutter/material.dart';
import '../widgets/MyAccountWidget.dart';
class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Account'),),
      body: MyAccountWidget(),
    );
  }
}
