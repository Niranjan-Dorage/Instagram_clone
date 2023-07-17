import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import 'largeimg.dart';

class Story extends StatelessWidget {
  final imglink;
  Story({required this.imglink});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (() {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Largeimg(
                      imglink: imglink,
                    )));
          }),
          child: Container(
            width: 75,
            height: 75,
            margin: EdgeInsets.only(right: 15, top: 12),
            decoration: BoxDecoration(
                border: const GradientBoxBorder(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 255, 159, 34),
                    Color.fromARGB(255, 255, 0, 0),
                    Color.fromARGB(255, 255, 0, 119),
                    Color.fromARGB(255, 252, 46, 221),
                  ]),
                  width: 2.5,
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imglink),
                ),
                color: Color.fromARGB(126, 66, 65, 65),
                borderRadius: BorderRadius.circular(1500)),
          ),
        ),
        Container(
          width: 80,
          height: 40,
          margin: EdgeInsets.only(top: 2, right: 15),
          child: Align(
            child: Text(
              "mr.x",
            ),
          ),
        )
      ],
    );
  }
}
