import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseServiceManager{

  bool _isInitialized = false;
  bool _error = false;
  FirebaseMessaging messaging = FirebaseMessaging();

  Future<bool> init() async{
      try{
        await Firebase.initializeApp();
        _isInitialized = true;

      } catch(e){
        _error = true;
      }

      return _isInitialized;
  }

   Future<String> getToken() async{
    return await messaging.getToken();
  }

}