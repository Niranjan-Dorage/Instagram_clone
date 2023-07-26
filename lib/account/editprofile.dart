import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Editprofile extends StatelessWidget {
  File? file;
  ImagePicker image = ImagePicker();
  String imageurl = "";
  String uniquefilename = "";
  Editprofile({required this.uniquefilename});

  void deleteImage() async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child('images/$uniquefilename')
          .delete();
      print('Image deleted successfully.');
    } catch (error) {
      print('Failed to delete image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final usernamecontroller = TextEditingController();
    final phonecontroller = TextEditingController();

    final Stream<QuerySnapshot> userstream = FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots();
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.navigate_before_rounded,
                        size: 40,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ],
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: userstream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container(
                child: Column(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Column(
                      children: [
                        Center(
                            child: Container(
                                width: 200,
                                height: 200,
                                margin: EdgeInsets.only(top: 50),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(data['imageurl'])),
                                    borderRadius: BorderRadius.circular(1000),
                                    color: Color.fromARGB(163, 62, 62, 62)),
                                child: IconButton(
                                    onPressed: () async {
                                      deleteImage();

                                      PickedFile? file =
                                          // ignore: deprecated_member_use
                                          await image.getImage(
                                              source: ImageSource.gallery);

                                      if (file == null) return;

                                      Reference referenceRoot =
                                          FirebaseStorage.instance.ref();
                                      Reference referenceDirImages =
                                          referenceRoot.child('images');
                                      Reference referenceimagetoupload =
                                          referenceDirImages
                                              .child(uniquefilename);

                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          });
                                      UploadTask uploadTask =
                                          referenceimagetoupload
                                              .putFile(File(file.path));

                                      uploadTask.whenComplete(() async {
                                        try {
                                          imageurl =
                                              await referenceimagetoupload
                                                  .getDownloadURL();
                                        } catch (onError) {
                                          print("Error");
                                        }
                                        Navigator.of(context).pop();
                                        print(imageurl);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 100,
                                      color: Color.fromARGB(119, 255, 255, 255),
                                    )))),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          margin: EdgeInsets.only(
                              top: 35, left: 15, right: 15, bottom: 20),
                          height: 45,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(151, 69, 69, 69),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: usernamecontroller,
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
                          margin:
                              EdgeInsets.only(left: 15, right: 15, bottom: 20),
                          height: 45,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(151, 69, 69, 69),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: phonecontroller,
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
                        Row(
                          children: [
                            Expanded(child: Text("")),
                            Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 213, 255),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(right: 15, top: 10),
                              child: TextButton(
                                  onPressed: () async {
                                    if (usernamecontroller.text != "") {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser?.uid)
                                          .update({
                                        'username': usernamecontroller.text
                                      });
                                    }
                                    if (phonecontroller.text != "") {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser?.uid)
                                          .update(
                                              {'phone': phonecontroller.text});
                                    }
                                    if (imageurl != "") {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser?.uid)
                                          .update({'imageurl': imageurl});
                                    }
                                  },
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  )),
                            )
                          ],
                        )
                      ],
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
