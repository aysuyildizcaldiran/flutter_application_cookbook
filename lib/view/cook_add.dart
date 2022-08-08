import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CookAdd extends StatefulWidget {
  const CookAdd({Key? key}) : super(key: key);

  @override
  State<CookAdd> createState() => _CookAddState();
}

class _CookAddState extends State<CookAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 20, right: 50, left: 50),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            autofillHints: [AutofillHints.postalAddressExtended],
            textInputAction: TextInputAction.next,
            decoration: _InputDecoration().tarifismiInput,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 100, left: 100),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(primary: Colors.black),
            child: const Image(
              image: AssetImage("assets/png/kamera.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        )
      ]),
    );
  }
}

class _InputDecoration {
  final tarifismiInput = InputDecoration(
    hintText: 'Tarif İsmi',
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );
}
