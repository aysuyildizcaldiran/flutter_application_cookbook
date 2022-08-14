import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Post').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Center(
                child: ListTile(
              title: Text(
                data['name'],
                style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
              ),
              subtitle: Text(
                data['cookExplanation'],
                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white),
              ),
              trailing: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(data['image']),
              ),
            ));
          }).toList(),
        );
      },
    );
  }
}
