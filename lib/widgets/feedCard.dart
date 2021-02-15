import 'package:flutter/material.dart';
import 'package:grad_cafe_notifier_app/models/instResultInfo.dart';

class FeedCard extends StatelessWidget {
  InstResultInfo instInfo;

  FeedCard(this.instInfo);

  Map<String, Color> _infoTypeColorMap = {'Accepted': Colors.green, 'Rejected': Colors.redAccent, 'Other': Colors.white10};
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           ListTile(
            leading: Icon(Icons.school),
            title: Text(instInfo.instInfo.instName),
            subtitle: Text(instInfo.instInfo.courseName),
             trailing: Column(
               children: [
                 Text(instInfo.instInfo.degree+', '+instInfo.instInfo.season),
                 SizedBox(height: 10,),
                 Text(instInfo.infoType)
               ],
             ),
          ),
          SizedBox(height: 10, width: double.infinity, child: DecoratedBox(
            decoration: BoxDecoration(
              color: _infoTypeColorMap[instInfo.infoType]
            ),
          ),)
        ],
      ),
    );
  }
}
