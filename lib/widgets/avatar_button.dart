import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarButton extends StatelessWidget {

  final double imageSize;

  const AvatarButton({
    super.key,
    this.imageSize = 100
  });

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black38,
                  offset: Offset(0,20),
                ),
              ]
          ),
          child: ClipOval(
            child: Image.network(
              'https://cdn-icons-png.flaticon.com/512/147/147142.png',
              width: imageSize,
              height: imageSize,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: CupertinoButton(
            onPressed: () {  },
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  color: Colors.pinkAccent,
                  shape: BoxShape.circle
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
