import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/account/editprofile.dart';
import 'package:insta_clone/create/create.dart';
import 'package:page_transition/page_transition.dart';

// import '../login/login.dart';
import '../usertp/comments.dart';
import '../usertp/largeimg.dart';
import 'editpost.dart';
import 'menu.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => AccountState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class AccountState extends State<Account> with TickerProviderStateMixin {
  User? userId = FirebaseAuth.instance.currentUser;
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
    Size size = MediaQuery.of(context).size;
    String username = "";
    String profile = "";
    final Stream<QuerySnapshot> postts = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('data')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('posts')
        .orderBy('Timestamp', descending: true)
        .snapshots();
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: userId?.uid)
        .snapshots();

    final Stream<QuerySnapshot> posts = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('data')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('posts')
        .orderBy('Timestamp', descending: true)
        .snapshots();

    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("");
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
                                      style: TextStyle(
                                          wordSpacing: 3,
                                          letterSpacing: 0.6,
                                          fontFamily: 'Right',
                                          fontSize: 19),
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
                                Container(
                                  width: 38,
                                  margin: EdgeInsets.only(left: 10),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          duration: Duration(seconds: 1),
                                          type: PageTransitionType.leftToRight,
                                          child: Createpost(),
                                        ),
                                      );
                                    },
                                    icon: ImageIcon(
                                        AssetImage("assets/images/more.png")),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            duration: Duration(seconds: 1),
                                            type:
                                                PageTransitionType.bottomToTop,
                                            child: Menu(),
                                          ),
                                        );
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
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => Largeimg(
                                                      imglink: data['imageurl'],
                                                    )));
                                      }),
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              top: 25, left: 10),
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(300),
                                              color: Color.fromARGB(
                                                  128, 109, 109, 109),
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
                              margin: EdgeInsets.only(top: 15),
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
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(137, 49, 49, 49),
                                        borderRadius: BorderRadius.circular(7)),
                                    height: 32,
                                    width: size.width / 2.7,
                                    margin: EdgeInsets.only(top: 20),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Editprofile(
                                                        uniquefilename: data[
                                                            'uniquefilename'],
                                                      )));
                                        },
                                        child: Text(
                                          "Edit Profile",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                  Expanded(child: Text("")),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(137, 49, 49, 49),
                                        borderRadius: BorderRadius.circular(7)),
                                    height: 32,
                                    width: size.width / 2.7,
                                    margin: EdgeInsets.only(top: 20),
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Share Pofile",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                  Expanded(child: Text("")),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    width: 33,
                                    height: 32,
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.person_add,
                                          color: Color.fromARGB(
                                              255, 254, 252, 252),
                                          size: 17,
                                        )),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(137, 49, 49, 49),
                                        borderRadius: BorderRadius.circular(7)),
                                  )
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
                                          Map<String, dynamic> data = document
                                              .data()! as Map<String, dynamic>;

                                          return GestureDetector(
                                            onTap: (() {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Largeimg(
                                                            imglink: data[
                                                                'imagerul'],
                                                          )));
                                            }),
                                            child: Container(
                                              height: 200,
                                              margin: EdgeInsets.only(
                                                  top: 15, left: 15),
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    120, 88, 88, 88),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      data['imagerul']),
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
                                          Map<String, dynamic> data = document
                                              .data()! as Map<String, dynamic>;

                                          return Container(
                                            margin: EdgeInsets.only(top: 20),
                                            child: Column(children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 8),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 35,
                                                      height: 35,
                                                      margin: EdgeInsets.only(
                                                          left: 15),
                                                      decoration: BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 74, 74, 74),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  NetworkImage(
                                                                      profile)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      150)),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin: EdgeInsets.only(
                                                          left: 15),
                                                      child: Text(
                                                        username,
                                                        style: TextStyle(
                                                          wordSpacing: 3,
                                                          letterSpacing: 0.6,
                                                          fontFamily: 'Right',
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(""),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 5),
                                                      child: IconButton(
                                                          onPressed: () {
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Editpost(
                                                                              Timestamp: data['Timestamp'],
                                                                            )));
                                                          },
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
                                                                imglink: data[
                                                                    'imagerul'],
                                                              )));
                                                }),
                                                child: Container(
                                                  height: 500,
                                                  margin: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      color: Color.fromARGB(
                                                          140, 55, 55, 55),
                                                      image: DecorationImage(
                                                          fit: BoxFit.fitWidth,
                                                          image: NetworkImage(
                                                              data[
                                                                  'imagerul']))),
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
                                                  style: TextStyle(),
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
                                                      )),
                                                ),
                                                Container(
                                                  width: 40,
                                                  child: IconButton(
                                                      onPressed: () =>
                                                          Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                  type: PageTransitionType
                                                                      .bottomToTop,
                                                                  child:
                                                                      Comments(
                                                                    userid: FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid,
                                                                    // caption: data[
                                                                    //     'text'],

                                                                    postid: data[
                                                                        'Timestamp'],
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
                                                  margin:
                                                      EdgeInsets.only(right: 5),
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
                            ])));
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
//   StreamBuilder<QuerySnapshot>(
//     stream: posts,
//     builder: (BuildContext context,
//         AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (snapshot.hasError) {
//         return Text('Something went wrong');
//       }

//       if (snapshot.connectionState ==
//           ConnectionState.waiting) {
//         return Text("Loading..");
//       }

//       return Container(
//         margin: EdgeInsets.only(right: 15),
//         child: Column(
//           children: snapshot.data!.docs
//               .map((DocumentSnapshot document) {
//             Map<String, dynamic> data =
//                 document.data()! as Map<String, dynamic>;

//             return Container(
//               width: 100,
//               height: 100,
//               color: Colors.red,
//             );
//           }).toList(),
//         ),
//       );
//     },
//   ),
 