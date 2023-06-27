import 'package:flutter/material.dart';

class Largeimg extends StatelessWidget {
  final imglink;
  Largeimg({required this.imglink});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: new Scaffold(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            body: Center(
                child: Container(
              width: size.width - 20,
              child: InteractiveViewer(
                constrained: true,
                scaleEnabled: true,
                child: GestureDetector(
                  onTap: (() {
                    Navigator.pop(context);
                  }),
                  child: Center(
                    child: Container(
                      width: size.width,
                      height: size.height - 50,
                      // margin: EdgeInsets.only(right: 7, left: 7),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain, image: NetworkImage(imglink)),
                        color: Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            )
                // heigh,
                )));
  }
}
// InteractiveViewer(
//             constrained: true,
//             scaleEnabled: true,
//             child: GestureDetector(
//               onTap: (() {
//                 Navigator.pop(context);
//               }),
//               child: Container(
//                 width: size.width,
//                 height: size.height / 1.8,
//                 margin: EdgeInsets.only(right: 7, left: 7),
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                       fit: BoxFit.cover, image: NetworkImage(imglink)),
//                   color: Color.fromARGB(255, 0, 0, 0),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 // height,
//               ),
//             ),
//           )
