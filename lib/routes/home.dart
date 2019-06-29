import 'package:cardholder/singletons/userdata.dart';
import 'package:cardholder/widgets/ch_button.dart';
import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: cardholderappbar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button(
              title: 'Lobby suchen',
              onPressed: () async {
                if (userData.username == '') {
                  final usernameSet =
                      await Navigator.pushNamed(context, '/username');
                  if (usernameSet == true)
                    Navigator.pushNamed(context, '/lobbylist');
                } else {
                  Navigator.pushNamed(context, '/lobbylist');
                }
              },
            ),
            Button(
              title: 'Lobby erstellen',
              onPressed: () async {
                if (userData.username == '') {
                  final usernameSet =
                      await Navigator.pushNamed(context, '/username');
                  if (usernameSet == true)
                    Navigator.pushNamed(context, '/createlobby');
                } else {
                  Navigator.pushNamed(context, '/createlobby');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
