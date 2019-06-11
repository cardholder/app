import 'package:cardholder/widgets/ch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsernameDialog {
  final _formKey = GlobalKey<FormState>();

  String show(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title:
                Text('Anzeigename', style: Theme.of(context).textTheme.body1),
            content: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CupertinoTextField(
                    controller: TextEditingController(),
                    autofocus: false,
                    autocorrect: false,
                  ),
                  Button(title: 'Weiter', onPressed: null),
                ],
              ),
            ),
          );
        });
    return '';
  }
}
