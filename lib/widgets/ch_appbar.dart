import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cardholderappbar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(kToolbarHeight),
    child: Hero(
      tag: 'cardholderappbar',
      child: AppBar(
        centerTitle: true,
        title: Text(
          'cardholder',
          style: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 35,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
