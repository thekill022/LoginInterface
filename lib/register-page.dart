import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final VoidCallback showLoginPage;
  const Register({super.key, required this.showLoginPage});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirm = TextEditingController();
  TextEditingController _fisrtname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  String helper = '';
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    _fisrtname.dispose();
    _lastname.dispose();
    super.dispose();
  }

  Future<void> SignUp() async {
    if (confirmPass()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _email.text.trim(), password: _password.text.trim());

        String uid = userCredential.user!.uid; // Get the UID

        await UserDetail(
          _fisrtname.text.trim(),
          _lastname.text.trim(),
          _email.text.trim(),
          uid,
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          helper = e.message ?? 'An error occurred';
        });
      }
    }
  }

  bool confirmPass() {
    if (_password.text.trim() == _confirm.text.trim()) {
      return true;
    } else {
      setState(() {
        helper = 'Passwords do not match';
      });
      return false;
    }
  }

  Future<void> UserDetail(String fName, String Lname, int age, String email,
      String Jkelamin, String DiabetType, String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'nama depan': fName,
      'nama belakang': Lname,
      'email': email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 80),
                          child: Icon(
                            Icons.person_add_alt_1_rounded,
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
                            top: MediaQuery.of(context).size.height / 3.3),
                        width: 400,
                        height: 950,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Transform.translate(
                              offset: Offset(0, -20),
                              child: Column(
                                children: [
                                  Text(
                                    "Register",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 40,
                                        color: Colors.blue),
                                  ),
                                  Text("Buat Akun Pertama Anda"),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 40, right: 40, top: 20),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintText: "Nama Depan",
                                    helperStyle: TextStyle(color: Colors.red)),
                                controller: _fisrtname,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 40, right: 40, top: 20),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintText: "Nama Belakang",
                                    helperStyle: TextStyle(color: Colors.red)),
                                controller: _lastname,
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
                                ),
                                obscureText: true,
                                controller: _password,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 40, right: 40, top: 20),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintText: "Konfirmasi Password",
                                    helperText: helper,
                                    helperStyle: TextStyle(color: Colors.red)),
                                controller: _confirm,
                                obscureText: true,
                              ),
                            ),
                            
                            Container(
                                margin: EdgeInsets.only(
                                    left: 30, right: 30, top: 20, bottom: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                width: 480,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    SignUp();
                                  },
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.blue)),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("I am a Member"),
                                GestureDetector(
                                  onTap: widget.showLoginPage,
                                  child: Text(
                                    " Login Now",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
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
          ],
        ),
      ),
    );
  }
}
