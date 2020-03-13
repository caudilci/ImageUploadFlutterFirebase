import 'package:flutter/material.dart';
import 'package:image_upload/services/auth.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan[800],
        centerTitle: true,
        title: Text('ImageCapture'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Sign-In Anon"),
          onPressed: () {
            setState(() {
              _auth.signInAnon();
            });
          },
        ),
        )
    );
  }
}