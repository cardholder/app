import 'package:flutter/material.dart';

class CardholderAppBar extends AppBar {
  CardholderAppBar({Key key}) : super(
    key: key, 
    title: Text(
      'cardholder',
      style: TextStyle(
        fontFamily: 'Lobster',
        fontSize: 35,
        color: Colors.white,
      ),
    ),
    centerTitle: true,
  );
}
