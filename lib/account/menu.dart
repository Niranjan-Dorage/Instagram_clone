import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login/login.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: SafeArea(
            child: Container(
                child: Column(children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.navigate_before_rounded,
                      color: Colors.white,
                      size: 40,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 7, left: 15),
                child: Text(
                  "Menu",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              )
            ],
          ),
          Container(
            width: 200,
            height: 60,
            margin: EdgeInsets.only(top: 300),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 47, 47, 47),
                borderRadius: BorderRadius.circular(10)),
            child: TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Loginpage()));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 17),
                )),
          )
        ]))));
  }
}
