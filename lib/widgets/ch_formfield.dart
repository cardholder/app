import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardholderFormField extends StatefulWidget {
  final String _title;
  final List<String> _options;

  CardholderFormField(this._title, this._options);

  @override
  State<StatefulWidget> createState() {
    return CardholderFormFieldState(_title, _options);
  }
}

class CardholderFormFieldState extends State<CardholderFormField> {
  String _title, _selectedOption = '';
  List<String> _options;

  CardholderFormFieldState(this._title, this._options) {
    _selectedOption = _options[0];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this._title),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    child: Text(this._selectedOption),
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
      ),
      onTap: () async {
        await showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: CupertinoPicker.builder(
                itemExtent: 35,
                childCount: _options.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    _options[index],
                    style: Theme.of(context).textTheme.body1,
                  );
                },
                onSelectedItemChanged: (int value) {
                  setState(() {
                    _selectedOption = _options[value];
                  });
                },
              ),
            );
          },
        );
      },
    );
  }
}
