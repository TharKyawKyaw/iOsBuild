import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_love_liquor/child_tabs/edit_tab.dart';
import 'package:i_love_liquor/child_tabs/purchased_history.dart';
import 'package:i_love_liquor/child_tabs/setting_tab.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/data_save/user_data.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';
import 'package:i_love_liquor/main_tabs/home_widget.dart';
import 'package:http/http.dart' as http;
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_widget.dart';
import 'dart:convert' as JSON;


Map userProfile;
final facebookLogin = FacebookLogin();
List<UserInfo> _userInfo;
bool loading = false;
final FirebaseAuth firebaseAuth =  FirebaseAuth.instance;
SharedPreferences preferences;
bool _newLogin = false;
bool _login = false;

final GoogleSignIn googleSignIn = new GoogleSignIn();


TextEditingController item_quantity;

class SignInTab extends StatefulWidget {

  _SignInTabState createState() => _SignInTabState();

}

class _SignInTabState extends State<SignInTab> {

  bool _loading= true;
  GoogleSignInAccount _currentUser;

  TextEditingController _userController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  Future<List<UserData>> GgLogInVersion(String name ,String googleID ,String userImageURL , String email) async{

    final prefs = await SharedPreferences.getInstance();
    final response = await http.post("$primaryUrl$userAuthUrl",headers: {"Content-type": "application/json"},
        body:jsonEncode({
          "name": name,
          "googleID": googleID,
          "email": email,
        }));
    var userToken = List<UserToken>();
    if(response.statusCode == 200){
      var token = json.decode(response.body);
      userToken.add(UserToken.fromJson(token));
      if(mounted){
        setState(() {
          var _token = userToken[0].token;
          user_token =_token;
          storage.setItem("User GoogleID", googleID);
          isSignin = false;
        });
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>
            AccountTab()),
      );
      return null;
    }
    else{
      List<UserData> googleUser =await GgRegisterVersion(name , googleID , userImageURL , email);
      return null;
    }
  }

  Future<List<UserData>> FbLogInVersion(String name ,String facebookID ,String userImageURL) async{

    final prefs = await SharedPreferences.getInstance();
    final response = await http.post("$primaryUrl$userAuthUrl",headers: {"Content-type": "application/json"},
        body:jsonEncode({
          "name": name,
          "facebookID": facebookID,
        }));


    var userToken = List<UserToken>();
    if(response.statusCode == 200){
      var token = json.decode(response.body);
      userToken.add(UserToken.fromJson(token));
      setState(() {
        var _token = userToken[0].token;
        user_token =_token;
        storage.setItem("User FacebookID", facebookID);
        isSignin = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            AccountTab()),
      );
      return null;
    }
    else{
      List<UserData> facebookUser =await FbRegisterVersion(name , facebookID , userImageURL);
    }

  }

  Future<List<UserData>> GgRegisterVersion(String name , String googleID , String userImageURL , String email) async{

    final prefs = await SharedPreferences.getInstance();
    final response = await http.post("$primaryUrl$userUrl",headers: {"Content-type": "application/json"},
        body:jsonEncode({
          "name": name,
          "googleID": googleID,
          "userImageURL": userImageURL,
          "email": email
        }));



    var userToken = List<UserToken>();

    if(response.statusCode == 200){

      var token = json.decode(response.body);
      userToken.add(UserToken.fromJson(token));
      setState(() {
        var _token = userToken[0].token;
        user_token =_token;
        storage.setItem("User GoogleID", googleID);
        isSignin = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            AccountTab()),
      );
      final String responseString = response.body;
      return null;
    }
    else{
      return null;
    }

  }

  Future<List<UserData>> FbRegisterVersion(String name , String facebookID , String userImageURL) async{

    final prefs = await SharedPreferences.getInstance();
    final response = await http.post("$primaryUrl$userUrl",headers: {"Content-type": "application/json"},
        body:jsonEncode({
          "name": name,
          "facebookID": facebookID,
          "userImageURL": userImageURL,
        }));


    var userToken = List<UserToken>();

    if(response.statusCode == 200){

      var token = json.decode(response.body);
      userToken.add(UserToken.fromJson(token));
      setState(() {
        var _token = userToken[0].token;
        user_token =_token;
        storage.setItem("User FacebookID", facebookID);
        isSignin = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            AccountTab()),
      );
      final String responseString = response.body;
      return null;
    }
    else{
      return null;
    }

  }



  Future _loginWithGoogle() async{

    preferences = await SharedPreferences.getInstance();

    GoogleSignInAccount googleUser = await googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
    GoogleAuthCredential credential = await GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    final User user = (await firebaseAuth.signInWithCredential(credential)).user;

    setState(() {
      user_name = user.displayName;
      user_ggID = user.providerData.single.uid;
      user_photo = user.photoURL;
      user_email = user.email ;
    });
    await GgLogInVersion(user_name ,user_ggID , user_photo , user_email);
  }

  _loginWithFB() async{

    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final fbToken = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${fbToken}');
        final profile = JSON.jsonDecode(graphResponse.body);



        setState(() {
          userProfile = profile;
          user_name = userProfile['name'];
          user_fbID = userProfile['id'];
          user_photo = userProfile['picture']['data']['url'];
          isFBLoggedIn = true;

        });
        await FbLogInVersion(user_name ,user_fbID , user_photo);
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => isFBLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => isFBLoggedIn = false );
        break;
    }

  }

  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/30 ;
    double _btnHeight = deviceHeight/20;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: lightGreenColor,
        resizeToAvoidBottomInset: true,
        body: ListView(
          padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //Login With Google
                Container(
                  height: _btnHeight,
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: (){
                      _loginWithGoogle();
                    },
                    child: Text(translator.translate('Log in with Google') , style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto_Thin',
                        fontSize: _fontSize)  ),
                    color: ggBgColor,

                  ),
                ),
                SizedBox(height: 20),
                //Login With Facebook
                Container(
                  height: _btnHeight,
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: (){
                      _loginWithFB();
                    },
                    child: Text(translator.translate('Log in with Facebook') , style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto_Thin',
                        fontSize: _fontSize)  ),
                    color: fbBgColor,

                  ),
                ),
              ],
            ),
          ],
        )



    );
  }

  void AlartBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;


    var alert = AlertDialog(
      content: Text(translator.translate("Please Enter all data") ,style: TextStyle(fontSize: _fontSize ,
        fontFamily: 'Roboto_Thin',)),
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

}

class AccountTab extends StatefulWidget {

  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {

  bool get wantKeepAlive => true;
  bool _loading = true;

  Future<List<UserInfoData>> UserDataGet(String token) async{
    setState(() {
      _loading = true;
    });
    final response = await http.get("$primaryUrl$userAuthUrl",headers: {"x-auth-token": "$token"});

    var datas = List<UserInfoData>();

    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);
      datas.add(UserInfoData.fromJson(datasJson));
      if(mounted){
        setState(() {
          _loading = false;
        });
      }
      return datas;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  checkLogin()async{
    var duration = new Duration(seconds: 3);
    new Future.delayed(duration);
    if(user_token != null ){
      UserDataGet(user_token).then((value) {
        if(mounted){
          setState(() {
            userInfo = [];
            userInfo.addAll(value);
            isSignin = false;
          });
        }
      });
    }
    if(user_token == null){
      if(mounted){
        setState(() {
          isSignin = true;
        });
      }
    }
  }

  _signOut() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSignin = true;
    });
    googleSignIn.signOut();
    facebookLogin.logOut();
    storage.clear();
    user_token = null;
    prefs.remove("Login Token");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        AccountTab()));
  }
  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize = deviceWidth/20;
    double nameFontSize  = deviceWidth/25;
    double infoFontSize  = deviceWidth/30;
    double btnFontSize  = deviceWidth/32;
    double _paddingHeight = deviceHeight/30;
    double _btnpaddingHeight = deviceHeight/50;
    double _profileImageHeight = deviceHeight/5;
    double _profileInfoHeight = deviceHeight/5.7;
    double _buttonHeight =deviceHeight/15;

    TextStyle _infoTextStyle= TextStyle(
      color: whiteTextColor , fontSize: infoFontSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold ,
    );



    return Scaffold(
      backgroundColor: lightGreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(titleTexts ,
          style: TextStyle(color: whiteTextColor ,
              fontFamily: 'Roboto_Thin', fontSize: _titleFontSize),
        ),
        backgroundColor: darkGreenColor,
        elevation: elevationShadow,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    SettingTab()),
              );
            },
          ),
        ],
      ),
      // body: SignInTab(),
      body: isSignin
          ?SignInTab()
          :_loading
          ?Center(child: CircularProgressIndicator())
          :ListView(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        primary: true,
        shrinkWrap: true,
        children: <Widget> [
          //Product Image
          Container(
            child: new Container(
                height: _profileImageHeight,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black26,
                    image: new DecorationImage(
                        image: new NetworkImage(userInfo[0].userImageURL),
                        fit: BoxFit.fitHeight
                    ))
            ),
          ),
          SizedBox(height: _paddingHeight,),
          //User Name
          Container(
            child: Container(
                child: Text(userInfo[0].name, style: TextStyle(
                    fontSize: nameFontSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold ,
                    color: whiteTextColor
                ),)),
          ),
          SizedBox(height: _paddingHeight,),
          //User Info
          Container(
            height: _profileInfoHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex:2,
                          child:Text(translator.translate('Phone' ), textAlign: TextAlign.start, style: _infoTextStyle,)),
                      Expanded(
                          flex: 2,
                          child: Text(translator.translate('Email') , textAlign: TextAlign.start,style: _infoTextStyle,)),
                      Expanded(
                          flex: 5,
                          child: Text(translator.translate('Address') , textAlign: TextAlign.start,softWrap: false,style: _infoTextStyle,)
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(":",textAlign: TextAlign.center,style: _infoTextStyle,)),
                      Expanded(
                          flex: 2,
                          child: Text(":",textAlign: TextAlign.center,style: _infoTextStyle)),
                      Expanded(
                          flex: 5,
                          child: Text(":",textAlign: TextAlign.center,style: _infoTextStyle)),
                    ],
                  ),
                ),
                Expanded(
                  flex:9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(userInfo[0].phoneNumber == null ? "" : userInfo[0].phoneNumber , textAlign: TextAlign.start,style: _infoTextStyle)
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(userInfo[0].email == null ? "" : userInfo[0].email,textAlign: TextAlign.start,style: _infoTextStyle )
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: Text(userInfo[0].address == null ? "" : userInfo[0].address,
                              softWrap: true ,textAlign: TextAlign.start,style: _infoTextStyle ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Two Button
          Container(
              width: double.infinity,
              color: darkGreenColor,
              child: FlatButton(
                child: Text(translator.translate('Edit Account'),style: TextStyle(
                  fontSize: btnFontSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold ,
                  color: Colors.white70,
                  textBaseline: TextBaseline.alphabetic, ),
                  textAlign: TextAlign.start, ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditTab()));
                },
              )
          ),
          SizedBox(height: _btnpaddingHeight,),
          Container(
              width: double.infinity,
              color: darkGreenColor,
              child: FlatButton(
                child: Text(translator.translate('Purchased History'),style: TextStyle(
                  fontSize: btnFontSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold ,
                  color: Colors.white70,
                ),),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PurchasedHistory()));
                },
              )
          ),
          SizedBox(height: _btnpaddingHeight,),
          Container(
              width: double.infinity,
              color: darkGreenColor,
              child: FlatButton(
                child: Text(translator.translate('Sign Out'),style: TextStyle(
                  fontSize: btnFontSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold ,
                  color: Colors.white70,
                ),),
                onPressed: (){
                  _signOut();
                },
              )
          ),
          /*Container(
              child: Container(
                width: double.infinity,
                height: _buttonHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditTab()));
                    },
                      child: Text(translator.translate('Edit Account'),style: TextStyle(
                          fontSize: btnFontSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold ,
                        color: Colors.white70,
                        textBaseline: TextBaseline.alphabetic,
                      ),textAlign: TextAlign.start,
                      )),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PurchasedHistory()));
                        },
                        child: Text(translator.translate('Purchased History'),style: TextStyle(
                            fontSize: btnFontSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold ,
                          color: Colors.white70,
                        ),)),
                  ]
                ),
              ),
            ),*/
        ],
      ),

    );
  }
}
