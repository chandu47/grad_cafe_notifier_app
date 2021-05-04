import 'package:flutter/material.dart';
import 'package:grad_cafe_notifier_app/orchestration/model/user.dart';
import 'package:grad_cafe_notifier_app/orchestration/repository/register_repo.dart';
import 'package:grad_cafe_notifier_app/screens/feedScreen.dart';
import 'package:grad_cafe_notifier_app/screens/settingScreen.dart';
import 'package:grad_cafe_notifier_app/tools/FirebaseServiceManager.dart';
import 'package:grad_cafe_notifier_app/tools/result.dart';
import 'package:grad_cafe_notifier_app/widgets/info_dialog.dart';
import 'package:grad_cafe_notifier_app/widgets/loading_dialog.dart';
import 'package:grad_cafe_notifier_app/widgets/settingsCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPageIndex = 0;
  PageController _pageController;
  bool _showIntroDialog;
  bool isRegistered = false;
  String deviceId;
  String firebaseToken;
  FirebaseServiceManager firebaseManager = FirebaseServiceManager();
  RegisterRepo registerRepo = RegisterRepo();
  User newUserInfo;

  static List<Widget> _pages = [];

  @override
  void initState(){
    super.initState();
    _selectedPageIndex = 0;
    //initialize firebaseManager
    //Initially put loader screen for both the pages
    _pages = <Widget>[
      _showLoaderPage(),
      _showLoaderPage()
    ];
    _pageController = PageController(initialPage: _selectedPageIndex);
    _readProps();
  }

  void _readProps() async{
    final sharedPref = await SharedPreferences.getInstance();
    deviceId = sharedPref.getString("deviceId");
    isRegistered = sharedPref.getBool("isRegistered");
    firebaseToken = sharedPref.getString("deviceToken");
    await firebaseManager.init();
    //get firebase token
    String newFirebaseToken;
    await firebaseManager.getToken().then((value) => newFirebaseToken=value);

    _showIntroDialog = ! (deviceId != null && isRegistered != null && isRegistered);

    User user = User(device_token: newFirebaseToken, device_type: "android");
    //Show Instructions and register app
    if(_showIntroDialog) {
      await _showRegisterDialog();
      //registerApi call
      await _registerApiDialog(user);

      sharedPref.setString("deviceId", newUserInfo.deviceId);
      sharedPref.setString("deviceToken", newUserInfo.device_token);
    }
    else if(newFirebaseToken != firebaseToken) {
      //update the firebase token
    }

    //Init
    setState(() {
      _pages = <Widget>[
        FeedScreen(newUserInfo.deviceId),
        SettingScreen(newUserInfo.deviceId)
      ];
    });


  }

  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
          child: PageView(
            controller: _pageController,
            children: _pages,
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled) , label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
        ],
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _showLoaderPage(){
    return Center(
      child:
        Center(child: CircularProgressIndicator(),),
    );
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedPageIndex = index;
      _pageController.jumpToPage(index);
    });
  }


  //Show registration modal
  Future<void> _showRegisterDialog(){
    return showDialog(context: this.context, barrierDismissible: false,
        builder: (BuildContext context){
          var stackIndex = 1;
            return StatefulBuilder(
                builder: (context, setState){
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        height: 287,
                        width: 300,
                        child: Container( decoration: BoxDecoration(color: Colors.red),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //Title
                              Container(decoration: BoxDecoration(color: Colors.green), child: SizedBox(height: 40, child: Center(child: Text("GradCafe Notifier"),),)),
                              Container(decoration: BoxDecoration(color: Colors.greenAccent), child: Divider(height: 7,),),
                              //Content Box
                              Container(decoration: BoxDecoration(color: Colors.blue), child:
                              SizedBox( height: 200,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(decoration: BoxDecoration(color: Colors.blueGrey),
                                            child: stackIndex>0 ? SizedBox(
                                                width: 40,
                                                child:
                                                Center(child:
                                                IconButton(icon: const Icon(Icons.chevron_left), padding: EdgeInsets.zero, constraints: BoxConstraints(), onPressed: () {
                                                  setState(() {
                                                    stackIndex = stackIndex - 1;
                                                  });
                                                })
                                                )
                                            ): SizedBox(width: 40,)
                                        ),
                                        Container(decoration: BoxDecoration(color: Colors.yellow), child: SizedBox(
                                            width: 220,
                                            child:
                                            IndexedStack(
                                              index: stackIndex,
                                              children: <Widget>[
                                                Container(child: Center(child: Text("Page 1"))),
                                                Container(child: Center(child: Text("Page 2 long long long long long lon glon glon glon globg lob glob ghjdshj"))),
                                                Container(child: Center(child: Text("Page 3 "))),
                                              ],
                                            )
                                        ),),
                                        Container(decoration: BoxDecoration(color: Colors.white70), child:
                                        stackIndex<2 ?
                                        SizedBox(
                                            width: 40,
                                            child:
                                            Center(child:
                                            IconButton(icon: const Icon(Icons.chevron_right, ), padding: EdgeInsets.zero, constraints: BoxConstraints(), onPressed: () {
                                              setState(() {
                                                stackIndex = stackIndex + 1;
                                              });
                                            })
                                            )
                                        ) : SizedBox(width: 40,))
                                      ],
                                    )
                              )),
                              //Button space
                              Container(decoration: BoxDecoration(color: Colors.brown), child:
                              stackIndex==2 ?
                                SizedBox(height: 40, child: TextButton(onPressed: (){ Navigator.pop(context, true);}, child: Text("Got it!"))) :
                                  SizedBox(height: 40,))
                            ],
                          ),
                        )
                      ),
                    );
                });
    });
  }

  Future<void> _registerApiDialog(User user){
    return showDialog(context: this.context, barrierDismissible: false,
      builder: (BuildContext context){
          return FutureBuilder(
              future: registerRepo.registerUser(user),
              builder: (BuildContext buildContext, AsyncSnapshot<Result> snapshot){
                if(snapshot.data is SuccessState){
                  newUserInfo = (snapshot.data as SuccessState).value;
                  return InfoDialog("Registration complete", context);
                } else if(snapshot.data is ErrorState){
                  return InfoDialog("Registration Failed", context);
                }
                else{
                  return LoadingDialog("Registering the device", context);
                }
          });
      });
  }
}