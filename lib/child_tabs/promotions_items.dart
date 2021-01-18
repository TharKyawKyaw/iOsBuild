import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:i_love_liquor/child_tabs/my_cart_tab.dart';
import 'package:i_love_liquor/child_tabs/product_detail_tab.dart';
import 'package:i_love_liquor/child_tabs/products_list_tab.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/data_save/region_data.dart';
import 'package:i_love_liquor/data_save/user_data.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';
import 'package:i_love_liquor/main_tabs/home_tab.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

int item_count = 6;
int card_count = 10;
bool cardFull = false;



class Coupons extends StatefulWidget {
  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {

  bool _loading = false;
  String _coupon;
  String golden_coupon = 'assets/promotions/Gold discount.png';
  String silver_coupon = 'assets/promotions/Silver discount.png';
  String bronze_coupon = 'assets/promotions/Bronze discount.png';
  var golden_coupon_list=[
    'assets/promotions/Gold discount.png',
    'assets/promotions/Gold discount.png',
    'assets/promotions/Gold discount.png',
    'assets/promotions/Gold discount.png',
  ];
  var silver_coupon_list=[
    'assets/promotions/Silver discount.png',
    'assets/promotions/Silver discount.png',
  ];
  var bronze_coupon_list=[
    'assets/promotions/Bronze discount.png',
    'assets/promotions/Bronze discount.png',
    'assets/promotions/Bronze discount.png',
  ];

  initState(){

    if(user_token != null ){
      UserDataGet(user_token).then((value) {
        setState(() {
          userInfo = [];
          userInfo.addAll(value);
        });
      });
    }

  }

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
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize = deviceWidth/20;
    double _couponFontSize = deviceWidth/35;
    double _fontSize = deviceWidth/30;
    double _warningWidth =deviceWidth/4;
    double _couponTitleWidth =deviceWidth/4;
    double _bottomTextBoxWidth =deviceWidth/4;
    double _warningHeight = deviceHeight/18;
    double _containerSmallHeight =deviceHeight/8;
    double _containerBigHeight =deviceHeight/25;
    double _containerHeight = deviceHeight/10;
    double _couponTitleHeight = deviceHeight/15;

    double _aspectRatio =(deviceWidth/3)/(deviceHeight/6);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      backgroundColor: lightGreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(titleTexts ,
          style: TextStyle(color: whiteTextColor ,
              fontFamily: 'Roboto_Thin',fontSize: _titleFontSize),
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
      body: _loading
          ?Center(child: CircularProgressIndicator())
          :ListView(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        children: <Widget>[
          Container(
            width: _warningWidth,
            height: _warningHeight,
            child: Center(
                child: Text("${promotiondata[0].couponsDescription}" ,
                  style: TextStyle(fontSize: _fontSize,
                    fontWeight: FontWeight.bold,
                    color: whiteTextColor,
                    fontFamily: 'Roboto_Thin',),softWrap: true,
                )
            ),
          ),
          //Golden Coupon
          Container(
            width: _couponTitleWidth,
            height: _couponTitleHeight,
            child: Center(
                child: Image.asset('assets/promotions/Gold.png')
            ),
          ),
          Container(
            width: _couponTitleWidth,
            height: _containerBigHeight,
            child: Center(
                child: Text(translator.translate("Golden Coupon") ,
                  style: TextStyle(fontSize: _couponFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                    fontFamily: 'Roboto_Thin',),softWrap: true,
                )
            ),
          ),
          Container(
            height: _containerHeight,
            width: double.infinity,
            child: GridView.builder(
                primary: false,
                itemCount: 5,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,
                    childAspectRatio: _aspectRatio),
                itemBuilder: (BuildContext context, int index) {
                  if(user_token != null && userInfo[0].goldCoupons != null){
                    if(index+1 <= userInfo[0].goldCoupons && userInfo[0].goldCoupons !=0 ){
                      return
                        InkWell(
                            onTap: (){
                              if(goldCoupon == 0 && !couponUsed){
                                GoldCouponUse(context);
                              }
                              else{
                                CouponUsedBox(context);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  new Container(
                                      decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                            image: new AssetImage(golden_coupon),
                                          ))),

                                ],

                              ),
                            ));
                      /*new Container(
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(bronze_coupon_list[index].toString()),
                              )));*/
                    }
                    else{
                      return Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            new Container(
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage("assets/promotions/promotion bg.png"),
                                    ))),

                          ],

                        ),
                      );
                    }
                  }
                  else{
                    return Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          new Container(
                              decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage("assets/promotions/promotion bg.png"),
                                  ))),

                        ],

                      ),
                    );
                  }
                }
            ),
          ),
          //Silven Coupon
          Container(
            width: _couponTitleWidth,
            height: _couponTitleHeight,
            child: Center(
                child: Image.asset('assets/promotions/Silver.png')
            ),
          ),
          Container(
            width: _couponTitleWidth,
            height: _containerBigHeight,
            child: Center(
                child: Text(translator.translate("Silver Coupon") ,
                  style: TextStyle(fontSize: _couponFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                    fontFamily: 'Roboto_Thin',),softWrap: true,
                )
            ),
          ),
          Container(
            height: _containerHeight,
            width: double.infinity,
            child: GridView.builder(
                primary: false,
                itemCount: 5,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,
                    childAspectRatio: _aspectRatio),
                itemBuilder: (BuildContext context, int index) {
                  if(user_token != null&& userInfo[0].silverCoupons != null){
                    if(index+1 <= userInfo[0].silverCoupons && userInfo[0].silverCoupons !=0 ){
                      return
                        InkWell(
                            onTap: (){
                              if(silverCoupon == 0 && !couponUsed){
                                SilverCouponUse(context);
                              }
                              else{
                                CouponUsedBox(context);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  new Container(
                                      decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                            image: new AssetImage(silver_coupon),
                                          ))),

                                ],

                              ),
                            ));
                    }
                    else{
                      return Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            new Container(
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage("assets/promotions/promotion bg.png"),
                                    ))),

                          ],

                        ),
                      );
                    }
                  }
                  else{
                    return Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          new Container(
                              decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage("assets/promotions/promotion bg.png"),
                                  ))),

                        ],

                      ),
                    );
                  }
                }
            ),
          ),
          //Bronze Coupon
          Container(
            width: _couponTitleWidth,
            height: _couponTitleHeight,
            child: Center(
                child: Image.asset('assets/promotions/Bronze.png')
            ),
          ),
          Container(
            width: _couponTitleWidth,
            height: _containerBigHeight,
            child: Center(
                child: Text(translator.translate("Bronze Coupon") ,
                  style: TextStyle(fontSize: _couponFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                    fontFamily: 'Roboto_Thin',),softWrap: true,
                )
            ),
          ),
          Container(
            height: _containerHeight,
            width: double.infinity,
            child: GridView.builder(
                primary: false,
                itemCount: 5,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,
                    childAspectRatio: _aspectRatio),
                itemBuilder: (BuildContext context, int index) {
                  if(user_token != null && userInfo[0].bronzeCoupons != null){
                    if(index+1 <= userInfo[0].bronzeCoupons && userInfo[0].bronzeCoupons !=0 ){
                      return
                        InkWell(
                            onTap: (){
                              if(bronzeCoupon == 0 && !couponUsed){
                                BronzeCouponUse(context);
                              }
                              else{
                                CouponUsedBox(context);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  new Container(
                                      decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                            image: new AssetImage(bronze_coupon),
                                          ))),
                                ],

                              ),
                            ));
                    }
                    else{
                      return Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            new Container(
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage("assets/promotions/promotion bg.png"),
                                    ))),
                          ],

                        ),
                      );
                    }
                  }
                  else{
                    return Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          new Container(
                              decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage("assets/promotions/promotion bg.png"),
                                  ))),
                        ],

                      ),
                    );
                  }
                }
            ),
          ),
          //Des
          Container(
              width: _bottomTextBoxWidth,
              height: _containerSmallHeight,
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(translator.translate("* Get a Golden Coupon with ${promotiondata[0].paymentRequiredForGoldCoupon} mmk in single payment.") ,
                    style: TextStyle(fontSize: _couponFontSize,
                      fontWeight: FontWeight.bold,
                      color: whiteTextColor,
                      fontFamily: 'Roboto_Thin',),softWrap: true,
                  ),
                  Text(translator.translate("* Get a Silver Coupon with ${promotiondata[0].paymentRequiredForSilverCoupon} mmk in single payment.") ,
                    style: TextStyle(fontSize: _couponFontSize,
                      fontWeight: FontWeight.bold,
                      color: whiteTextColor,
                      fontFamily: 'Roboto_Thin',),softWrap: true,
                  ),
                  Text(translator.translate("* Get a Bronze Coupon with ${promotiondata[0].paymentRequiredForBronzeCoupon} mmk in single payment.") ,
                    style: TextStyle(fontSize: _couponFontSize,
                      fontWeight: FontWeight.bold,
                      color: whiteTextColor,
                      fontFamily: 'Roboto_Thin',),softWrap: true,
                  ),
                ],
              ),
          ),
        ],
      ),
    );


  }

  void AlartBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;

    var alert = AlertDialog(
      content: Text(translator.translate("Your cart is empty!") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

  void CouponUsedBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;

    var alert = AlertDialog(
      content: Text(translator.translate("You can only use coupon once a times") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

  Widget GoldCouponUse (BuildContext context){

    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;

    Widget yesButton  = FlatButton(
        onPressed: (){
          Navigator.of(context,rootNavigator: true).pop();
          couponUsed = true;
          goldCoupon = 1;
          setState(() {
            _coupon ="Gold";
            userInfo[0].goldCoupons = userInfo[0].goldCoupons-1;
          });

        },
        child: Text('Yes'));

    Widget noButton  = FlatButton(
        onPressed: (){
          Navigator.of(context,rootNavigator: true).pop();
        },
        child: Text('No'));

    var alert = AlertDialog(
      content: Text(translator.translate("Do you want to use coupon?") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      actions: [
        noButton,
        yesButton
      ],
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

  Widget SilverCouponUse (BuildContext context){

    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;

    Widget yesButton  = FlatButton(
        onPressed: (){
          Navigator.of(context,rootNavigator: true).pop();
          couponUsed = true;
          silverCoupon = 1;
          setState(() {
            _coupon ="Silver";
            userInfo[0].silverCoupons = userInfo[0].silverCoupons-1;
          });
        },
        child: Text('Yes'));

    Widget noButton  = FlatButton(
        onPressed: (){
          Navigator.of(context,rootNavigator: true).pop();
        },
        child: Text('No'));

    var alert = AlertDialog(
      content: Text(translator.translate("Do you want to use coupon?") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      actions: [
        noButton,
        yesButton
      ],
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

  Widget BronzeCouponUse (BuildContext context){

    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;

    Widget yesButton  = FlatButton(
        onPressed: (){
          Navigator.of(context,rootNavigator: true).pop();
          couponUsed = true;
          bronzeCoupon = 1;
          setState(() {
            _coupon ="Bronze";
            userInfo[0].bronzeCoupons = userInfo[0].bronzeCoupons-1;
          });
        },
        child: Text('Yes'));

    Widget noButton  = FlatButton(
        onPressed: (){
          Navigator.of(context,rootNavigator: true).pop();
        },
        child: Text('No'));

    var alert = AlertDialog(
      content: Text(translator.translate("Do you want to use coupon?") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      actions: [
        noButton,
        yesButton
      ],
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }


}

class RoyaltyCard extends StatefulWidget {
  @override
  _RoyaltyCardState createState() => _RoyaltyCardState();
}

class _RoyaltyCardState extends State<RoyaltyCard> {

  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RegionsData selectedTownship;
  String _townShip ="Select Township";
  int deli_price;
  String deli_township;
  List<RegionsData> regionData = List<RegionsData>();
  String stickerImg = 'assets/promotions/sticker.png';
  bool _loading=false;

  initState(){
    if(user_token != null ){
      UserDataGet(user_token).then((value) {
        if(mounted){
          setState(() {
            userInfo = [];
            userInfo.addAll(value);

          });
        }
      });
      getRegions().then((value){
        if(mounted){
          setState(() {
            regionData = [];
            regionData.addAll(value);
          });
        }
      });
      setState(() {
        isSignin = false;
      });
    }

  }

  Future<List<UserInfoData>> UserDataGet(String token) async{
    setState(() {
      _loading = true;
    });
    final response = await http.get("$primaryUrl$userAuthUrl",headers: {"x-auth-token": "$token"});

    var datas = List<UserInfoData>();

    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);
      datas.add(UserInfoData.fromJson(datasJson));
      setState(() {
        _loading = false;
      });
      return datas;
    }
  }

  Future<List<RegionsData>> getRegions() async{

    var response = await http.get("$primaryUrl$regionUrl" ,
        headers: {"x-auth-token": "$user_token",});

    var datas = List<RegionsData>();
    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);
      for(var dataJson in datasJson){
        datas.add(RegionsData.fromJson(dataJson));
      }
      return datas;
    }
  }

  Future<List<UserData>> GiftClaim(String contactNumber,String giftDeliveryAddress ,String deliveryRegion) async{

    final response = await http.post("$primaryUrl$girtClaimUrl",
        headers: {"x-auth-token": "$user_token" , "Content-type": "application/json"},
        body:jsonEncode({
          "contactNumber": contactNumber,
          "giftDeliveryAddress": giftDeliveryAddress,
          "deliveryRegion": deliveryRegion,
        }));
    if(response.statusCode == 200){
      setState(() {
        userInfo[0].stickers -= 10;
      });
      GiftSuccess(context);
      return null;
    }
    else{
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize = deviceWidth/20;
    double _fontSize = deviceWidth/30;
    double _titleImage =deviceWidth/6;
    double _paddingWidth= deviceWidth/100;
    double _ruleTextBoxWidth = deviceWidth/1.45;
    double _containerHeight = deviceHeight/10;
    double _commonContainerHeight = deviceHeight/15;
    double _containerMedHeight = deviceHeight/17;
    double _cardListHeight = deviceHeight/4.5;
    double _containerSmallHeight = deviceHeight/7.5;
    double _paddingHeight= deviceHeight/100;
    double _bottomContainerHeight = deviceHeight/2;

    double _aspectRatio = (deviceWidth/3)/(deviceHeight/5.2);

    return Scaffold(
      backgroundColor: lightGreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(titleTexts ,
          style: TextStyle(color: whiteTextColor ,
              fontFamily: 'Roboto_Thin',fontSize: _titleFontSize),
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
      body: _loading
          ?Center(child: CircularProgressIndicator())
          :ListView(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        children: <Widget>[
          //title Image
          Container(
            width: _titleImage,
            height: _containerHeight,
            child: Center(
                child: Image.asset('assets/promotions/Royalty card title.png')
            ),
          ),
          SizedBox(height: _paddingHeight,),
          //Card Grid
          Container(
            height: _cardListHeight,
            width: double.infinity,
            child: GridView.builder(
              primary: false,
                itemCount: promotiondata[0].stickersRequiredForGift,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,
                    childAspectRatio: _aspectRatio),
                itemBuilder: (BuildContext context, int index) {
                if(user_token != null && userInfo[0].stickers != null){
                  if(index+1 <= userInfo[0].stickers && userInfo[0].stickers != 0){
                    return
                      new Container(
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(stickerImg),
                              )));
                  }
                  else{
                    return Container(
                      child: Image.asset('assets/promotions/promotion bg.png'),
                    );
                  }
                }
                else{
                  return Container(
                    child: Image.asset('assets/promotions/promotion bg.png'),
                  );
                }
                }
            ),
          ),
          SizedBox(height: _paddingHeight,),
          //Gift Picture And Information
          Container(
            padding: EdgeInsets.fromLTRB(_paddingWidth, 10, _paddingWidth, 0),
            color: Colors.white,
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: double.infinity,
                      height: _containerSmallHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: deviceWidth/4.5,
                              child: Image.network("${promotiondata[0].giftImageURL}", fit: BoxFit.cover ,
                                  width: double.infinity)
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: _containerMedHeight,
                                    child: Text(translator.translate("*") ,
                                      style: TextStyle(fontSize: _fontSize,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto_Thin',),softWrap: true,
                                    )
                                ),
                                SizedBox(height: 5,),
                                Container(
                                    height: _containerMedHeight,
                                    child: Text(translator.translate("*") ,
                                      style: TextStyle(fontSize: _fontSize,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black38,
                                        fontFamily: 'Roboto_Thin',),softWrap: true,
                                    )
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: _containerMedHeight,
                                    width: _ruleTextBoxWidth,
                                    child: Text(translator.translate("Get a sticker for every ${promotiondata[0].paymentRequiredForSticker} mmk \t\tpurchase.") ,
                                      style: TextStyle(fontSize: _fontSize,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto_Thin',),softWrap: true,
                                    )
                                ),
                                SizedBox(height: 5,),
                                Container(
                                    height: _containerMedHeight,
                                    width: _ruleTextBoxWidth,
                                    child: Text(translator.translate("Claim special gift with ${promotiondata[0].stickersRequiredForGift} stickers.") ,
                                      style: TextStyle(fontSize: _fontSize,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto_Thin',),softWrap: true,
                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                  SizedBox(height: _paddingHeight,),
                  Container(
                    child: Center(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Special Gift' , style: TextStyle(
                              fontSize: _fontSize , fontFamily: 'Roboto_Thin',fontWeight: FontWeight.bold
                          ),textAlign: TextAlign.left,)),
                    ),
                  ),
                  SizedBox(height: _paddingHeight,),
                  Container(
                    child: Center(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text('${promotiondata[0].giftDescription}' ,style: TextStyle(
                            fontSize: _fontSize , fontFamily: 'Roboto_Thin',fontWeight: FontWeight.bold
                        ), textAlign: TextAlign.justify,),),
                    ),
                  ),
                  SizedBox(height: _paddingHeight,),
                  SizedBox(height: _paddingHeight,),
                  //Claim Button
                  Container(
                    height: _commonContainerHeight,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: ()async{
                        if(userInfo[0].stickers >= promotiondata[0].stickersRequiredForGift){
                          AddressBox(context);
                        }
                        else{
                          //AddressBox(context);
                          AlartBox(context);
                        }
                      },
                      child: Text('Claim',style: TextStyle(
                        fontSize: _fontSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold ,
                        color: whiteTextColor,
                      ), textAlign: TextAlign.center,),
                    ),
                    color: lightGreenColor,
                  ),
                  SizedBox(height: _paddingHeight,),
                ]

            ),
          ),
          SizedBox(height: _paddingHeight,),
        ],
      ),
    );


  }

  void AlartBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;


    var alert = AlertDialog(
      content: Text(translator.translate("You don't have enough stickers!") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

  void GiftSuccess (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _headerFontSize = deviceWidth/22;
    double _fontSize = deviceWidth/25;

    var alert = AlertDialog(
      title: Text(translator.translate("Congratulation!!!") ,style: TextStyle(fontSize: _headerFontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      content: Text(translator.translate("Special gift added to your cart.") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

  void AddressBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    double _fontSize = deviceWidth/25;
    double _inputSize  =deviceWidth/30;

    Widget okButton  = FlatButton(
        onPressed: ()async{
          order_contactNumber = phoneController.text;
          order_deliveryAddress = addressController.text;
          if(order_deliveryAddress!="" && order_deliveryAddress!=null &&
              order_contactNumber!="" && order_contactNumber!=null &&
              order_deliveryRegion != "" && order_deliveryRegion != null ){
            Navigator.of(context,rootNavigator: true).pop();
            await GiftClaim(order_contactNumber,order_deliveryAddress, order_deliveryRegion);
          }
          else{
            WarningBox(context);
          }
        },
        child: Text(translator.translate("OK") ,style: TextStyle(fontSize: _fontSize,
            fontFamily: 'Roboto_Thin',
            fontWeight: FontWeight.bold),textAlign: TextAlign.center,));

    var alert = AlertDialog(
      title: Text(translator.translate("Please Enter address and contact number") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      content: StatefulBuilder(
        builder: (BuildContext context,StateSetter setState){
          return Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            width: deviceWidth/1.5,
            height: deviceHeight/3,
            child: Column(
              children: [
                phoneField(_inputSize),
                addressField1(_inputSize),
              DropdownButton<RegionsData>(
                iconEnabledColor: darkGreenColor,
                dropdownColor: lightGreenColor,
                hint: Text(_townShip , style: TextStyle(
                    fontFamily: 'Roboto_Thin',
                    fontSize: _inputSize
                ),),
                value: selectedTownship,
                onChanged: (RegionsData Value){
                  setState(() {
                    print(_townShip);
                    selectedTownship = Value;
                    deli_township = selectedTownship.name;
                    order_deliveryRegion = deli_township;
                    _townShip = order_deliveryRegion;
                  });
                },
                items: regionData.map((RegionsData township){
                  return DropdownMenuItem (
                      value: township,
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(township.name ,textAlign: TextAlign.center,style: TextStyle(
                                  fontFamily: 'Roboto_Thin',
                                  fontSize: _inputSize
                              ),),
                              SizedBox(width: 10),
                              Text(township.fee.toString() ,textAlign: TextAlign.center,style: TextStyle(
                                  fontFamily: 'Roboto_Thin',
                                  fontSize: _inputSize
                              ),),
                            ],
                          ))
                  );
                }).toList(),

              ),

              ],
            ),
          );
        }
      ),

      actions: [
        okButton
      ],
    );
    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });

  }

  Widget phoneField(double _fontSize) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: translator.translate('Your Phone'),
          hintStyle: new TextStyle(
            fontFamily: 'Roboto_Thin',
            fontSize: _fontSize,
          )
      ),
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Roboto_Thin',
          fontSize: _fontSize
      ),
      keyboardType: TextInputType.phone,
      controller: phoneController,
    );
  }

  Widget addressField1(double _fontSize) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: translator.translate('Your Address'),
          hintStyle: new TextStyle(
              fontFamily: 'Roboto_Thin',
              fontSize: _fontSize
          )
      ),
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Roboto_Thin',
          fontSize: _fontSize
      ),
      keyboardType: TextInputType.streetAddress,
      controller: addressController,
    );
  }

  Widget townshipField(double _fontSize){
    return DropdownButton<RegionsData>(
      hint: Text(_townShip , style: TextStyle(
          fontFamily: 'Roboto_Thin',
          fontSize: _fontSize
      ),),
      value: selectedTownship,
      onChanged: (RegionsData Value){
        setState(() {
          print(_townShip);
          selectedTownship = Value;
          deli_township = selectedTownship.name;
          order_deliveryRegion = deli_township;
          _townShip = order_deliveryRegion;
        });
      },
      items: regionData.map((RegionsData township){
        return DropdownMenuItem (
            value: township,
            child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(township.name ,textAlign: TextAlign.center,style: TextStyle(
                        fontFamily: 'Roboto_Thin',
                        fontSize: _fontSize
                    ),),
                    SizedBox(width: 5),
                    Text(township.fee.toString() ,textAlign: TextAlign.center,style: TextStyle(
                        fontFamily: 'Roboto_Thin',
                        fontSize: _fontSize
                    ),),
                  ],
                ))
        );
      }).toList(),

    );
  }

/*  Widget townshipField(double _fontSize){
    return Container(
      child: DropdownButton<RegionsData>(
        hint: Text(_townShip , style: TextStyle(
            fontFamily: 'Roboto_Thin',
            fontSize: _fontSize
        ),),
        value: selectedTownship,
        onChanged: (RegionsData Value){
          setState(() {
            selectedTownship = Value;
            deli_township = selectedTownship.name;
            order_deliveryRegion = deli_township;
            _townShip = order_deliveryRegion;
          });
        },
        items: regionData.map((RegionsData township){
          return DropdownMenuItem (
              value: township,
              child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(township.name ,textAlign: TextAlign.center,style: TextStyle(
                          fontFamily: 'Roboto_Thin',
                          fontSize: _fontSize
                      ),),
                    ],
                  ))
          );
        }).toList(),

      ),
    );
  }*/

  void WarningBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;

    var alert = AlertDialog(
      content: Text(translator.translate("Please Enter all data") ,style: TextStyle(fontSize: _fontSize),textAlign: TextAlign.center,),
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }
}


