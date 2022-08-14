import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_cookbook/service/cook_service.dart';
import 'package:image_picker/image_picker.dart';

class CookAdd extends StatefulWidget {
  const CookAdd({Key? key}) : super(key: key);

  @override
  State<CookAdd> createState() => _CookAddState();
}

class _CookAddState extends State<CookAdd> {
  TextEditingController name = TextEditingController();
  TextEditingController cookExplanation = TextEditingController();
  final ImagePicker _pickerImage = ImagePicker();
  CookService cookService = CookService();
  dynamic _pickImage;
  dynamic _foodImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 20, right: 50, left: 50),
          child: TextField(
            controller: name,
            style: TextStyle(color: Colors.white),
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
              onPressed: () => _onImageButtonPressed(
                    ImageSource.gallery,
                    context: context,
                  ),
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: (_pickerImage == null) ? Image.file(File(_foodImage.path)) : Image.asset("assets/png/kamera.jpg")),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: cookExplanation,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            maxLength: 1000,
            cursorColor: Colors.white,
            decoration: _InputDecoration().tarifInput,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              cookService.addFood(cookExplanation.text, name.text, _foodImage);
            },
            child: Text("Tarif Ekle"),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        ),
      ]),
    );
  }

  void _onImageButtonPressed(ImageSource source, {required BuildContext context}) async {
    try {
      final pickedFile = await _pickerImage.pickImage(source: source);
      setState(() {
        _foodImage = pickedFile;
      });
    } catch (error) {
      setState(() {
        _pickImage = error;
      });
    }
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
  final tarifInput = InputDecoration(
    hintText: 'Tarif',
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 1.5, style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(15),
    ),
  );
}
