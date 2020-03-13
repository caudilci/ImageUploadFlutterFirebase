import 'package:flutter/material.dart';
import 'package:image_upload/models/user.dart';
import 'package:image_upload/screens/image_capture.dart';
import 'package:image_upload/services/auth.dart';
import 'package:image_upload/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    final user = Provider.of<User>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Image Uploader'),
          backgroundColor: Colors.cyan[800],
        ),
        body: StreamBuilder(
            stream: DatabaseService(uid: user.uid).pictureStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: RaisedButton(
                    color: Colors.red,
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  ),
                );
              } else {
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(snapshot.data != null
                          ? snapshot.data
                          : 'https://via.placeholder.com/300?text=Default'),
                    ),
                    RaisedButton(
                      color: Colors.cyanAccent,
                      child: Text(
                        'Choose/Take Picture',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageCapture()));
                      },
                    ),
                    RaisedButton(
                      color: Colors.red,
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () async {
                        await _auth.signOut();
                      },
                    ),
                  ],
                );
              }
            }));
  }
}
