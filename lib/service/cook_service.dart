import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_cookbook/service/storage.dart';
import 'package:image_picker/image_picker.dart';

import '../model/Cook.dart';

class CookService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();
  String _mediaUrl = '';

  Future<Cook> addFood(String cookExplanation, String name, XFile pickedFile) async {
    var ref = _firestore.collection("Post");
    _mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));

    var documentRef = await ref.add({'cookExplanation': cookExplanation, 'name': name, 'image': _mediaUrl});

    return Cook(postId: documentRef.id, cookExplanation: cookExplanation, name: name, image: _mediaUrl);
  }

  Stream<QuerySnapshot> getFood() {
    var ref = _firestore.collection("Post").snapshots();

    return ref;
  }

  Future<void> removeFood(String postId) {
    var ref = _firestore.collection("Post").doc(postId).delete();

    return ref;
  }
}
