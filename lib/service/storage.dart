import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //upload file to storage
  Future<String> uploadImagesToStorage(
      String folderName, Uint8List file, bool isPost) async {
    if (file.isNotEmpty) {
      //get the path
      Reference reference =
          _storage.ref().child(folderName).child(_auth.currentUser!.uid);
      //create uploadtask
      UploadTask uploadTask = reference.putData(file!);
      //get snapshot
      TaskSnapshot snapshot = await uploadTask;
      //get url of stored image and return
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    }
    return "";
  }
}
