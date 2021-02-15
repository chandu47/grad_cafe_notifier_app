import 'package:flutter/material.dart';
import 'package:grad_cafe_notifier_app/models/instInfo.dart';

class SettingsDisplayCard extends StatefulWidget {
  final InstInfo _instInfo;


  SettingsDisplayCard(this._instInfo);

  @override
  _SettingsDisplayCardState createState() => _SettingsDisplayCardState(_instInfo);
}

class _SettingsDisplayCardState extends State<SettingsDisplayCard> {
  InstInfo _instInfo;
  bool _showSaveCancelButtons = false;
  _SettingsDisplayCardState(this._instInfo);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            splashColor: Colors.blueGrey.withAlpha(30),
            onTap: () {
              setState(() {
                _showSaveCancelButtons = !_showSaveCancelButtons;
              });
            },
            child:
            ListTile(
              leading: Icon(Icons.school),
              title: Text(_instInfo.instName),
              subtitle: Text(_instInfo.courseName),
              trailing: Text(_instInfo.degree+', '+_instInfo.season),
            ),
          ),
          if(_showSaveCancelButtons) ...[
              Divider(),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  FlatButton(onPressed: null, child: Text('Delete' , style: TextStyle(color: Colors.redAccent.shade700),)),
                  SizedBox(width: 50,),
                  FlatButton(onPressed: null, child: Text('Edit'))
                ],
              )
          ]
        ],
      ),
    );
  }
}
