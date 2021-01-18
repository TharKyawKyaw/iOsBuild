import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:i_love_liquor/child_tabs/map_tab.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:i_love_liquor/data_save/user_data.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'package:i_love_liquor/main_tabs/home_shop_tab.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:i_love_liquor/child_tabs/aboutus_tab.dart';
import 'package:i_love_liquor/child_tabs/ourstore_tab.dart';
import 'package:i_love_liquor/child_tabs/my_cart_tab.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';
import 'package:http/http.dart' as http;


import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as JSON;
import 'first_tab.dart';


Map userProfile;
final facebookLogin = FacebookLogin();
List<UserInfo> _userInfo;
bool loading = false;
final FirebaseAuth firebaseAuth =  FirebaseAuth.instance;
SharedPreferences preferences;

List<UserInfoData> oneUser = List<UserInfoData>();
int value  = 0;

class HomeTab extends StatefulWidget {
  bool get wantKeepAlive => true;
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Future<void> _launched;
  bool _loading = true;
  bool _slidePlay = true;
  var _slideImage = [
    ExactAssetImage('assets/home/Home_01.jpg'),
    ExactAssetImage('assets/home/Home_02.jpg'),
    ExactAssetImage('assets/home/Home_03.jpg')
  ];

  var _slider= [];

  Future<List<UserData>> GgLogInVersion(String googleID) async{

    final prefs = await SharedPreferences.getInstance();
    final response = await http.post("$primaryUrl$userAuthUrl",headers: {"Content-type": "application/json"},
        body:jsonEncode({
          "googleID": googleID,
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
      return null;
    }
    else{
      return null;
    }
  }

  Future<List<UserData>> FbLogInVersion(String facebookID) async{

    final prefs = await SharedPreferences.getInstance();
    final response = await http.post("$primaryUrl$userAuthUrl",headers: {"Content-type": "application/json"},
        body:jsonEncode({
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
      return null;
    }
    else{
      return null;
    }

  }

  Future<List<UserInfoData>> UserDataGet(String token) async{

    final response = await http.get("$primaryUrl$userAuthUrl",headers: {"x-auth-token": "$token"});

    var datas = List<UserInfoData>();

    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);

      datas.add(UserInfoData.fromJson(datasJson));
      if(mounted){
        setState(() {
          userInfo.addAll(datas);
          isSignin = false;
        });
      }
      return datas;
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sliderImage();
    _checkAge();
    _checkLogin();
  }

  _sliderImage(){
    if(promotiondata[0].imageURL1 != null &&promotiondata[0].imageURL1 != "" ){
      _slider.add(promotiondata[0].imageURL1);
    }
    if(promotiondata[0].imageURL2 != null &&promotiondata[0].imageURL2 != "" ){
      _slider.add(promotiondata[0].imageURL2);
    }
    if(promotiondata[0].imageURL3 != null &&promotiondata[0].imageURL3 != "" ){
      _slider.add(promotiondata[0].imageURL3);
    }
    if(promotiondata[0].imageURL4 != null &&promotiondata[0].imageURL4 != "" ){
      _slider.add(promotiondata[0].imageURL4);
    }
    if(promotiondata[0].imageURL5 != null &&promotiondata[0].imageURL5 != "" ){
      _slider.add(promotiondata[0].imageURL5);
    }
  }

  _checkLogin()async{
    var duration = new Duration(seconds: 3);
    new Future.delayed(duration);
    var _userggID = storage.getItem("User GoogleID");
    var _userfbID = storage.getItem("User FacebookID");
    user_ggID = _userggID;
    user_fbID = _userfbID;
    print(user_ggID);
    print(user_fbID);
    if(user_ggID != null){
      await GgLogInVersion(user_ggID);
    }
    if(user_fbID != null){
      await FbLogInVersion(user_fbID);
    }

    if(user_token != null){
      UserDataGet(user_token).then((value) {
        if(mounted){
          setState(() {
            userInfo = [];
            userInfo.addAll(value);
          });
        }
      });
    }
  }
  @override
  Future<void> _launchInBrowser(String url , String fburl) async {

    try {
      bool launched =
      await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fburl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fburl, forceSafariVC: false, forceWebView: false);
    }

/*    if (await canLaunch(url)) {

      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {

      throw 'Could not launch $url';
    }*/
  }

  Future<void> _launchFBMessenger(String url) async {

    if (await canLaunch(url)) {

      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {



    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/40;
    double _titleFontsize = deviceWidth/20;
    double _imageSize =deviceHeight/16;
    double _containerHeight = deviceHeight/20;
    double _containerWidth= deviceHeight/7;

    Widget image_carousel = new Container(
        height: deviceHeight/2.7,
        child: new Carousel(
          boxFit: BoxFit.fill,
          images: _slideImage,
          autoplay: _slidePlay,
          animationCurve: Curves.fastLinearToSlowEaseIn,
          animationDuration: Duration(milliseconds: 1000),
          showIndicator: false,
        ));


    Widget image_slider= new Container(
      height: deviceHeight/2.7,
      width: double.infinity,
      child: new CarouselSlider(
          items: _slider.map((image) => Container(
            width: double.infinity,
            child: Center(
                child: Image.network(image, fit: BoxFit.fill ,
                width: double.infinity,)
            ),
          )).toList(),
          options: CarouselOptions(
            autoPlayAnimationDuration:  Duration(milliseconds: 1000),
            autoPlayInterval:  Duration(seconds: 3),
            height: deviceHeight/2.7,
            viewportFraction: 1,
            autoPlay: _slidePlay,
          )),

    );

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: lightGreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(titleTexts ,
          style: TextStyle(color: whiteTextColor ,
              fontFamily: 'Roboto_Thin',fontSize: _titleFontsize),
        ),
        backgroundColor: darkGreenColor,
        elevation: elevationShadow,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Bottom_Icons.base_icons_shop),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    MyCart()),
              );
            },
          ),
        ],
      ),
      body:dataLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          children: <Widget>[
            //Slider
            image_slider,
            SizedBox(height: 20),
            //Four Menu
            Container(
              height: deviceHeight/7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => AboutUsTab()),
                              );
                            },
                            child: Image(
                              height: _imageSize,
                              width: _imageSize,
                              image: AssetImage('assets/home/About_us.png'),
                            ),
                          ),
                          Container(
                            height: _containerHeight,
                            width: _containerWidth,
                            child: FlatButton(
                              onPressed: (){
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) =>AboutUsTab()),
                                );
                              },
                              child: Text(translator.translate('About_Us') , style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto_Light',
                                  fontSize: _fontSize),softWrap: false),
                            ),
                          )
                        ],
                      )
                  ),
                  //Our Store
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    OurStoreTab()),
                              );
                            },
                            child: Image(
                              height: _imageSize,
                              width: _imageSize,
                              image: AssetImage('assets/home/Our_Store.png'),
                            ),
                          ),

                          Container(
                            height: _containerHeight,
                            width: _containerWidth,
                            child: FlatButton(
                              onPressed: (){ Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    OurStoreTab()),
                              );
                                },
                              child: Text(translator.translate('Our_Store'), style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto_Light',
                                  fontSize: _fontSize),softWrap: false),
                            ),
                          )
                        ],
                      )
                  ),
                  //Our Page
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                const fbUrl = "https://www.facebook.com/iloveliquormyanmar";
                                _launched = _launchInBrowser('fb://page/350967185009249',fbUrl);
                              });
                            },
                            child: Image(
                              height: _imageSize,
                              width: _imageSize,
                              image: AssetImage('assets/home/facebook.png'),
                            ),
                          ),

                          Container(
                            height: _containerHeight,
                            width: _containerWidth,
                            child: FlatButton(
                              onPressed: (){
                                setState(() {
                                  const fbUrl = "https://www.facebook.com/iloveliquormyanmar";
                                  _launched = _launchInBrowser('fb://page/350967185009249',fbUrl);
                                });
                              },
                              child: Text(translator.translate('Our_Page'), style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto_Light',
                                  fontSize: _fontSize) , softWrap: false,),
                            ),
                          )
                        ],
                      )
                  ),
                  //Messenger
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                const fbMsg = "https://m.me/iloveliquormyanmar";
                                _launched = _launchFBMessenger(fbMsg);
                              });
                            },
                            child: Image(
                              height: _imageSize,
                              width: _imageSize,
                              image: AssetImage('assets/home/messenger.png'),
                            ),
                          ),

                          Container(
                            height: _containerHeight,
                            width: _containerWidth,
                            child: FlatButton(
                              onPressed: (){
                                setState(() {
                                  const fbMsg = "https://m.me/iloveliquormyanmar";
                                  _launched = _launchFBMessenger(fbMsg);
                                });
                              },
                              child: Text(translator.translate('Messenger'), style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto_Light',
                                  fontSize: _fontSize) , softWrap: false,),

                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            //Shop
            Container(
              height: deviceHeight/4.7,
                child: Container(
                  alignment: Alignment.center,
                    width: double.infinity,
                    child: FlatButton(
                        onPressed: (){
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) =>HomeShopTab()),
                          );
                        },
                      child: Image(
                          image: AssetImage('assets/home/shop_now.png')
                      ),
                    )
                )
            ),
          ],
      ),
    );

  }



  _checkAge()  async{
    if (!isAge) {
      Future.delayed(Duration.zero, () => _showAlert(context));
    }
  }

  Widget _showAlert (BuildContext context){

    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;

    Widget yesButton  = FlatButton(
        onPressed: (){
          setState(() {
            isAge = true;
          });
          Navigator.of(context,rootNavigator: true).pop();
        },
        child: Text(translator.translate("Age Yes") ,style: TextStyle(fontSize: _fontSize,
            fontFamily: 'Roboto_Thin',
            fontWeight: FontWeight.bold)));

    Widget noButton  = FlatButton(
        onPressed: (){
          exit(0);
        },
        child: Text(translator.translate("Age No") ,style: TextStyle(fontSize: _fontSize,
            fontFamily: 'Roboto_Thin',
            fontWeight: FontWeight.bold)));

    var alert = AlertDialog(
      content: Text(translator.translate("Are you over 18?") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      actions: [
        noButton,
        yesButton
      ],
    );

    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return alert;
        });
  }
}



