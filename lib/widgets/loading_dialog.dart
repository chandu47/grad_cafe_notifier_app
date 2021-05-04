import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {

  String text;
  BuildContext context;


  LoadingDialog(this.text, this.context);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 200,
        width: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Center(child: Text(text = text),)
          ],
        ),
      ), elevation: 5,);
  }
}
