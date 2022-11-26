import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hami_kishan/constants.dart';
import 'package:hami_kishan/log_in.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  CircularProgressIndicator progressIndicator =
      const CircularProgressIndicator();

  void registerUser(String name, String email, String password) async {
    String ip = Constants.ip;
    String url = "http://" + ip + "/hackathon/sign_up.php";
    var uri = Uri.parse(url);

    var response = await http.post(uri,
        body: {'full_name': name, 'email': email, 'password': password});
    if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: "Email is already registered!");
    } else if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "User registered successfully!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    const defaultPadding = 10.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 15),
        ),
        toolbarHeight: 40,
      ),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: "Your full name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onSaved: (email) {},
              decoration: const InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
            TextFormField(
              controller: contactController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Your number",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
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
            const SizedBox(height: defaultPadding / 2),
            // TextFormField(
            //   textInputAction: TextInputAction.done,
            //   obscureText: true,
            //   decoration: const InputDecoration(
            //     hintText: "Confirm password",
            //     prefixIcon: Padding(
            //       padding: EdgeInsets.all(defaultPadding),
            //       child: Icon(Icons.lock),
            //     ),
            //   ),
            // ),
            ElevatedButton(
              onPressed: () {
                String fullName = nameController.text.trim();
                String email = emailController.text.trim();
                String number = contactController.text.trim();
                String password = passwordController.text;

                if (fullName.isEmpty ||
                    email.isEmpty ||
                    number.isEmpty ||
                    password.isEmpty) {
                  Fluttertoast.showToast(msg: "Fill all the fields!!");
                } else {
                  registerUser(fullName, email, password);
                }
              },
              child: Text("Sign Up".toUpperCase()),
            ),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                const Text("Already have an account?"),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const Login();
                      },
                    )),
                  },
                  child: const Text(
                    "Login In?",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class SignUp extends StatelessWidget {
//   const SignUp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     const defaultPadding = 10.0;
//     return Scaffold(
//       body: Form(
//         child: Column(
//           children: [
//             TextFormField(
//               keyboardType: TextInputType.emailAddress,
//               textInputAction: TextInputAction.next,
//               onSaved: (email) {},
//               decoration: const InputDecoration(
//                 hintText: "Your email",
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.person),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//               child: TextFormField(
//                 textInputAction: TextInputAction.done,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   hintText: "Your password",
//                   prefixIcon: Padding(
//                     padding: EdgeInsets.all(defaultPadding),
//                     child: Icon(Icons.lock),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: defaultPadding / 2),
//             TextFormField(
//               textInputAction: TextInputAction.done,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 hintText: "Confirm password",
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.lock),
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {},
//               child: Text("Sign Up".toUpperCase()),
//             ),
//             const SizedBox(height: defaultPadding),
//             Row(
//               children: [
//                 const Text("Already have an account?"),
//                 GestureDetector(
//                   onTap: () => {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return const Login();
//                       },
//                     )),
//                   },
//                   child: const Text(
//                     "Login In?",
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
