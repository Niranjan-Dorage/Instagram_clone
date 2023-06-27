import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login/login.dart';
import 'usertp/usertp.dart';
import 'create/create.dart';
import 'account/account.dart';
import 'search/search.dart';
import 'reels/reel.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(
            color: Color.fromARGB(255, 255, 255, 255)), //<-- SEE HERE
      ),
      debugShowCheckedModeBanner: false,
      home: login_status()));
}

// ignore: must_be_immutable
class MyAppp extends StatefulWidget {
  @override
  State<MyAppp> createState() => _MyApppState();
}

class _MyApppState extends State<MyAppp> {
  int _currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Color.fromARGB(255, 176, 175, 175),
        backgroundColor: Colors.black,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              label: 'home',
              icon: ImageIcon(
                AssetImage("assets/images/home.png"),
              )),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/search.png"),
              ),
              label: 'Search',
              backgroundColor: Color.fromARGB(255, 0, 0, 0)),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/video.png"),
              ),
              label: 'reels',
              backgroundColor: Color.fromARGB(255, 0, 0, 0)),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/more.png"),
              ),
              label: 'reels',
              backgroundColor: Color.fromARGB(255, 0, 0, 0)),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 32,
              ),
              label: 'Account',
              backgroundColor: Color.fromARGB(255, 0, 0, 0)),
        ],
        onTap: (index) {
          // if (index == 1) {
          //   Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(builder: (context) => Comments()));
          // }
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() {
          _currentIndex = index;
        }),
        children: [useristp(), Search(), Reels(), Create(), Account()],
      ),
    );
  }
}

// ignore: must_be_immutable
class login_status extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return SafeArea(child: MyAppp()); //  in
    } else {
      return Loginpage(); //  in
      // signed out
    }
  }
}
