import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../usertp/comments.dart';
import '../usertp/largeimg.dart';
import 'chatpage.dart';

// ignore: must_be_immutable
class Friendaccount extends StatefulWidget {
  String userid = "";
  Friendaccount({required this.userid});
  @override
  State<Friendaccount> createState() => FriendaccountState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class FriendaccountState extends State<Friendaccount>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String username = "";
    String profile = "";
    Size size = MediaQuery.of(context).size;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: widget.userid)
        .snapshots();

    final Stream<QuerySnapshot> postts = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userid)
        .collection('data')
        .doc(widget.userid)
        .collection('posts').orderBy('Timestamp', descending: false)
        .snapshots();
    final Stream<QuerySnapshot> posts = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userid)
        .collection('data')
        .doc(widget.userid)
        .collection('posts')
        .orderBy('Timestamp', descending: false)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              username = data['username'];
              profile = data['imageurl'];
              return Expanded(
                child: Scaffold(
                  backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    toolbarHeight: 293,
                    title: Column(children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 0, 0, 0),
                                borderRadius: BorderRadius.circular(10)),
              
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                data['username'],
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
              
                            // child: Text(
                            //   userId!.uid,
                            //   style: TextStyle(fontSize: 14),
                            // )),
                          ),
                          Container(
                              child: Text(
                            "",
                            style: TextStyle(fontSize: 14),
                          )),
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            child: IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 29,
                                  color: Colors.white,
                                )),
                          ),
                          Expanded(child: Text("")),
                          // Container(
                          //   width: 38,
                          //   margin: EdgeInsets.only(left: 10),
                          //   child: IconButton(
                          //     onPressed: () {
                          //       Navigator.push(
                          //         context,
                          //         PageTransition(
                          //           duration: Duration(seconds: 1),
                          //           type: PageTransitionType.leftToRight,
                          //           child: Create(),
                          //         ),
                          //       );
                          //     },
                          //     icon: Image.asset("assets/images/more.png"),
                          //     color: Colors.white,
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: IconButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   PageTransition(
                                  //     duration: Duration(seconds: 1),
                                  //     type: PageTransitionType.bottomToTop,
                                  //     child: Menu(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.menu,
                                  size: 29,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => Largeimg(
                                                imglink: data['imageurl'],
                                              )));
                                }),
                                child: Container(
                                    margin:
                                        EdgeInsets.only(top: 25, left: 10),
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(300),
                                        color: const Color.fromARGB(
                                            255, 109, 109, 109),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                data['imageurl'])))),
                              ),
                            ],
                          ),
                          Expanded(child: Text("")),
                          Container(
                            margin: EdgeInsets.only(top: 28),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    "Posts",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(child: Text("")),
                          Container(
                            margin: EdgeInsets.only(top: 28),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    "28",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    "Followers",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(child: Text("")),
                          Container(
                            margin: EdgeInsets.only(top: 28),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    "21",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    "Following",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(child: Text("")),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "bio:",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: Row(
                          children: [
                            Expanded(child: Text("")),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 221, 255),
                                  borderRadius: BorderRadius.circular(7)),
                              height: 32,
                              width: size.width / 2.4,
                              margin: EdgeInsets.only(top: 20),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Follow",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0)),
                                  )),
                            ),
                            Expanded(child: Text("")),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 36, 36, 36),
                                  borderRadius: BorderRadius.circular(7)),
                              height: 32,
                              width: size.width / 2.4,
                              margin: EdgeInsets.only(top: 20),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => Chatpage(
                                                  friendimageurl: profile,
                                                  friendusername: username,
                                                  frienduserid:
                                                      data['userid'],
                                                )));
                                  },
                                  child: Text(
                                    "Message",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                            Expanded(child: Text("")),
                            // Container(
              
                            //   margin: EdgeInsets.only(top: 20),
                            //   width: 33,
                            //   height: 32,
                            //   child: IconButton(
                            //       onPressed: null,
                            //       icon: Icon(
                            //         Icons.person_add,
                            //         size: 17,
                            //         color: Colors.white,
                            //       )),
                            //   decoration: BoxDecoration(
                            //       color: Color.fromARGB(255, 36, 36, 36),
                            //       borderRadius: BorderRadius.circular(7)),
                            // )
                          ],
                        ),
                      ),
                    ]),
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: const <Widget>[
                        Tab(
                          icon: Icon(Icons.grid_on_outlined),
                        ),
                        Tab(
                          icon: Icon(Icons.person_pin_outlined),
                        ),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: posts,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }
              
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading..");
                            }
              
                            return Container(
                              margin: EdgeInsets.only(right: 15),
                              child: GridView.count(
                                crossAxisCount:
                                    3, // Number of columns in the grid
                                shrinkWrap: true,
                                physics:
                                    NeverScrollableScrollPhysics(), // Disable scrolling of the grid
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data = document.data()!
                                      as Map<String, dynamic>;
              
                                  return GestureDetector(
                                    onTap: (() {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Largeimg(
                                                    imglink: data['imagerul'],
                                                  )));
                                    }),
                                    child: Container(
                                      height: 200,
                                      margin:
                                          EdgeInsets.only(top: 15, left: 15),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 28, 28, 28),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              NetworkImage(data['imagerul']),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ),
                      SingleChildScrollView(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: postts,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }
              
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading..");
                            }
              
                            return Container(
                              child: Column(
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data = document.data()!
                                      as Map<String, dynamic>;
              
                                  return Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: Column(children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 35,
                                              height: 35,
                                              margin:
                                                  EdgeInsets.only(left: 15),
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 74, 74, 74),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          profile)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          150)),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              margin:
                                                  EdgeInsets.only(left: 15),
                                              child: Text(
                                                username,
                                                style: TextStyle(
                                                    wordSpacing: 3,
                                                    letterSpacing: 0.6,
                                                    fontSize: 15,
                                                    fontFamily: 'Right',
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(""),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 5),
                                              child: IconButton(
                                                  onPressed: null,
                                                  icon: const Icon(
                                                    Icons.more_vert,
                                                    color: Colors.white,
                                                    size: 27,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                      // InteractiveViewer(
                                      //     constrained: true,
                                      //     scaleEnabled: true,
                                      //     child:
                                      GestureDetector(
                                        onTap: (() {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Largeimg(
                                                        imglink:
                                                            data['imagerul'],
                                                      )));
                                        }),
                                        child: Container(
                                          height: 500,
                                          margin: EdgeInsets.only(
                                              left: 5, right: 0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: const Color.fromARGB(
                                                  255, 55, 55, 55),
                                              image: DecorationImage(
                                                  fit: BoxFit.fitWidth,
                                                  image: NetworkImage(
                                                      data['imagerul']))),
                                        ),
                                      ),
                                      // ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 15,
                                            left: 15,
                                            right: 15,
                                            bottom: 5),
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0),
                                        width: double.infinity,
                                        child: Text(
                                          data['text'],
                                          style:
                                              TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Row(children: [
                                        Container(
                                          // height: 25,
                                          // width: 45,
                                          // margin: EdgeInsets.only(left: 5s),
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons
                                                    .favorite_border_outlined,
                                                size: 32,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              )),
                                        ),
                                        Container(
                                          width: 40,
                                          child: IconButton(
                                              onPressed: () => Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .bottomToTop,
                                                      child: Comments(
                                                        // caption: data[
                                                        //     'text'],
                                                        userid: widget.userid,
              
                                                        postid:
                                                            data['Timestamp'],
                                                      ))),
                                              icon: Image.asset(
                                                  "assets/images/chat.png")),
                                        ),
                                        Container(
                                          width: 40,
                                          child: IconButton(
                                              onPressed: null,
                                              icon: Image.asset(
                                                  "assets/images/send.png")),
                                        ),
                                        Expanded(
                                          child: Text(""),
                                        ),
                                        Container(
                                          width: 45,
                                          margin: EdgeInsets.only(right: 5),
                                          child: IconButton(
                                              onPressed: null,
                                              icon: Image.asset(
                                                  "assets/images/mark.png")),
                                        ),
                                      ])
                                    ]),
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
