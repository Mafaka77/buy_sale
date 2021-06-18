import 'package:flutter/material.dart';
import '../widgets/HomeWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy & Sale'),
      ),
      body: SingleChildScrollView(child: HomeWidget()),
    );
  }
}
