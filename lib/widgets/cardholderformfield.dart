import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardholderFormField extends StatefulWidget {
  final String title;
  final List<String> options;
  final Function callback;

  CardholderFormField(this.title, this.options, this.callback);

  @override
  State<StatefulWidget> createState() {
    return CardholderFormFieldState();
  }
}

class CardholderFormFieldState extends State<CardholderFormField> {
  String _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.options[0];
    widget.callback(_selectedOption);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.title),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    child: Text(_selectedOption),
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
                itemExtent: 33,
                childCount: widget.options.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    widget.options[index],
                    style: Theme.of(context).textTheme.body1,
                  );
                },
                onSelectedItemChanged: (int value) {
                  setState(() {
                    _selectedOption = widget.options[value];
                    widget.callback(_selectedOption);
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
