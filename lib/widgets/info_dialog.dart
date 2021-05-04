import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {

  String textToDisplay;
  BuildContext context;


  InfoDialog(this.textToDisplay, this.context);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Text(textToDisplay),
        actions: [
          TextButton(onPressed: () {Navigator.pop(context);}, child: Text("Ok")),
        ]
    );
  }
}
