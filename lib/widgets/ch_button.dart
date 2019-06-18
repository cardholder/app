import 'package:flutter_web/material.dart';

class Button extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String title;

  Button({@required this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: RawMaterialButton(
        fillColor: Theme.of(context).buttonColor,
        splashColor: Theme.of(context).buttonColor,
        constraints: BoxConstraints(
          minHeight: 50,
          minWidth: 250,
          maxHeight: 50,
          maxWidth: 250,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        clipBehavior: Clip.antiAlias,
        child: Text(
          title,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
