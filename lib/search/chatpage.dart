import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Chatpage extends StatelessWidget {
  String friendusername = "";
  String friendimageurl = "";
  String frienduserid = "";
  String currentuserid = FirebaseAuth.instance.currentUser!.uid;
  String currentusername = "";
  String chatroomid = "";

  Chatpage(
      {required this.friendimageurl,
      required this.friendusername,
      required this.frienduserid});

  @override
  Widget build(BuildContext context) {
    if (currentuserid[0].toLowerCase().codeUnits[0] >
        frienduserid[0].toLowerCase().codeUnits[0]) {
      chatroomid = "$currentuserid$frienduserid";
    } else {
      chatroomid = "$frienduserid$currentuserid";
    }

    final Stream<QuerySnapshot> myusername = FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: currentuserid)
        .snapshots();
    final Stream<QuerySnapshot> chatstream = FirebaseFirestore.instance
        .collection('Messages')
        .doc(chatroomid)
        .collection(chatroomid)
        .orderBy('timestamp', descending: false)
        .snapshots();
    final chatcontroller = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
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
                margin: EdgeInsets.only(right: 10, top: 3),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 28, 28, 28),
                  borderRadius: BorderRadius.circular(80),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(friendimageurl),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  friendusername,
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
              Expanded(child: Text("")),
              Container(
                margin: EdgeInsets.only(top: 5),
                width: 40,
                child: IconButton(
                    onPressed: () async {
                      print(currentusername);
                      await FirebaseFirestore.instance
                          .collection('Messages')
                          .doc(chatroomid)
                          .collection(chatroomid)
                          .doc()
                          .set({
                        'messagecontent': chatcontroller.text,
                        'username': currentusername,
                        'timestamp': DateTime.now(),
                      });
                      chatcontroller.text = "";
                    },
                    icon: Image(image: AssetImage("assets/images/send.png"))),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 21, 21, 21),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: myusername,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return Container(
                          child: Column(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              currentusername = data['username'];
                              print(currentusername);
                              return Container();
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: chatstream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return Container(
                          child: Column(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;

                              if (data['username'] == currentusername) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 38, 38, 38),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            left: 20, right: 10, top: 5),
                                        child: Text(
                                          data['username'],
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 1, 218, 252),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 10,
                                            top: 10,
                                            bottom: 10),
                                        child: Text(
                                          data['messagecontent'],
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 29, 29, 29),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            left: 20, right: 10, top: 5),
                                        child: Text(
                                          data['username'],
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 1, 218, 252),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 10,
                                            top: 10,
                                            bottom: 10),
                                        child: Text(
                                          data['messagecontent'],
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0.5),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(bottom: 10, left: 2, right: 2),
              child: TextField(
                controller: chatcontroller,
                cursorColor: Color.fromARGB(255, 0, 203, 200),
                keyboardType: TextInputType.name,
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 0, 0, 0),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
                  hintText: 'message privately here . . . .',
                  contentPadding:
                      new EdgeInsets.symmetric(vertical: 30, horizontal: 8.0),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
