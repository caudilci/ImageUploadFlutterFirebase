import 'package:flutter/material.dart';
import 'package:image_upload/models/user.dart';
import 'package:image_upload/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:image_upload/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
