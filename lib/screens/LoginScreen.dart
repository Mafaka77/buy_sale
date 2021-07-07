import 'dart:convert';

import 'package:buy_sale/screens/Navigation.dart';
import 'package:buy_sale/screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.redAccent,
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Password',
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.redAccent,
                        )),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.pinkAccent),
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () => {login()},
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text('OR'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (builder) => RegisterScreen()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pinkAccent)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final storage = new FlutterSecureStorage();
    var url = Uri.parse(
        'http://10.180.243.55:8000/api/auth/login?email=$email&password=$password');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      // String token=res;
      // print(token);
      var a = await storage.write(key: 'token', value: res['token'].toString());
      var b = await storage.read(key: 'token');
      print(b);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (builder) => Navigation(),
        ),
      );
    }
  }
}
