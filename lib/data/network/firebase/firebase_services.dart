import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:morphydex/data/network/firebase/auth_services.dart';
import 'package:morphydex/main.dart';
import 'package:morphydex/models/scan_model.dart';
import 'package:morphydex/models/user_model.dart';
import 'package:morphydex/res/app_collections.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(File imageFile, String fileName) async {
    try {
      SettableMetadata metadata = SettableMetadata(
        contentType:
            'image/jpeg', // You can set the content type based on your image type
        customMetadata: {
          'uploadedBy': FirebaseAuthService.getCurrentUserID(),
        },
      );
      TaskSnapshot snapshot =
          await _storage.ref('images/$fileName').putFile(imageFile, metadata);
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
    }
    return null;
  }
}

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<UserModel?> fetchUserData() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection(FirebaseAuthService.getCurrentUserID())
          .doc()
          .get();

      final userModel = UserModel.fromMap(userSnapshot as Map<String, dynamic>);
      return userModel;
    } catch (e) {
      print("error in userModel $e");
      return null;
    }
  }

  static Future<List<ScanDetails>?> fetchScanDetails() async {
    try {
      QuerySnapshot scanSnapshot = await FirebaseFirestore.instance
          .collection(AppCollections.scansCollection)
          .where('uid', isEqualTo: FirebaseAuthService.getCurrentUserID())
          .get();
      List<ScanDetails> scans = scanSnapshot.docs.map((doc) {
        return ScanDetails.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return scans;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveScanDetails(ScanDetails scanDetails) async {
    try {
      // await _firestore
      //     .collection(AppCollections.scansCollection)
      //     .doc(scanDetails.scanId)
      //     .set(scanDetails.toMap());

      await _firestore
          .collection('scans')
          .doc(localUser!.token.toString())
          .collection('history')
          .doc(scanDetails.scanId)
          .set(scanDetails.toMap());
    } catch (e) {
      print('Error saving scan details: $e');
    }
  }
}
