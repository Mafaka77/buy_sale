import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top:40),
                  child: Text('LOGIN',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.pinkAccent),),
                ),
              Container(
                margin: EdgeInsets.only(top:30,left: 30,right: 30),
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'Enter Email'),

                ),
              ),
              Container(
                margin: EdgeInsets.only(top:30,left: 30,right: 30),
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'Enter Password'),

                ),
              ),
              Container(
                margin: EdgeInsets.only(top:30),
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 500,
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                        ),
                        child: Text('Sign In'),
                        onPressed: ()=>{},
                      ),
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
