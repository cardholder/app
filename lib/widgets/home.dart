import 'package:cardholder/widgets/ch_button.dart';
import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:cardholder/widgets/usernamedialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cardholderappbar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button(
              title: 'Lobby suchen',
              onPressed: () async {
                UsernameDialog ud = UsernameDialog();
                ud.show(context);
                //Navigator.pushNamed(context, '/lobbylist');
              },
            ),
            Button(
              title: 'Lobby erstellen',
              onPressed: () {
                Navigator.pushNamed(context, '/createlobby');
              },
            ),
          ],
        ),
      ),
    );
  }
}
