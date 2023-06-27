import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Editpost extends StatelessWidget {
  String Timestamp = "";
  String uniquefilename = FirebaseAuth.instance.currentUser!.uid;

  Editpost({required this.Timestamp});
  @override
  Widget build(BuildContext context) {
    void deleteImage() async {
      try {
        await FirebaseStorage.instance.ref().child('posts/$Timestamp').delete();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uniquefilename)
            .collection('data')
            .doc(uniquefilename)
            .collection('posts')
            .doc(Timestamp)
            .delete();
        print('Image deleted successfully.');
      } catch (error) {
        print('Failed to delete image: $error');
      }
    }

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              title: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.navigate_before_rounded,
                          color: Colors.white,
                          size: 40,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Edit Post",
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.black,
            body: Center(
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 47, 47, 47),
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                    onPressed: () {
                      deleteImage();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Delete Post",
                      style: TextStyle(fontSize: 17),
                    )),
              ),
            )),
      ),
    );
  }
}
