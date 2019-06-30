import 'package:cardholder/singletons/userdata.dart';
import 'package:cardholder/widgets/cardholderappbar.dart';
import 'package:cardholder/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:validators/validators.dart';

class UsernameDialog extends StatelessWidget {
  final textEditingController = TextEditingController();

  void _setUsername(BuildContext context) {
    if (_isValid(textEditingController.text)) {
      userData.username = textEditingController.text;
      Navigator.pop(context, true);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
            'Anzeigename darf nicht leer sein, maximal 20 Zeichen haben und darf nur aus Buchstaben und Zahlen bestehen.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  bool _isValid(String username) {
    return (username.length > 0 &&
        username.length < 20 &&
        isAlphanumeric(username));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cardholderappbar(context),
      body: Builder(
        builder: (BuildContext context) {
          var scaffoldContext = context;
          return Center(
            child: Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Anzeigename',
                        textAlign: TextAlign.left,
                      ),
                      Card(
                        elevation: 0,
                        color: Color.fromRGBO(235, 235, 235, 1),
                        child: CupertinoTextField(
                          controller: textEditingController,
                          autocorrect: false,
                          autofocus: true,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Button(
                              title: 'Weiter',
                              onPressed: () => {_setUsername(scaffoldContext)})
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
