import 'package:flutter/material.dart';
import 'package:flutter_application_cookbook/service/auth_service.dart';
import 'package:flutter_application_cookbook/view/home.dart';
import 'package:flutter_application_cookbook/view/homepage.dart';
import 'package:flutter_application_cookbook/view/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isVisible = true;
  bool _isLoading = false;

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
          padding: EdgeInsets.only(top: 150, right: 30, left: 30),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
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
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.visiblePassword,
                autofocus: true,
                autofillHints: const [AutofillHints.password],
                textInputAction: TextInputAction.next,
                decoration: _InputDecarotor().passwordInput,
              ),
            ),
            InkWell(
              child: Text(
                "Hesabınız yok mu? Kaydol ",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Color.fromARGB(255, 209, 207, 207)),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 223, 212, 211))),
                  onPressed: () => _loginWithEmail(),
                  child: Text(
                    "Giriş Yap",
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

  void _loginWithEmail() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      _authService
          .signInWithEmail(
        _emailController.text,
        _passwordController.text,
      )
          .then((value) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Home()), (route) => false);
      });
    }
  }
}

class _InputDecarotor {
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
