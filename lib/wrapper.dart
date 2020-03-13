import 'package:flutter/material.dart';
import 'package:image_upload/models/user.dart';
import 'package:image_upload/screens/authenticate.dart';
import 'package:image_upload/screens/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either home or authenticate widget
    return user != null ? Home() : Authenticate();
  }
}
