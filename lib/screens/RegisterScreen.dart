import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                child: SizedBox(
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 50),
                child: SizedBox(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: 'I Hming',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.verified_user,
                          color: Colors.redAccent,
                        )),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 10),
                child: SizedBox(
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.redAccent,
                        )),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 10),
                child: SizedBox(
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.redAccent,
                        )),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 10),
                child: SizedBox(
                  child: TextField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Mobile(Whatsapp)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.mobile_friendly,
                          color: Colors.redAccent,
                        )),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 10),
                child: SizedBox(
                  child: TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.maps_home_work,
                          color: Colors.redAccent,
                        )),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: 300,
                  child: TextButton(
                    onPressed: () {
                      register();

                    },
                    child: Text('Register'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.redAccent),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String mobile = _mobileController.text;
    String address = _addressController.text;

    var url=Uri.parse('http://10.180.243.55:8000/api/auth/register');
    var response=await http.post(url,body: {
      'name':name,
      'email':email,
      'password':password,
      'mobile':mobile,
      'address':address
    });
    if(response.statusCode==200){
      print(response.body);
    }

  }
}
