import 'package:flutter/material.dart';


void CustomMaterialBanner(context, String title, Color backColor) {
  final materialBanner = MaterialBanner(
    contentTextStyle: TextStyle(color: Colors.white),
    backgroundColor: backColor,
    content: Text('${title}'),
    actions: [
      GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
          },
          child: Icon(
            Icons.close,
            color: Colors.white,
          )
      )
    ],
  );

  ScaffoldMessenger.of(context).showMaterialBanner(materialBanner);

}