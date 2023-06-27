import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/search/friendaccount.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('users')
        // .where('userid', isEqualTo: userId?.uid
        // )
        .snapshots();
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          // call this method here to hide soft keyboard
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              const SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 100.0,
                floating: false,
                pinned: false,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Search",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      )),
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ListView(
              children: [
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyCustomForm()),
                        ),
                      ],
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: _usersStream,
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
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;

                              return GestureDetector(
                                onTap: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Friendaccount(
                                            userid: data['userid'],
                                          )));
                                }),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 55,
                                        height: 55,
                                        margin: EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    data['imageurl']),
                                                fit: BoxFit.cover),
                                            color:
                                                Color.fromARGB(255, 82, 82, 82),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                      ),
                                      Container(
                                        // color: Colors.red,
                                        margin: EdgeInsets.only(left: 15),
                                        // width: 180,
                                        height: 25,
                                        child: Text(data['username'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17)),
                                      ),
                                      Expanded(child: Text("")),
                                      Container(
                                        height: 40,
                                        width: size.width / 3.5,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 0, 221, 255),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Follow",
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0)),
                                            )),
                                      )
                                    ],
                                  ),
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 15),
                                  width: double.infinity,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color.fromARGB(255, 31, 31, 31)),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  MyCustomForm({super.key});
  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
    final SearchController = TextEditingController();

    return (Container(
      height: 50,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(11),
      ),
      child: TextField(
        controller: SearchController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.name,
        style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 17,
              fontWeight: FontWeight.bold),
          hintText: 'Search Your Friends ',
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    ));
  }
}
