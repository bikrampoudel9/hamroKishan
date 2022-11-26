import 'package:flutter/material.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'package:hami_kishan/homepage.dart';
import 'package:hami_kishan/sign_up.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  static const defaultPadding = 10.0;

  void loginUser(String email, String password) async {
    String ip = Constants.ip;
    String url = "http://" + ip + "/hackathon/login.php";
    var uri = Uri.parse(url);

    var response =
        await http.post(uri, body: {'email': email, 'password': password});

    if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: "User has not been registered!");
    } else if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Log in successfully !");
      // var storage = FlutterSession();
      // await storage.set("USER_EMIAL", email);
      Constants.USER_EMAIL = email;
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const Homepage();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontSize: 15),
        ),
        toolbarHeight: 40,
      ),
      body: Column(
        children: [
          //Textfield for email
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            //Textfield for password
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          //Login button
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                String email = emailController.text.trim();
                String password = passwordController.text;
                loginUser(email, password);
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Row(
            children: [
              const Text("Dont have an account?"),
              GestureDetector(
                onTap: () => {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const SignUp();
                    },
                  )),
                },
                child: const Text(
                  "Sign Up?",
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
