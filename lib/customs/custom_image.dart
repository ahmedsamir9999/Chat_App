import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {

  String? imageUrl ;
  double? bottomLeft  ;
  double? bottomRight ;
  double? paddingRight ;
  double? paddingLift ;
  AlignmentGeometry? alin ;

   CustomImage({super.key,
     required this.imageUrl,
     this.bottomLeft = 20,
     this.bottomRight = 20,
     this.paddingLift = 20,
     this.paddingRight = 20,
     required this.alin
   });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alin!,
      child: Padding(
        padding: EdgeInsets.only(top: 0, bottom: 15, left: paddingLift!, right: paddingRight!),
        child: Container(
          width: 300,
          height: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(bottomLeft!),
                bottomRight: Radius.circular(bottomRight!),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Image.network(imageUrl!,fit:BoxFit.cover ),
        ),
      ),
    );
  }
}
