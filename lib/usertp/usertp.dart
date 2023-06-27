import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:insta_clone/usertp/story.dart';
import 'package:page_transition/page_transition.dart';

import 'comments.dart';
import 'largeimg.dart';

class useristp extends StatefulWidget {
  @override
  State<useristp> createState() => _useristpState();
}

class _useristpState extends State<useristp> {
  @override
  Widget build(BuildContext context) {
    User? userId = FirebaseAuth.instance.currentUser;

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: userId?.uid)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
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

              return Expanded(
                child: Scaffold(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  appBar: AppBar(
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 120,
                              height: 60,
                              margin: EdgeInsets.only(top: 15, right: 20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  // fit: BoxFit.cover,

                                  image: NetworkImage(
                                      "https://www.edigitalagency.com.au/wp-content/uploads/instagram-logo-white-text-black-background.png"),
                                ),
                              )),
                          Row(
                            children: [
                              Container(
                                child: IconButton(
                                    onPressed: null,
                                    icon: const Icon(
                                      Icons.favorite_outline_outlined,
                                      color: Colors.white,
                                      size: 27,
                                    )),
                              ),
                              Padding(padding: EdgeInsets.only(left: 8)),
                              Container(
                                  width: 39,
                                  child: IconButton(
                                      onPressed: null,
                                      icon: Image.asset(
                                          "assets/images/mess.png"))),
                            ],
                          )
                        ],
                      ),
                      // toolbarHeight: 0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        systemNavigationBarColor:
                            Color.fromARGB(255, 0, 0, 0), // Navigation bar
                        statusBarColor:
                            Color.fromARGB(255, 0, 0, 0), // Status bar
                      )),
                  body: SingleChildScrollView(
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
                    color: Colors.green,
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
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              Expanded(
                child: Text(""),
              ),
              Container(
                margin: EdgeInsets.only(right: 5),
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Largeimg(
                      imglink: widget.post,
                    )));
          }),
          child: Container(
            // width: 410
            height: 500,
            margin: EdgeInsets.only(left: 5, right: 0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitWidth, image: NetworkImage(widget.post))),
          ),
        ),
        // ),
        Row(children: [
          Container(
            // height: 25,
            // width: 45,
            // margin: EdgeInsets.only(left: 5s),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    if (pressed) {
                      pressed = false;
                    } else {
                      pressed = true;
                    }
                  });
                },
                icon: pressed
                    ? const Icon(
                        Icons.favorite,
                        size: 32,
                        color: Colors.red,
                      )
                    : const Icon(
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
                        type: PageTransitionType.bottomToTop,
                        child: Comments(
                          postid: "",
                          userid: "",
                        ))),
                icon: Image.asset("assets/images/chat.png")),
          ),
          Container(
            width: 40,
            child: IconButton(
                onPressed: null, icon: Image.asset("assets/images/send.png")),
          ),
          Expanded(
            child: Text(""),
          ),
          Container(
            width: 45,
            margin: EdgeInsets.only(right: 5),
            child: IconButton(
                onPressed: null, icon: Image.asset("assets/images/mark.png")),
          ),
        ])
      ]),
    );
  }
}


//  return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//       appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 0, 0, 0),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                   width: 120,
//                   height: 60,
//                   margin: EdgeInsets.only(top: 15, right: 20),
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       // fit: BoxFit.cover,
//                       image: NetworkImage(
//                           "https://www.edigitalagency.com.au/wp-content/uploads/instagram-logo-white-text-black-background.png"),
//                     ),
//                   )),
//               Row(
//                 children: [
//                   Container(
//                     child: IconButton(
//                         onPressed: null,
//                         icon: const Icon(
//                           Icons.favorite_outline_outlined,
//                           color: Colors.white,
//                           size: 27,
//                         )),
//                   ),
//                   Padding(padding: EdgeInsets.only(left: 8)),
//                   Container(
//                       width: 39,
//                       child: IconButton(
//                           onPressed: null,
//                           icon: Image.asset("assets/images/mess.png"))),
//                 ],
//               )
//             ],
//           ),
//           // toolbarHeight: 0,
//           systemOverlayStyle: SystemUiOverlayStyle(
//             systemNavigationBarColor:
//                 Color.fromARGB(255, 0, 0, 0), // Navigation bar
//             statusBarColor: Color.fromARGB(255, 0, 0, 0), // Status bar
//           )),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Container(
//               height: 130,
//               margin: EdgeInsets.only(left: 10),
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   Story(
//                       imglink:
//                           "https://c4.wallpaperflare.com/wallpaper/224/829/129/digital-digital-art-artwork-illustration-simple-hd-wallpaper-preview.jpg"),
//                   Story(
//                       imglink:
//                           "https://c4.wallpaperflare.com/wallpaper/228/684/1/video-games-spider-man-2018-spider-man-marvel-comics-wallpaper-preview.jpg"),
//                   Story(
//                       imglink:
//                           "https://c4.wallpaperflare.com/wallpaper/182/512/853/doctor-strange-dr-stephen-strange-marvel-comics-artwork-wallpaper-preview.jpg"),
//                   Story(
//                       imglink:
//                           "https://c4.wallpaperflare.com/wallpaper/26/288/1007/benedict-cumberbatch-dr-stephen-strange-avengers-infinity-war-5k-wallpaper-preview.jpg"),
//                   Story(
//                       imglink:
//                           "https://c4.wallpaperflare.com/wallpaper/611/838/413/spiderman-hd-4k-superheroes-wallpaper-preview.jpg"),
//                   Story(
//                       imglink:
//                           "https://vignette.wikia.nocookie.net/disney/images/9/90/Pirates4JackSparrowPosterCropped.jpg/revision/latest?cb=20151120172626"),
//                 ],
//               ),
//             ),
//             Card(
//                 "https://images.unsplash.com/photo-1552010099-5dc86fcfaa38?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8ZnJlc2h8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
//                 "https://vignette.wikia.nocookie.net/disney/images/9/90/Pirates4JackSparrowPosterCropped.jpg/revision/latest?cb=20151120172626",
//                 "Niranjan Dorage"),
//             Card(
//                 "https://images.unsplash.com/photo-1598324789736-4861f89564a0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dGFqJTIwbWFoYWwlMjBhZ3JhJTIwaW5kaWF8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
//                 "https://vignette.wikia.nocookie.net/disney/images/9/90/Pirates4JackSparrowPosterCropped.jpg/revision/latest?cb=20151120172626",
//                 "Niranjan Dorage"),
//             Card(
//                 "https://images.unsplash.com/photo-1635805737707-575885ab0820?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWFydmVsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
//                 "https://vignette.wikia.nocookie.net/disney/images/9/90/Pirates4JackSparrowPosterCropped.jpg/revision/latest?cb=20151120172626",
//                 "Niranjan Dorage"),
//             Card(
//                 "https://images.unsplash.com/photo-1627455241702-ae77954cd299?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8NGslMjBpbWFnZXN8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
//                 "https://vignette.wikia.nocookie.net/disney/images/9/90/Pirates4JackSparrowPosterCropped.jpg/revision/latest?cb=20151120172626",
//                 "Niranjan Dorage"),
//             Card(
//                 "https://c4.wallpaperflare.com/wallpaper/611/838/413/spiderman-hd-4k-superheroes-wallpaper-preview.jpg",
//                 "https://vignette.wikia.nocookie.net/disney/images/9/90/Pirates4JackSparrowPosterCropped.jpg/revision/latest?cb=20151120172626",
//                 "Niranjan Dorage"),
//           ],
//         ),
//       ),
//     );
 