import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:insta_clone/provider/followbuttonprovider.dart';
import 'package:insta_clone/provider/redlikeprovider.dart';
import 'package:insta_clone/provider/themechanger.dart';
import 'package:provider/provider.dart';
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
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Redlikeprovider()),
        ChangeNotifierProvider(create: (_) => Followbuttonprovider()),
        ChangeNotifierProvider(create: (_) => Themechanger()),
      ],
      child: Builder(builder: (BuildContext context) {
        final Thchanger = Provider.of<Themechanger>(context);
        return MaterialApp(
            themeMode: Thchanger.thememode,
            darkTheme: ThemeData(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: const Color.fromARGB(
                      255, 255, 255, 255), // Set the cursor color
                ),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        // ignore: deprecated_member_use
                        primary: const Color.fromARGB(255, 255, 255, 255))
                        ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.black,
                  selectedIconTheme: IconThemeData(
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  unselectedIconTheme:
                      IconThemeData(color: Color.fromARGB(255, 104, 104, 104)),
                ),
                tabBarTheme: TabBarTheme(),
                appBarTheme: AppBarTheme(
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                scaffoldBackgroundColor: Colors.black,
                brightness: Brightness.dark,
                iconTheme: IconThemeData(
                    color: const Color.fromARGB(255, 255, 255, 255))),
            theme: ThemeData(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor:
                      Color.fromARGB(255, 0, 0, 0), // Set the cursor color
                ),
                textButtonTheme: TextButtonThemeData(
                    // ignore: deprecated_member_use
                    style: TextButton.styleFrom(primary: Colors.black)
                    ),
                primaryColor: Colors.black,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  selectedIconTheme:
                      IconThemeData(color: Color.fromARGB(255, 63, 63, 63)),
                  unselectedIconTheme:
                      IconThemeData(color: Color.fromARGB(255, 146, 146, 146)),
                ),
                tabBarTheme: TabBarTheme(
                  unselectedLabelColor:
                      Colors.grey, // Set unselected icon color
                  labelColor: Colors.blue, // Set selected icon color
                ),
                appBarTheme: AppBarTheme(
                    color: Color.fromARGB(255, 255, 255, 255),
                    iconTheme: IconThemeData(
                        color: const Color.fromARGB(255, 0, 0, 0)), // Se
                    titleTextStyle:
                        TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                iconTheme: IconThemeData(
                    color: Color.fromARGB(255, 0, 0, 0)) //<-- SEE HERE
                ),
            debugShowCheckedModeBanner: false,
            home: login_status());
      })));
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
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
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/video.png"),
            ),
            label: 'reels',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/more.png"),
            ),
            label: 'reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 32,
            ),
            label: 'Account',
          ),
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
        children: [useristp(), Search(), Reels(), Createpost(), Account()],
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
