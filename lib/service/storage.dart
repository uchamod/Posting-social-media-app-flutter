import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //upload file to storage
  Future<String> uploadImagesToStorage(
      String folderName, Uint8List file, bool isPost) async {
    //get the path
    try {
      Reference reference =
          _storage.ref().child(folderName).child(_auth.currentUser!.uid);

      if (isPost) {
        String postid = Uuid().v1();
        reference = reference.child(postid);
      }
      //create uploadtask
      UploadTask uploadTask = reference.putData(file);
      //get snapshot
      TaskSnapshot snapshot = await uploadTask;
      //get url of stored image and return
      String imageUrl = await snapshot.ref.getDownloadURL();
      print("upload imge");
      return imageUrl;
    } catch (err) {
      print(err.toString());
    }
    return "";
  }
}
