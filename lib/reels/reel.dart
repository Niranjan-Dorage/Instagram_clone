import 'package:flutter/material.dart';

class Reels extends StatelessWidget {
  const Reels({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Container(child: Text("Reels",style: TextStyle(fontSize: 20,color: Colors.white),)),
      ),
    );
  }
}