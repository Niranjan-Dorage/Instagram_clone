import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Comments extends StatelessWidget {
  // String caption = "" ;
  String userid = "";
  String postid = "";
  Comments({required this.postid, required this.userid});

  @override
  Widget build(BuildContext context) {
    String username = "";
    final Stream<QuerySnapshot> myusername = FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots();

    final Stream<QuerySnapshot> userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('data')
        .doc(userid)
        .collection('posts')
        .doc(postid)
        .collection('comments')
        .orderBy('timestamp', descending: false)
        .snapshots();

    final commentcontroller = TextEditingController();

    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Container(
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.navigate_before_rounded,
                      size: 40,
                    )),
              ),
              Expanded(child: Text("")),
              Container(
                child: Text(
                  "Comments",
                  style: TextStyle(fontSize: 21),
                ),
              ),
              Expanded(child: Text("")),
              Container(
                  width: 44,
                  child: IconButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userid)
                            .collection('data')
                            .doc(userid)
                            .collection('posts')
                            .doc(postid)
                            .collection('comments')
                            .add({
                          'commentText': commentcontroller.text,
                          'timestamp': DateTime.now(),
                          'username': username,
                        });
                        commentcontroller.text = "";
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      icon: ImageIcon(AssetImage("assets/images/send.png")))),
            ],
          ),
        ),
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
                              username = data['username'];
                              return Container();
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: userStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("");
                        }

                        return Container(
                          child: Column(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;

                              return Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromARGB(179, 67, 67, 67),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
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
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          data['commentText'],
                                          // Aligns text at the center horizontally

                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0.5),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
              child: TextField(
                controller: commentcontroller,
                cursorColor: Color.fromARGB(255, 0, 203, 200),
                keyboardType: TextInputType.name,
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(173, 51, 51, 51),
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
                  hintText: 'Add your comment here....',
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
