import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class new_user extends StatefulWidget {
  const new_user({super.key});
  @override
  State<new_user> createState() => _new_userState();
}

class _new_userState extends State<new_user> {
  String doc = "";
  String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
  String unique = "";
  int valuee = 0;

  String email = "", pass = "", phone = "", username = "", imageurl = "";
  // final docUser = FirebaseFirestore.instance.collection('users').doc();
  File? file;
  ImagePicker image = ImagePicker();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: Container(
          child: ListView(scrollDirection: Axis.vertical, children: [
            Row(
              children: [
                Container(
                  child: IconButton(
                      icon: Icon(Icons.navigate_before_rounded),
                      iconSize: 46,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                        fontFamily: 'right',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 20),
              height: 45,
              decoration: BoxDecoration(
                color: Color.fromARGB(151, 69, 69, 69),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: (value) => username = value,
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
                  hintText: 'Enter Username',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
              height: 45,
              decoration: BoxDecoration(
                color: Color.fromARGB(151, 69, 69, 69),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: (value) => phone = value,
                keyboardType: TextInputType.phone,
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
                  hintText: 'Enter Phone No',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
              height: 45,
              decoration: BoxDecoration(
                color: Color.fromARGB(151, 69, 69, 69),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: (value) => email = value,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontFamily: "roboto",
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 17,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 248, 248),
                    fontSize: 17,
                    fontFamily: 'roboto',
                  ),
                  hintText: 'Enter Gmail',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            // Con
            Container(
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 12),
              height: 45,
              decoration: BoxDecoration(
                color: Color.fromARGB(151, 69, 69, 69),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: (value) => pass = value,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
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

            Center(
              child: Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.only(top: 25, bottom: 5),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(198, 208, 208, 208),
                      borderRadius: BorderRadius.circular(120)),
                  child: IconButton(
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());

                        // ignore: deprecated_member_use
                        PickedFile? file =
                            // ignore: deprecated_member_use
                            await image.getImage(source: ImageSource.gallery);
                        print('${file?.path}');

                        // setState(() {
                        //   file = File(img!.path);
                        // });
                        if (file == null) return;
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');
                        Reference referenceimagetoupload =
                            referenceDirImages.child(uniquefilename);

                        // try {
                        //   await referenceimagetoupload.putFile(File(file.path));
                        //   imageurl =
                        //       await referenceimagetoupload.getDownloadURL();
                        // } catch (error) {}

                        showDialog(
                            context: context,
                            builder: (context) {
                              return Container(
                                width: size.width,
                                height: size.height,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            });
                        UploadTask uploadTask =
                            referenceimagetoupload.putFile(File(file.path));

                        uploadTask.whenComplete(() async {
                          try {
                            imageurl =
                                await referenceimagetoupload.getDownloadURL();
                          } catch (onError) {
                            print("Error");
                          }

                          Navigator.of(context).pop();

                          print(imageurl);
                        });
                      },
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.black,
                        size: 29,
                      )),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 45,
                width: double.infinity,
                margin: EdgeInsets.only(top: 30, left: 15, right: 15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 170, 217),
                    borderRadius: BorderRadius.circular(30)),
                child: TextButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                    try {
                      print("hello " + email + "  " + pass);
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: pass,
                      );

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .set({
                        'email': email,
                        'imageurl': imageurl,
                        'phone': phone,
                        'userid': FirebaseAuth.instance.currentUser?.uid,
                        'username': username,
                        'postcount': valuee,
                        'followercount': valuee,
                        'followingcount': valuee,
                        'uniquefilename': uniquefilename,
                      });

                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => editname()));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'email-already-in-use') {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                // Retrieve the text the that user has entered by using the
                                // TextEditingController.
                                content: SizedBox(
                                  height: 40,
                                  // width: 450,
                                  // margin: EdgeInsets.only(top: 200),
                                  child: Center(
                                      child: SizedBox(
                                    // width: 450.0,
                                    height: 40,

                                    child: DefaultTextStyle(
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 27.0,
                                          fontFamily: 'right'),
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          for (int i = 0; i < 2; i++)
                                            TypewriterAnimatedText(
                                                'email-already-in-use'),
                                        ],
                                        onTap: () {
                                          print("Tap Event");
                                        },
                                      ),
                                    ),
                                  )),
                                ),
                              );
                            });
                        Timer(Duration(seconds: 3), () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      } else if (e.code == 'weak-password') {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                // Retrieve the text the that user has entered by using the
                                // TextEditingController.
                                content: SizedBox(
                                  height: 40,
                                  // width: 450,
                                  // margin: EdgeInsets.only(top: 200),
                                  child: Center(
                                      child: SizedBox(
                                    // width: 450.0,
                                    height: 40,

                                    child: DefaultTextStyle(
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 27.0,
                                          fontFamily: 'right'),
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          for (int i = 0; i < 2; i++)
                                            TypewriterAnimatedText(
                                                'Weak-Password'),
                                        ],
                                        onTap: () {
                                          print("Tap Event");
                                        },
                                      ),
                                    ),
                                  )),
                                ),
                              );
                            });
                        Timer(Duration(seconds: 3), () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    'Create',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'right', fontSize: 22),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
