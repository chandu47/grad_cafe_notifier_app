import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:grad_cafe_notifier_app/orchestration/network/connection_props.dart';
import 'package:grad_cafe_notifier_app/tools/request_type.dart';
import 'package:http/http.dart';

class RegisterClient{

  final Client _client;
  static const host = ConnectionProps.host;
  static const userEndpoint = ConnectionProps.baseUserEndPoint;
  static const registerEndPoint = ConnectionProps.registerApiEndPoint;

  RegisterClient(this._client);

  Future<Response> request({@required RequestType requestType, dynamic param}) async {

      switch(requestType){
        case RequestType.POST:
          log("Calling Register User Post call");
          return _client.post("$host/$userEndpoint/$registerEndPoint",
              headers: {"Content-Type": "application/json"},
              body: json.encode(param));
          
        case RequestType.PUT:
          log("Calling Register User Put call");
          return _client.post("$ConnectionProps.host/$ConnectionProps.baseUserEndPoint/$ConnectionProps.registerApiEndPoint",
              headers: {"Content-Type": "application/json"},
              body: json.encode(param));
      }
  }
}