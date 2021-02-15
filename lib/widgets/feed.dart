import 'package:flutter/material.dart';
import 'package:grad_cafe_notifier_app/widgets/feedCard.dart';
import 'package:grad_cafe_notifier_app/models/instInfo.dart';
import 'package:grad_cafe_notifier_app/models/instResultInfo.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  static InstInfo _instInfo = InstInfo('1', 'UCSD', 'Computer Science', 'F21', 'Masters');
  InstResultInfo _instResultInfo = InstResultInfo('1', _instInfo, 'Accepted');
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 400,
      child: RefreshIndicator(
          onRefresh: _refreshFeed,
          child: ListView(
            padding: EdgeInsets.all(8),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              FeedCard(_instResultInfo)
            ],
          )
      ),
    );
  }

  Future<Null> _refreshFeed() async {
    print('refreshing feed...');
  }
}
