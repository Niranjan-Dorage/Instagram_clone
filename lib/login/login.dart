
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:insta_clone/main.dart';
import 'new_user.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn(context) async {
    // show loading circle
    showDialog(
                                        barrierDismissible: false,

      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyAppp(),
          ));
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
        wrongEmailMessage(context);
      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        // show error to user
        wrongPasswordMessage(context);
      }
    }
  }

  // wrong email message popup
  void wrongEmailMessage(context) {
    // call this method here to hide soft keyboard
    FocusScope.of(context).requestFocus(new FocusNode());
    showDialog(

      context: context,
      builder: (BuildContext context) {
        return Container(
          child: const AlertDialog(
            backgroundColor: Color.fromARGB(255, 69, 69, 69),
            title: Center(
              child: Text(
                'Incorrect Email',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
        );
      },
    );
   
  }

  // wrong password message popup
  void wrongPasswordMessage(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: const AlertDialog(
            backgroundColor: Color.fromARGB(255, 69, 69, 69),
            title: Center(
              child: Text(
                'Incorrect Password',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
        );
      },
    );
   
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 150, bottom: 35),
                child: Image.asset(
                  'assets/images/logog.png',

                  // fit: BoxFit.fill,
                  // fit: BoxFit.fill,
                ),
                height: 120,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                margin: EdgeInsets.only(left: 15, right: 15),
                height: 45,
                decoration: BoxDecoration(
                  color: Color.fromARGB(151, 69, 69, 69),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                    fontFamily: "roboto",
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 17,
                      fontFamily: 'roboto',
                    ),
                    hintText: 'Enter Gmail',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                margin:
                    EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 12),
                height: 45,
                decoration: BoxDecoration(
                  color: Color.fromARGB(151, 69, 69, 69),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                    fontFamily: "roboto",
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 17,
                      fontFamily: 'roboto',
                    ),
                    hintText: 'Enter Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 45,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 179, 210),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextButton(
                    onPressed: () {
                      signUserIn(context);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'right',
                          fontSize: 22),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Center(
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                ),
              ),
              // Expanded(child: Text("")),

              Container(
                margin: EdgeInsets.only(top: 230),
                child: TextButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(new FocusNode());

                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(seconds: 1),
                        type: PageTransitionType.leftToRight,
                        child: new_user(),
                      ),
                    );
                  },
                  child: Text(
                    'New User? Create Account',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ]))));
  }
}
