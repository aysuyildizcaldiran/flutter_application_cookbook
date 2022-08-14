import 'package:cloud_firestore/cloud_firestore.dart';

class Cook {
  String postId;
  String name;
  String cookExplanation;
  String image;

  Cook({required this.postId, required this.cookExplanation, required this.name, required this.image});

  factory Cook.fromSnapshot(DocumentSnapshot snapshot) {
    return Cook(
        postId: snapshot.id,
        cookExplanation: snapshot["cookexplanation"],
        name: snapshot["cookname"],
        image: snapshot["image"]);
  }
}
