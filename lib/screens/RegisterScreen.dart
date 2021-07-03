import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                child: SizedBox(
                  child: Text('REGISTER'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 50),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'I Hming',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.verified_user,color: Colors.redAccent,)
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 10),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email,color: Colors.redAccent,)
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 10),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.password,color: Colors.redAccent,)
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 10),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Mobile(Whatsapp)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.mobile_friendly,color: Colors.redAccent,)
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 10),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.maps_home_work,color: Colors.redAccent,)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
