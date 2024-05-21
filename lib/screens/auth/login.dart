import 'package:flutter/material.dart';
import 'package:mobile_app/components/buttons.dart';
import 'package:mobile_app/components/text_field.dart';
import 'package:mobile_app/constant/colors.dart';
import 'package:mobile_app/database/db_helper.dart';
import 'package:mobile_app/models/user_model.dart';
import 'package:mobile_app/screens/auth/signup.dart';
import 'package:mobile_app/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usrName = TextEditingController();
  final password = TextEditingController();

  bool isChecked = false;
  bool isLoginTrue = false;

  final db = DatabaseHelper();
  //User Login Method
  login() async {
    Users? usrDetails = await db.getUser(usrName.text);
    var res = await db.authenticate(
      Users(usrName: usrName.text, password: password.text),
    );
    if (res == true) {
      print('User id: ${usrDetails?.usrId}');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('usrId', usrDetails!.usrId!);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "LOGIN",
                  style: TextStyle(color: primaryColor, fontSize: 40),
                ),
                InputField(
                    hint: "Username",
                    icon: Icons.account_circle,
                    controller: usrName),
                InputField(
                    hint: "Password",
                    icon: Icons.lock,
                    controller: password,
                    passwordInvisible: true),
                ListTile(
                  horizontalTitleGap: 2,
                  title: const Text("Remember me"),
                  leading: Checkbox(
                    activeColor: primaryColor,
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                  ),
                ),
                Button(
                  label: "LOGIN",
                  press: () {
                    login();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text("SIGN UP"),
                    )
                  ],
                ),
                isLoginTrue
                    ? Text(
                        "Username or password is incorrect",
                        style: TextStyle(color: Colors.red.shade900),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
