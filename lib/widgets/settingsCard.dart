import 'package:flutter/material.dart';

class SettingsCard extends StatefulWidget {
  final Function _cancelHandler;
  final Function _saveHandler;


  SettingsCard(this._cancelHandler, this._saveHandler);

  @override
  _SettingsCardState createState() => _SettingsCardState(_cancelHandler, _saveHandler);
}

class _SettingsCardState extends State<SettingsCard> {
  Function _cancelHandler;
  Function _saveHandler;
  String _seasonValue = 'Season';
  String _degreeValue = 'Degree';

  _SettingsCardState(this._cancelHandler, this._saveHandler);

  @override
  Widget build(BuildContext context) {
    return _buildInterestEntryCard();
  }

  Widget _buildInterestEntryCard() => Container(
      width: double.infinity,
      height: 300,
      child:
        Card(
          margin: new EdgeInsets.all(10),
          color: Colors.white70,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          elevation: 2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    SizedBox(width: 20,),
                    _buildTextFieldEntry('University'),
                   SizedBox(width: 40,),
                    _buildDropBoxDegreeEntry(<String>['Degree','MS','Ph.D','MBA']),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20,),
                  _buildTextFieldEntry('Course'),
                  SizedBox(width: 40,),
                  _buildDropBoxSeasonEntry(<String>['Season','S21','F21','S22'])
                ],
              ),
              Divider(),
              ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(onPressed: _cancelHandler, child: Text('Cancel')),
                  FlatButton(onPressed: widget._saveHandler, child: Text('Save'))
                ],
              )
            ],
          ),
        )
  );

  Widget _buildTextFieldEntry(String type) => SizedBox(
      width: 200,
      child:
      TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: type
        ),
      )
  );

  Widget _buildDropBoxDegreeEntry(List<String> optionList) =>
      DropdownButton(items: optionList.map((String value) =>
          DropdownMenuItem(child: Text(value), value: value)
      ).toList(),
      value: _degreeValue,
      onChanged: (value) {
          setState(() {
            _degreeValue = value;
          });
      });

  Widget _buildDropBoxSeasonEntry(List<String> optionList) =>
      DropdownButton(items: optionList.map((String value) =>
          DropdownMenuItem(child: Text(value), value: value)
      ).toList(),
          value: _seasonValue,
          onChanged: (value) {
            setState(() {
              _seasonValue = value;
            });
          });
}





