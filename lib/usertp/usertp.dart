// flutter build apk --no-shrink --split-per-abi
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta_clone/permissions/notification.dart';

import 'package:insta_clone/usertp/story.dart';
import 'package:provider/provider.dart';

import '../provider/redlikeprovider.dart';
import 'largeimg.dart';

class useristp extends StatefulWidget {
  @override
  State<useristp> createState() => _useristpState();
}

class _useristpState extends State<useristp> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.RequestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    User? userId = FirebaseAuth.instance.currentUser;

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: userId?.uid)
        .snapshots();
    return Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 137,
                  margin: EdgeInsets.only(top: 10),
                  height: 100,
                  child: IconButton(
                    onPressed: () {},
                    icon: ImageIcon(
                      AssetImage("assets/images/instagram_logo.png"),
                      size: 200,
                    ),
                  ),
                ),
                Expanded(child: Text("")),
                Container(
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_outline_outlined,
                        size: 27,
                      )),
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                Container(
                    width: 39,
                    child: IconButton(
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage("assets/images/mess.png"),
                        size: 200,
                      ),
                    ))
              ],
            ),
            // toolbarHeight: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor:
                  Color.fromARGB(255, 0, 0, 0), // Navigation bar
              statusBarColor: Color.fromARGB(255, 0, 0, 0), // Status bar
            )),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 130,
                      margin: EdgeInsets.only(left: 10),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Story(
                              imglink:
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRxSjDspL-igTNNFJNftOfcEdtd-h_SaBkW0DGyOI3HQ&s"),
                          Story(
                              imglink:
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRxSjDspL-igTNNFJNftOfcEdtd-h_SaBkW0DGyOI3HQ&s"),
                          Story(
                              imglink:
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRxSjDspL-igTNNFJNftOfcEdtd-h_SaBkW0DGyOI3HQ&s"),
                          Story(
                              imglink:
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRxSjDspL-igTNNFJNftOfcEdtd-h_SaBkW0DGyOI3HQ&s"),
                          Story(
                              imglink:
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRxSjDspL-igTNNFJNftOfcEdtd-h_SaBkW0DGyOI3HQ&s"),
                          Story(
                              imglink:
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRxSjDspL-igTNNFJNftOfcEdtd-h_SaBkW0DGyOI3HQ&s"),
                          Story(
                              imglink:
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRxSjDspL-igTNNFJNftOfcEdtd-h_SaBkW0DGyOI3HQ&s"),
                        ],
                      ),
                    ),
                    Card(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRxSjDspL-igTNNFJNftOfcEdtd-h_SaBkW0DGyOI3HQ&",
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRxSjDspL-igTNNFJNftOfcEdtd-h_SaBkW0DGyOI3HQ&s",
                      "",
                    )
                  ],
                );
              }

              return Container(
                child: Column(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 130,
                            margin: EdgeInsets.only(left: 10),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Story(imglink: data['imageurl']),
                                Story(
                                    imglink:
                                        "https://c4.wallpaperflare.com/wallpaper/228/684/1/video-games-spider-man-2018-spider-man-marvel-comics-wallpaper-preview.jpg"),
                                Story(
                                    imglink:
                                        "https://c4.wallpaperflare.com/wallpaper/182/512/853/doctor-strange-dr-stephen-strange-marvel-comics-artwork-wallpaper-preview.jpg"),
                                Story(
                                    imglink:
                                        "https://c4.wallpaperflare.com/wallpaper/26/288/1007/benedict-cumberbatch-dr-stephen-strange-avengers-infinity-war-5k-wallpaper-preview.jpg"),
                                Story(
                                    imglink:
                                        "https://c4.wallpaperflare.com/wallpaper/611/838/413/spiderman-hd-4k-superheroes-wallpaper-preview.jpg"),
                                Story(
                                    imglink:
                                        "https://vignette.wikia.nocookie.net/disney/images/9/90/Pirates4JackSparrowPosterCropped.jpg/revision/latest?cb=20151120172626"),
                              ],
                            ),
                          ),
                          Card(data["imageurl"], data["imageurl"],
                              data["username"]),
                          Card(
                              "https://images.unsplash.com/photo-1598324789736-4861f89564a0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dGFqJTIwbWFoYWwlMjBhZ3JhJTIwaW5kaWF8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
                              "https://vignette.wikia.nocookie.net/disney/images/9/90/Pirates4JackSparrowPosterCropped.jpg/revision/latest?cb=20151120172626",
                              "Niranjan Dorage"),
                          Card(
                              "https://images.unsplash.com/photo-1635805737707-575885ab0820?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWFydmVsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                              "https://vignette.wikia.nocookie.net/disney/images/9/90/Pirates4JackSparrowPosterCropped.jpg/revision/latest?cb=20151120172626",
                              "Niranjan Dorage"),
                          Card(
                              "https://images.unsplash.com/photo-1627455241702-ae77954cd299?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8NGslMjBpbWFnZXN8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
                              "https://vignette.wikia.nocookie.net/disney/images/9/90/Pirates4JackSparrowPosterCropped.jpg/revision/latest?cb=20151120172626",
                              "Niranjan Dorage"),
                          Card(
                              "https://c4.wallpaperflare.com/wallpaper/611/838/413/spiderman-hd-4k-superheroes-wallpaper-preview.jpg",
                              "https://vignette.wikia.nocookie.net/disney/images/9/90/Pirates4JackSparrowPosterCropped.jpg/revision/latest?cb=20151120172626",
                              "Niranjan Dorage"),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ));
  }
}

// ignore: must_be_immutable
class Card extends StatefulWidget {
  String post = "", profile = "", name = "";
  Card(this.post, this.profile, this.name);

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  bool pressed = true;
  @override
  Widget build(BuildContext context) {
    print("build card");

    // final likeprovider = Provider.of<Redlikeprovider>(context);

    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;

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
                    color: Color.fromARGB(89, 117, 117, 117),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(widget.profile)),
                    borderRadius: BorderRadius.circular(150)),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  widget.name,
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Largeimg(
                      imglink: widget.post,
                    )));
          }),
          child: Container(
            // width: 410
            height: 500,
            margin: EdgeInsets.only(left: 3, right: 3),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 50, 50, 50),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.fitWidth, image: NetworkImage(widget.post))),
          ),
        ),
        // ),
        Row(children: [
          Container(
              margin: EdgeInsets.only(left: 5),
              child: Consumer<Redlikeprovider>(
                builder: (context, value, child) {
                  print("build heart only");
                  return IconButton(
                      onPressed: () {
                        value.clicked();
                        // setState(() {
                        //   if (pressed) {
                        //     pressed = false;
                        //   } else {
                        //     pressed = true;
                        //   }
                        // });
                      },
                      icon: value.pressed
                          ? const Icon(
                              Icons.favorite,
                              size: 33,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border_outlined,
                              size: 33,
                            ));
                },
              )),
          Container(
            width: 40,
            child: IconButton(
              onPressed: () {},
              icon: ImageIcon(
                AssetImage("assets/images/mess.png"),
              ),
            ),
          ),
          Container(
            width: 40,
            child: IconButton(
              onPressed: () {},
              icon: ImageIcon(
                AssetImage("assets/images/send.png"),
              ),
            ),
          ),
          Expanded(
            child: Text(""),
          ),
          Container(
              width: 45,
              margin: EdgeInsets.only(right: 5),
              child: IconButton(
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage("assets/images/mark.png"),
                ),
              )),
        ])
      ]),
    );
  }
}
