import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper {
  StorageHelper._();
  static final storageHelper = StorageHelper._();

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(File file,
      [String folderName = 'profiles']) async {
    // 1. make a reference of this file on Firebase Storage.
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String path = 'images/$folderName/$fileName';
    Reference reference = firebaseStorage.ref(path);

    // 2. upload the file to the defined reference.
    await reference.putFile(file);

    // 3. get the file URL
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }
}
