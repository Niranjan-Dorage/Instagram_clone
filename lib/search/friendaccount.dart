import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../provider/followbuttonprovider.dart';
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
        .collection('posts')
        .orderBy('Timestamp', descending: false)
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
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: 293,
                    title: Column(children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
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
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 29,
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Largeimg(
                                            imglink: data['imageurl'],
                                          )));
                                }),
                                child: Container(
                                    margin: EdgeInsets.only(top: 25, left: 10),
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(300),
                                        color:
                                            Color.fromARGB(103, 109, 109, 109),
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
                                    data['postcount'].toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    "Posts",
                                    style: TextStyle(fontSize: 14),
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
                                    data['followercount'].toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    "Followers",
                                    style: TextStyle(fontSize: 14),
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
                                    data['followingcount'].toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    "Following",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(child: Text("")),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15, bottom: 20),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "bio:",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: Row(
                          children: [
                            Expanded(child: Text("")),
                            Consumer<Followbuttonprovider>(
                              builder: (context, value, child) {
                                print("build");
                                return TextButton(
                                    onPressed: () async {
                                      if (value.isFollowed(data['userid'])) {
                                        value.unfollow(data['userid']);
                                      } else {
                                        value.follow(data['userid']);
                                      }

                                      // await FirebaseFirestore.instance
                                      //     .collection('users')
                                      //     .doc(FirebaseAuth
                                      //         .instance.currentUser!.uid)
                                      //     .collection('data')
                                      //     .doc(FirebaseAuth
                                      //         .instance.currentUser!.uid)
                                      //     .collection('following')
                                      //     .doc()
                                      //     .set(
                                      //         {'userid': data['userid']});
                                      // await FirebaseFirestore.instance
                                      //     .collection('users')
                                      //     .doc(data['userid'])
                                      //     .collection('data')
                                      //     .doc(data['userid'])
                                      //     .collection('followers')
                                      //     .doc()
                                      //     .set({
                                      //   'userid': FirebaseAuth
                                      //       .instance.currentUser!.uid
                                      // });

                                      // setState(() {
                                      //   if (pressed) {
                                      //     pressed = false;
                                      //   } else {
                                      //     pressed = true;
                                      //   }
                                      // });
                                    },
                                    child: value.isFollowed(data['userid'])
                                        ? Container(
                                            height: 32,
                                            width: size.width / 2.4,
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    154, 89, 89, 89),
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: Center(
                                                child: Text("Following",
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          )
                                        : Container(
                                            height: 32,
                                            width: size.width / 2.4,
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 2, 198, 228),
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: Center(
                                                child: Text(
                                              "Follow",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                          ));
                              },
                            ),

                            Expanded(child: Text("")),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(154, 89, 89, 89),
                                  borderRadius: BorderRadius.circular(7)),
                              height: 32,
                              width: size.width / 2.4,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => Chatpage(
                                                  friendimageurl: profile,
                                                  friendusername: username,
                                                  frienduserid: data['userid'],
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
                            //       onPressed: (){},
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
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;

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
                                        color: Color.fromARGB(120, 88, 88, 88),
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(data['imagerul']),
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
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;

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
                                              margin: EdgeInsets.only(left: 15),
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      109, 74, 74, 74),
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
                                              margin: EdgeInsets.only(left: 15),
                                              child: Text(
                                                username,
                                                style: TextStyle(
                                                  wordSpacing: 3,
                                                  letterSpacing: 0.6,
                                                  fontSize: 15,
                                                  fontFamily: 'Right',
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(""),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(right: 5),
                                              child: IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.more_vert,
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
                                              color: Color.fromARGB(
                                                  117, 67, 67, 67),
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
                                        width: double.infinity,
                                        child: Text(
                                          data['text'],
                                          style: TextStyle(color: Colors.white),
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
                                                Icons.favorite_border_outlined,
                                                size: 32,
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
                                              icon: ImageIcon(AssetImage(
                                                  "assets/images/chat.png"))),
                                        ),
                                        Container(
                                          width: 40,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: ImageIcon(AssetImage(
                                                  "assets/images/send.png"))),
                                        ),
                                        Expanded(
                                          child: Text(""),
                                        ),
                                        Container(
                                          width: 45,
                                          margin: EdgeInsets.only(right: 5),
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: ImageIcon(AssetImage(
                                                  "assets/images/mark.png"))),
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
