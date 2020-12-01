import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class StorageService {
  /// Uploads [reciept] to Firebase Storage and returns a [download URL]
  Future<dynamic> uploadImage(File reciept) async {
    String now = DateFormat('MM-dd-yyyy').format(DateTime.now());
    String fileName = basename('$now${reciept.path}');

    StorageReference storageRef = FirebaseStorage.instance.ref().child('receipts/$fileName');
    StorageUploadTask uploadTask = storageRef.putFile(reciept);
    await uploadTask.onComplete;

    return await storageRef.getDownloadURL();
  }

  /// Uploads a user with UID of [userID] [avatar] to Firebase Storage and returns a [download URL]
  Future<dynamic> uploadAvatarImage(File avatar, String userId) async {
    String fileName = basename('$userId');

    StorageReference storageRef = FirebaseStorage.instance.ref().child('avatars/$fileName');
    StorageUploadTask uploadTask = storageRef.putFile(avatar);
    await uploadTask.onComplete;

    return await storageRef.getDownloadURL();
  }
}
