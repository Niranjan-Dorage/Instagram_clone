import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Createpost extends StatefulWidget {
  const Createpost({super.key});

  @override
  State<Createpost> createState() => _CreatepostState();
}

class _CreatepostState extends State<Createpost> {
  File? file;
  ImagePicker image = ImagePicker();
  @override
  Widget build(BuildContext context) {
    String uniquefilename = FirebaseAuth.instance.currentUser!.uid;
    // final docUser = FirebaseFirestore.instance.collection('users').doc();
    String imageurl = "";
    final describe = TextEditingController();

    DateTime timestamp = DateTime.now();
    String timestampString =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);

    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
          body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Row(
                  children: [
                    Expanded(child: Text("")),
                    Container(
                        height: 100,
                        width: size.width / 2.5,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(131, 106, 106, 106),
                            borderRadius: BorderRadius.circular(7)),
                        margin: EdgeInsets.only(top: 20),
                        child: TextButton(
                          onPressed: () async {
                            // ignore: deprecated_member_use
                            PickedFile? file =
                                // ignore: deprecated_member_use
                                await image.getImage(
                                    source: ImageSource.camera);
                            print('${file?.path}');

                            // setState(() {
                            //   file = File(img!.path);
                            // });
                            if (file == null) return;
                            ;
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('posts');
                            Reference referenceimagetoupload =
                                referenceDirImages
                                    .child('$uniquefilename$timestampString');

                            // try {
                            //   await referenceimagetoupload.putFile(File(file.path));
                            //   imageurl =
                            //       await referenceimagetoupload.getDownloadURL();
                            // } catch (error) {}
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                            UploadTask uploadTask =
                                referenceimagetoupload.putFile(File(file.path));

                            uploadTask.whenComplete(() async {
                              try {
                                imageurl = await referenceimagetoupload
                                    .getDownloadURL();
                              } catch (onError) {
                                print("Error");
                              }
                              Navigator.of(context).pop();
                              print(imageurl);
                            });
                          },
                          child: Column(children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                "Take a Pic",
                                style: TextStyle(
                                    // color: const Color.fromARGB(255, 0, 0, 0)
                                    ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Icon(
                                Icons.camera,
                                size: 28,
                              ),
                            )
                          ]),
                        )),
                    Expanded(child: Text("")),
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(131, 106, 106, 106),
                          borderRadius: BorderRadius.circular(7)),
                      height: 100,
                      width: size.width / 2.5,
                      margin: EdgeInsets.only(top: 20),
                      child: TextButton(
                        onPressed: () async {
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
                              referenceRoot.child('posts');
                          Reference referenceimagetoupload = referenceDirImages
                              .child('$uniquefilename$timestampString');

                          // try {
                          //   await referenceimagetoupload.putFile(File(file.path));
                          //   imageurl =
                          //       await referenceimagetoupload.getDownloadURL();
                          // } catch (error) {}
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(),
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
                        child: Column(children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              "Add From Device",
                              style: TextStyle(
                                  // color: const Color.fromARGB(255, 0, 0, 0)
                                  ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Icon(
                              Icons.storage_outlined,
                              size: 28,
                            ),
                          )
                        ]),
                      ),
                    ),
                    Expanded(child: Text("")),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 35),
                height: 45,
                decoration: BoxDecoration(
                  color: Color.fromARGB(131, 106, 106, 106),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: describe,
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                    fontFamily: "roboto",
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 17,
                      fontFamily: 'roboto',
                    ),
                    hintText: 'Add a note ...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 0, 200, 255),
                ),
                child: TextButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          });

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .collection('data')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .collection('posts')
                          .doc('$uniquefilename$timestampString')
                          .set({
                        'imagerul': imageurl,
                        'text': describe.text,
                        'Timestamp': '$uniquefilename$timestampString',
                      });
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .update({'postcount': FieldValue.increment(1)});
                      describe.text = "";
                      FocusScope.of(context).requestFocus(new FocusNode());

                      Navigator.pop(context);

                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => MyAppp(),
                      //     ));
                    },
                    child: Text(
                      "Create Post",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
