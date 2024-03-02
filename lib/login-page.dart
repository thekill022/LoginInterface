import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Login extends StatefulWidget {
  final VoidCallback ShowRegisteredPage;

  const Login({super.key, required this.ShowRegisteredPage});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  String helper = '';

  Future Signin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
      showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: 'Your Login Is Successfully',
            textAlign: TextAlign.center,
            backgroundColor: Colors.blue,
          ));
    } on Exception catch (e) {
      final e = 'Incorrect username or password';
      setState(() {
        helper = e.toString();
      });
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 80),
                        child: Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 100,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 3.2),
                      width: 400,
                      height: 550,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(100))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Transform.translate(
                            offset: Offset(0, -30),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 40,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 40, right: 40, top: 20),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: "Email",
                              ),
                              controller: _email,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 40, right: 40, top: 20),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: "Password",
                                  helperText: helper,
                                  helperStyle: TextStyle(color: Colors.red)),
                              obscureText: true,
                              controller: _password,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Transform.translate(
                                offset: Offset(0, 0),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: 50,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              width: 480,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Signin();
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.blue)),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?"),
                              GestureDetector(
                                onTap: widget.ShowRegisteredPage,
                                child: Text(
                                  " Register",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
