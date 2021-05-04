import 'package:flutter/material.dart';
import 'package:grad_cafe_notifier_app/models/instInfo.dart';
import 'package:grad_cafe_notifier_app/widgets/settingsCard.dart';
import 'package:grad_cafe_notifier_app/widgets/settingsDisplayCard.dart';

class SettingScreen extends StatefulWidget {
  String deviceId;


  SettingScreen(this.deviceId);

  @override
  _SettingScreenState createState() => _SettingScreenState(this.deviceId);
}

class _SettingScreenState extends State<SettingScreen> with AutomaticKeepAliveClientMixin{
  bool _rejectNotif = false;
  bool _infoNotif = false;
  bool _showSettingsTopEntry = false;
  List<Widget> _settingsListView = [];
  String deviceId;


  _SettingScreenState(this.deviceId);

  static InstInfo _instInfo = InstInfo('2', 'UMass', 'MS CS', 'F21', 'Masters');
  static InstInfo _instInfo2 = InstInfo('3', 'Purdue', 'MCS', 'F21', 'Masters');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
        child: Container(
            width: double.infinity,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Empty Box
                SizedBox(height: 30,),
                _buildNotificationOptions(),
                Divider(),
                InkWell(
                  child:
                    Card(
                          child: Container(
                            height: 30,
                            child: Center(child: Icon(Icons.add)),
                          )

                    ),
                  onTap: (){
                    if(!_showSettingsTopEntry)
                      _toggleShowSettingsEntry();
                    },
                ),
                if(_showSettingsTopEntry)
                  new SettingsCard(_hideSettingsEntryHandler, _saveSettingsEntryHandler),
                _buildSettingsList()
              ],
            ))
    );
  }

  Widget _buildSettingsList(){
    return Container(
      height: 500,
      child: ListView.builder(
          itemCount: _settingsListView.length,
          itemBuilder: (context, index) {
            return _settingsListView[index];
          },
      ),
    );
  }

  Widget _buildNotificationOptions(){
    return Container(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildNotifSwitchTiles('Receive Reject Notifications ?', _rejectNotif, _rejectNotifHandler),
            _buildNotifSwitchTiles('Receive Info Notifications ?', _infoNotif, _infoNotifHandler),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifSwitchTiles(String titleText, bool val, Function handler){
    return SwitchListTile(
        title: Text(titleText),
        value: val, onChanged: (val){handler(val);});
  }

  _rejectNotifHandler(value) => setState(() {_rejectNotif = value;});
  _infoNotifHandler(value) => setState(() {_infoNotif = value;});
  _toggleShowSettingsEntry() => setState(() {_showSettingsTopEntry = !_showSettingsTopEntry;});
  _hideSettingsEntryHandler() => setState(() {_showSettingsTopEntry = false;});
  _saveSettingsEntryHandler(InstInfo instInfo) => {
    setState(
        () {
          _showSettingsTopEntry = false;
          _settingsListView.add(SettingsDisplayCard(instInfo, _deleteSettingsCardHolder, ObjectKey(instInfo)));
        }
    )
  };

  _deleteSettingsCardHolder(settingsCard) => {
    setState(() {
      _settingsListView.removeWhere((element) => element.key == settingsCard.key);
  })
  };

  @override
  bool get wantKeepAlive => true;
}
