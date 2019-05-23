import 'package:flutter/material.dart';

class CardholderFormField extends StatelessWidget {
  final String title, content;

  CardholderFormField(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(this.title),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    child: Text(this.content),
                  ),
                  Icon(
                    Icons.expand_more,
                    size: 35,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
