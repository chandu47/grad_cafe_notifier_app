import 'package:flutter/material.dart';
import 'package:grad_cafe_notifier_app/models/instInfo.dart';

class SettingsCard extends StatefulWidget {
  final Function _cancelHandler;
  final Function _saveHandler;
  InstInfo instInfo;


  SettingsCard(this._cancelHandler, this._saveHandler, {this.instInfo});

  @override
  _SettingsCardState createState() => _SettingsCardState(_cancelHandler, _saveHandler, instInfo: instInfo);
}

class _SettingsCardState extends State<SettingsCard> {
  Function _cancelHandler;
  Function _saveHandler;
  InstInfo instInfo;
  String _seasonValue = 'Season';
  String _degreeValue = 'Degree';
  String _courseName;
  String _universityName;

  _SettingsCardState(this._cancelHandler, this._saveHandler, {this.instInfo});

  @override
  void initState() {
    super.initState();
    if(instInfo != null && instInfo.isNotEmpty){
      _seasonValue = instInfo.season;
      _degreeValue = instInfo.degree;
      _courseName = instInfo.courseName;
      _universityName = instInfo.instName;
    }
  }

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
                    _buildUniversityTextFieldEntry('University'),
                   SizedBox(width: 40,),
                    _buildDropBoxDegreeEntry(<String>['Degree','MS','Ph.D','MBA']),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20,),
                  _buildCourseTextFieldEntry('Course'),
                  SizedBox(width: 40,),
                  _buildDropBoxSeasonEntry(<String>['Season','S21','F21','S22'])
                ],
              ),
              Divider(),
              ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(onPressed: (){_cancelHandler();}, child: Text('Cancel')),
                  TextButton(onPressed: () {
                    _saveHandler(InstInfo("69", _universityName, _courseName, _seasonValue, _degreeValue)); }, child: Text('Save'))
                ],
              )
            ],
          ),
        )
  );

  Widget _buildUniversityTextFieldEntry(String type) => SizedBox(
      width: 200,
      child:
      TextFormField(
        initialValue: _universityName != null ? _universityName: "",
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: type,
        ),
        onChanged: (value){
          setState(() {
            _universityName = value;
          });
        },
      )
  );

  Widget _buildCourseTextFieldEntry(String type) => SizedBox(
      width: 200,
      child:
      TextFormField(
        initialValue: _courseName != null ? _courseName: "",
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: type
        ),
        onChanged: (value){
          setState(() {
            _courseName = value;
          });
        },
      )
  );

  Widget _buildDropBoxDegreeEntry(List<String> optionList) =>
      DropdownButton(items: optionList.map((String value) =>
          DropdownMenuItem(child: Text(value), value: value)
      ).toList(),
      value: _degreeValue,
      onChanged: (value) {
          setState(() {
            _degreeValue = value as String;
          });
      });

  Widget _buildDropBoxSeasonEntry(List<String> optionList) =>
      DropdownButton(items: optionList.map((String value) =>
          DropdownMenuItem(child: Text(value), value: value)
      ).toList(),
          value: _seasonValue,
          onChanged: (value) {
            setState(() {
              _seasonValue = value as String;
            });
          });
}





