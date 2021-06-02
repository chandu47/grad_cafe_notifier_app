import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseServiceManager{

  FirebaseServiceManager._();

  static final FirebaseServiceManager firebaseServiceManager = FirebaseServiceManager._();

  bool _isInitialized = false;
  bool _error = false;
  FirebaseMessaging _messaging;

  Future<FirebaseMessaging> get _instance async{
      try{
        if(_messaging != null)
          return _messaging;
        await Firebase.initializeApp();
        _messaging = FirebaseMessaging();
        return _messaging;
      } catch(e){
        _error = true;
      }
  }

   Future<String> get token async{
    final messaging = await _instance;
    return await messaging.getToken();
  }
}