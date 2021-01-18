import 'package:flutter/material.dart';
import 'package:i_love_liquor/data_save/news_data.dart';
import 'package:i_love_liquor/data_save/order_place.dart';
import 'package:i_love_liquor/data_save/promotion_data.dart';
import 'package:i_love_liquor/data_save/shop_data.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/main_tabs/home_widget.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:i_love_liquor/data_save/products_data.dart';
import 'package:i_love_liquor/data_save/user_data.dart';
import 'package:i_love_liquor/data_save/qna_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'account_tab.dart';
import 'home_widget.dart';
import 'dart:convert' as JSON;

import 'news_tab.dart';
List<String> category_list=List<String>();
final List<String> shop_list= List<String>();
final List<String> prodimage_list= List<String>();
List<UserInfoData> categoryInfo = List<UserInfoData>();
List<ProductInfo> productInfo = List<ProductInfo>();
List<ProductData> productdata = List<ProductData>();

List<ProductData> specialproductdata = List<ProductData>();
List<QandA> questiondata = List<QandA>();
List<Branches> branchesdata = List<Branches>();
List<Release> releasedata = List<Release>();
List<PromotionData> promotiondata = List<PromotionData>();
bool isSignin = true;

bool infoLoading = false;

String main_id;
String user_id;
String user_name;
String user_token;
String user_address;
String user_phone;
String user_photo;
String user_email;
String user_ggID;
String user_fbID;


Map userProfile;
String facebookUserID;
bool isFBLoggedIn = false;
bool promotionLoading;
bool dataLoading;
bool orderConfirm;
bool couponUsed = false;
int goldCoupon = 0;
int silverCoupon = 0;
int bronzeCoupon = 0;
bool is_shopList = true;
bool isAge = false;
String category;
int order_price;
int subtotal_amount;
int total_amount;
int initial_amount;
int discount = 0;
int tax = 0;
int selectedPayment;
bool isCOD = false;
bool isBank = false;
int selectedBank = 1;
int selectedCOD = 2;
int deliPrice = 0;
int order_deli = 0;
int order_subtotal;
String order_userID;
String order_productName;
String order_productID;
int order_quantity;
String order_deliveryAddress;
String order_deliveryRegion;
String order_contactNumber;


final primaryUrl = "https://iloveliquor-admin-panel.herokuapp.com";
final userUrl = "/api/users";
final userAuthUrl = "/api/userauth";
final productUrl = "/api/products";
final regionUrl = "/api/deliveryRegions";
final orderUrl = "/api/orders/";
final confrimOrderUrl ="/api/orders/confirmation/";
final faqUrl = "/api/qas";
final brancheUrl = "/api/branches";
final releaseUrl = "/api/pressRelease";
final editUrl = "/api/users";
final newsUrl = "/api/news";
final promotionUrl = "/api/promotions/";
final girtClaimUrl = "/api/giftClaims";
final LocalStorage storage = new LocalStorage('token');
final GoogleSignIn googleSignIn = new GoogleSignIn();


TextEditingController item_quantity;
List<UserInfoData> userInfo = List<UserInfoData>();
List<UserInfoData> signUserInfo = List<UserInfoData>();
List<ApplyOrder> userOrders = List<ApplyOrder>();
List<ApplyOrder> unconfirmInvoice = List<ApplyOrder>();



class FirstPage extends StatefulWidget {

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _loading =false;
  final facebookLogin = FacebookLogin();
  Map userProfile;
  List<UserInfo> _userInfo;
  bool loading = false;
  final FirebaseAuth firebaseAuth =  FirebaseAuth.instance;
  SharedPreferences preferences;

  Future<List<QandA>> fetchQuestion() async{

    var response = await http.get("$primaryUrl$faqUrl");
    var datas = List<QandA>();
    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);
      for(var dataJson in datasJson){
        datas.add(QandA.fromJson(dataJson));
      }
      return datas;
    }
  }

  Future<List<Branches>> fetchBranches() async{

    var response = await http.get("$primaryUrl$brancheUrl");
    var datas = List<Branches>();
    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);
      for(var dataJson in datasJson){
        datas.add(Branches.fromJson(dataJson));
      }
      return datas;
    }
  }

  Future<List<Release>> fetchRelease() async{
    var response = await http.get("$primaryUrl$releaseUrl");
    var datas = List<Release>();
    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);
      for(var dataJson in datasJson){
        datas.add(Release.fromJson(dataJson));
      }
      return datas;
    }
  }

  Future<List<PromotionData>> fetchPromotion() async{
    setState(() {
      promotionLoading = true;
    });
    var response = await http.get("$primaryUrl$promotionUrl");

    print(response.body);
    var datas = List<PromotionData>();
    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);
      for(var dataJson in datasJson){
        datas.add(PromotionData.fromJson(dataJson));
      }
      setState(() {
        promotionLoading = false;
      });
      return datas;
    }
  }

  Future<List<ProductData>> fetchProducts() async{
    setState(() {
      dataLoading = true;
    });
    var response = await http.get("$primaryUrl$productUrl");
    var datas = List<ProductData>();

    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);
      setState(() {
        for(var dataJson in datasJson){
          datas.add(ProductData.fromJson(dataJson));
        }
        dataLoading = false;
      });
      return datas;
    }
  }

  Future<List<NewsInfo>> fetchNews() async{
    news_open = true;
    var response = await http.get("$primaryUrl$newsUrl");
    var _news = new List<NewsInfo>();


    if(response.statusCode == 200 ){
      final newsJson = json.decode(response.body);
      for(var i in newsJson){
        _news.add(NewsInfo.fromJson(i));
      }
      news_open = false;
      return _news;
    }

  }

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
      setState(() {
        var _token = userToken[0].token;
        user_token =_token;
        storage.setItem("User GoogleID", googleID);
        prefs.setString("Login Token", _token);
        isSignin = false;
      });
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
        prefs.setString("Login Token", _token);
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


      setState(() {
        userInfo.addAll(datas);
        isSignin = false;
      });
      return datas;
    }


  }



  void initState() {
    // TODO: implement initState
    super.initState();
    loginCheck();
    fetchNews().then((value){
      setState(() {
        news_info = [];
        news_info.addAll(value);
      });
    });
    fetchPromotion().then((value){
      setState(() {
        promotiondata.addAll(value);
      });
    });
    fetchQuestion().then((value){
      setState(() {
        questiondata.addAll(value);
      });
    });
    fetchBranches().then((value){
      setState(() {
        branchesdata.addAll(value);
      });
    });
    fetchRelease().then((value){
      setState(() {
        releasedata.addAll(value);
      });
    });
    fetchProducts().then((value){
      setState(() {
        productdata.addAll(value);
      });
    });

  }

  loginCheck() async{
    var duration = new Duration(seconds: 3);

  new Future.delayed(duration);

    var _userggID = storage.getItem("User GoogleID");
    var _userfbID = storage.getItem("User FacebookID");

    user_ggID = _userggID;
    user_fbID = _userfbID;

    if(user_ggID != null){
      await GgLogInVersion(user_ggID);
    }
    if(user_fbID != null){
      await FbLogInVersion(user_fbID);
    }
    if(user_token != null){
      UserDataGet(user_token).then((value) {
        setState(() {
          userInfo = [];
          userInfo.addAll(value);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _logoHeight =deviceHeight/4;
    double _logoWidth = deviceWidth/2;

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: lightGreenColor,
      body:  (dataLoading || promotionLoading)
          ?Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: _logoWidth,
              height: _logoHeight,
              child: Center(child: Image.asset('assets/icons/loading.png')),
            ),
            Center(child: CircularProgressIndicator()),
            /*Container(
              child: Text('Power by Studio Puppeteer' ,style: TextStyle(color: whiteTextColor),),
            )*/
          ],
        ),
      )
          :BottomNavigationBarController()
    );
  }
}
