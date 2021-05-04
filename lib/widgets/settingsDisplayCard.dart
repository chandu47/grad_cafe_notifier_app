import 'package:flutter/material.dart';
import 'package:grad_cafe_notifier_app/models/instInfo.dart';
import 'package:grad_cafe_notifier_app/widgets/settingsCard.dart';

class SettingsDisplayCard extends StatefulWidget {
  final InstInfo _instInfo;
  Function _deleteHandler;
  Key key;


  SettingsDisplayCard(this._instInfo, this._deleteHandler, this.key) : super(key: key);



  @override
  _SettingsDisplayCardState createState() => _SettingsDisplayCardState(_instInfo, _deleteHandler, key);
}

class _SettingsDisplayCardState extends State<SettingsDisplayCard> {
  InstInfo _instInfo;
  Function _deleteHandler;
  bool _showSaveCancelButtons = false;
  Key key;
  bool _showSettingsEdit = false;


  _SettingsDisplayCardState(this._instInfo, this._deleteHandler, this.key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: _showSettingsEdit ? _buildInstInfoEdit() : _buildInstInfoDisplay() ,
    );
  }

  Widget _buildInstInfoDisplay() => Column(
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
            FlatButton(onPressed: _showDeleteAlertDialog, child: Text('Delete' , style: TextStyle(color: Colors.redAccent.shade700),)),
            SizedBox(width: 50,),
            FlatButton(onPressed: _triggerInstInfoEdit, child: Text('Edit'))
          ],
        )
      ]
    ],
  );

  Widget _buildInstInfoEdit() => SettingsCard(_cancelInstInfoEdit, _saveInstInfoEdit, instInfo: _instInfo);

  _popAlert() => {
    Navigator.of(context).pop()
  };

  deleteSettingsAlert() => AlertDialog(
    title: Text("Delete University Information"),
    content: Text("Would you like to remove the university information?"),
    actions: [
      FlatButton(onPressed: () {_popAlert();}, child: Text("Cancel")),
      FlatButton(onPressed: (){ _popAlert();_deleteHandler(this);}, child: Text("Delete"))
    ],
  );

  _showDeleteAlertDialog() => showDialog(context: context,
    builder: (BuildContext context) {
      return deleteSettingsAlert();
    },);

  _triggerInstInfoEdit() => setState(() {
    _showSettingsEdit = true;
  });

  _cancelInstInfoEdit() => setState((){
    _showSettingsEdit = false;
    _showSaveCancelButtons = false;
  });

  _saveInstInfoEdit(InstInfo instInfo) => setState((){
    _instInfo = instInfo;
    _showSettingsEdit = false;
    _showSaveCancelButtons = false;
  });
}
