import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomMessage extends StatelessWidget {

  String? message ;
  Color? color;
  Color? textColor ;
  double? bottomLeft  ;
  double? bottomRight ;
  double? paddingRight ;
  double? paddingLift ;

  CustomMessage({super.key,
    required this.message ,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.bottomLeft = 20,
    this.bottomRight = 20,
    this.paddingLift = 100,
    this.paddingRight = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 10, bottom: 0, left: paddingLift!, right: paddingRight!),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomLeft!),
              bottomRight: Radius.circular(bottomRight!),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '$message',
            style: TextStyle(
                color:textColor,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
