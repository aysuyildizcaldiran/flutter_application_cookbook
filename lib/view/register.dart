import 'package:flutter/material.dart';
import 'package:flutter_application_cookbook/service/auth_service.dart';
import 'package:flutter_application_cookbook/view/home.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/png/login.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(50),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                autofocus: true,
                autofillHints: [AutofillHints.name],
                textInputAction: TextInputAction.next,
                decoration: _InputDecarotor().nameInput,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.name,
                autofocus: true,
                autofillHints: [AutofillHints.email],
                textInputAction: TextInputAction.next,
                decoration: _InputDecarotor().emailInput,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _telephoneController,
                keyboardType: TextInputType.phone,
                autofocus: true,
                autofillHints: const [AutofillHints.telephoneNumber],
                textInputAction: TextInputAction.next,
                decoration: _InputDecarotor().telephoneInput,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                autofocus: true,
                autofillHints: const [AutofillHints.password],
                textInputAction: TextInputAction.next,
                decoration: _InputDecarotor().passwordInput,
              ),
            ),
            InkWell(
              child: Text(
                "Hesabınız var mı? Giriş Yap ",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Color.fromARGB(255, 209, 207, 207)),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    _registerOnTap();
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 223, 212, 211))),
                  child: Text(
                    "Kaydol",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _registerOnTap() {
    if (_nameController.text.isNotEmpty && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      _authService
          .createPerson(
              _nameController.text, _emailController.text, _passwordController.text, _telephoneController.text)
          .then((value) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Home()), (route) => false);
      });
    }
  }
}

class _InputDecarotor {
  final telephoneInput = InputDecoration(
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
      hintText: 'Telefon Numarası',
      prefixIcon: const Icon(
        Icons.phone,
        color: Colors.grey,
      ),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)));

  final passwordInput = InputDecoration(
    hintText: 'Şifre',
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
    prefixIcon: const Icon(
      Icons.password,
      color: Colors.grey,
    ),
    suffixIcon: const Icon(
      Icons.visibility_off,
      color: Colors.grey,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );
  final emailInput = InputDecoration(
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
      hintText: 'Email',
      prefixIcon: const Icon(
        Icons.email,
        color: Colors.grey,
      ),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)));
  final nameInput = InputDecoration(
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
      hintText: 'Name',
      prefixIcon: const Icon(
        Icons.person,
        color: Colors.grey,
      ),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)));
}
