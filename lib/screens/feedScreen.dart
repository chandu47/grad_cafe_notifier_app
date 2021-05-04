import 'package:flutter/material.dart';
import 'package:grad_cafe_notifier_app/widgets/feed.dart';
import 'package:url_launcher/url_launcher.dart';


class FeedScreen extends StatefulWidget {
  String deviceId;


  FeedScreen(this.deviceId);

  @override
  _FeedScreenState createState() => _FeedScreenState(this.deviceId);
}

class _FeedScreenState extends State<FeedScreen> {

  String deviceId;


  _FeedScreenState(this.deviceId);

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Container(
            width: double.infinity,
            child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Empty Box
                    SizedBox(height: 10,),
                    _buildGradCafeRedirector(),
                    Divider(),
                    Feed()
                  ],
                ))
      );
  }

  Widget _buildGradCafeRedirector(){
      return Card(
        child: InkWell(
          splashColor: Colors.blueGrey.withAlpha(30),
          onTap: () async{
              var url = "https://www.thegradcafe.com/";
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
          },
          child: ListTile(
            title: Text('Go to GradCafe.com'),
          ),
        ),
      );
  }
}
