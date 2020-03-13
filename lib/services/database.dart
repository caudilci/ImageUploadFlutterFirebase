import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class DatabaseService{

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String pictureURL) async {
    return await userCollection.document(uid).setData({
      'uid': uid,
      'pictureURL': pictureURL
    });
  }

  Stream<String> get pictureStream{
    return userCollection.document(uid).snapshots().map(_stringFromSnapshot);
  }

  String _stringFromSnapshot(DocumentSnapshot snapshot){
    return snapshot.data['pictureURL'];
  }
}