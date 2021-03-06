// @dart=2.9
import 'package:buy_sale/screens/DetailScreen.dart';
import 'package:buy_sale/screens/PostAdsScreen.dart';
import 'package:flutter/material.dart';
import 'screens/Navigation.dart';
import 'screens/LoginScreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'screens/RegisterScreen.dart';
String a;
Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final storage=FlutterSecureStorage();
  a=await storage.read(key: 'token');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: a==null?'login':'/',
      routes: {
        '/':(context)=>Navigation(),
        'login':(context)=>LoginScreen(),
        '/register':(context)=>RegisterScreen(),
      },
    );
  }
}
