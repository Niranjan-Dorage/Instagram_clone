import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login/login.dart';
import '../provider/themechanger.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final Thchanger = Provider.of<Themechanger>(context);

    return Scaffold(
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
                  size: 40,
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, left: 15),
            child: Text(
              "MENU",
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: 20),
        child: RadioListTile(
          title: Text(
            "Dark Mode",
            style: TextStyle(),
          ),
          value: ThemeMode.dark,
          groupValue: Thchanger.thememode,
          onChanged: Thchanger.setTheme,
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10),
        child: RadioListTile(
          title: Text(
            "Lite Mode",
          ),
          value: ThemeMode.light,
          groupValue: Thchanger.thememode,
          onChanged: Thchanger.setTheme,
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10),
        child: RadioListTile(
          title: Text(
            "System Default Mode",
          ),
          value: ThemeMode.system,
          groupValue: Thchanger.thememode,
          onChanged: Thchanger.setTheme,
        ),
      ),
      Container(
        width: 200,
        height: 60,
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Color.fromARGB(56, 98, 98, 98),
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
