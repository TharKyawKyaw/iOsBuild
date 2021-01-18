import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:i_love_liquor/child_tabs/product_detail_tab.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/data_save/order_place.dart';
import 'package:i_love_liquor/main_tabs/home_tab.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';
import 'package:http/http.dart' as http;

import 'my_cart_tab.dart';

bool _isLoading;

class Invoice extends StatefulWidget {

  @override

  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  bool _loading=true;
  ApplyOrder _userInvoice = ApplyOrder();
  int discPrice = 0;
  final String serverToken = 'AAAATeNuIl4:APA91bFgi2q17Hd4bmIe4hLI8bPe69NLfsmCDWZ_Ji6c4Vq1tYoiHKle3yh5AbS-i7cvGTdrVZXpjgS45hLN-5wotxcRcSSpyiY6nQhqXeXzJeBrmxPGsq0HJR2qAH2NdmCNrPVHjBWu';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<DocumentSnapshot> noti;

/*  Future<List<ApplyOrder>> fetchOrders() async{
    setState(() {
      _isLoading = true;
    });
    final response = await http.get("$primaryUrl$orderUrl/user",headers: {"x-auth-token": "$user_token"});
    var datas = List<ApplyOrder>();
    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);
      if(mounted){
        setState(() {
          for(var dataJson in datasJson){
            datas.add(ApplyOrder.fromJson(dataJson));
          }
          _isLoading = false;
        });
      }
      return datas;
    }
  }*/


  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );
    final response = await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'title': 'New Order Arrive',
            'body': 'Customer add new order to list.'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await firebaseMessaging.getToken(),
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }

  Future<void> submitOrder(String id , bool orderConfirmed) async{

    final response = await http.patch('$primaryUrl$confrimOrderUrl$id',
        headers: {"x-auth-token": "$user_token" , "Content-type": "application/json"},
        body:jsonEncode({
          "orderConfirmed": orderConfirmed.toString(),
        }));
    print(response.body);
    if(response.statusCode == 200){
      if(mounted){
        setState(() {
          goldCoupon = 0;
          silverCoupon = 0;
          bronzeCoupon = 0;
          couponUsed = false;
          id_list = [];
          name_list = [];
          quantity_list = [];
          price_list = [];
          subtotal_amount = 0;
          order_productName = "";
          order_price = 0;
          order_quantity = 0;
          total_price = 0;
          purchases = [];
          orderConfirm = false;
        });
      }
      OrderedBox(context);
      notificationShow();
      Navigator.pop(context);
    }else{
    }
  }

  Future<void> deleteOrder(String id) async{
    setState(() {
      _loading = true;
    });

    final response = await http.delete('$primaryUrl$orderUrl$id',
        headers: {"x-auth-token": "$user_token" , "Content-type": "application/json"});

    if(response.statusCode == 200){
      if(mounted){
        setState(() {
          goldCoupon = 0;
        silverCoupon = 0;
        bronzeCoupon = 0;
        couponUsed = false;
        id_list = [];
        name_list = [];
        quantity_list = [];
        price_list = [];
        subtotal_amount = 0;
        order_productName = "";
        order_price = 0;
        order_quantity = 0;
        total_price = 0;
        purchases = [];
        orderConfirm = false;
        });
      }
      Navigator.pop(context);
    }else{
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
/*    fetchOrders().then((value){
      if(mounted){
        setState(() {
          userOrders = [];
          userOrders.addAll(value);
        });
      }
    });*/
    setState(() {
      _isLoading = true;
    });
    _invoice();

  }

  notificationShow(){
    db.collection("notifications").add({
      "title": "New Order",
      "body": "New order arrived"
    });
  }

  void _invoice(){
    if(_isLoading){
      setState(() {
        _userInvoice = null;
        discPrice = unconfirmInvoice[0].discount.toInt();
      });
      _loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double fontAdjustSize = deviceWidth/40;
    double cartFontAdjusetSize = deviceWidth/35;
    double _fontSize = deviceWidth/30;
    double _titleFontSize = deviceWidth/20;
    double _titleImgHeight =deviceHeight/8;
    double _headerFontSize = deviceWidth/22;
    double _headerImgHeight = deviceHeight/20;
    double _emptyContainerHeight =deviceHeight/5;
    double _emptyContainerWidth =deviceWidth/1.2;
    double _listTableHeight =deviceHeight/3;
    double _receiptHeight =deviceHeight/7;
    double _btnHeight = deviceHeight/15;




    //name_list.length
    return Scaffold(
      backgroundColor: lightGreenColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(titleTexts ,
          style: TextStyle(color: whiteTextColor ,
              fontFamily: 'Roboto_Thin',fontSize:_titleFontSize),
        ),
        backgroundColor: darkGreenColor,
        elevation: elevationShadow,
        centerTitle: true,
      ),
      body: _loading
          ?Center(child: CircularProgressIndicator())
          :  ListView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //Title Image
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  //flex: 2,
                  child: Container(
                    width: double.infinity,
                    height: _titleImgHeight,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        new Container(
                            decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: new AssetImage('assets/titles/YourCart_Slice.png' ,),
                                  fit: BoxFit.fill,
                                ))),
                        Container(
                          child: Text(translator.translate('Your Cart'),style: TextStyle(fontSize: _headerFontSize ,
                              fontFamily: 'Roboto_Thin',color: whiteTextColor  ,fontWeight: FontWeight.bold) ),
                        )
                      ],

                    ),
                    /*child: Image.asset('assets/titles/YourCart_Slice.png' ,
                    fit: BoxFit.fitWidth,),*/
                  ),
                ),
                //List Header
                Container(
                  height: _headerImgHeight,
                  child: Container(
                    padding: EdgeInsets.only(right:10),
                    color: darkGreenColor,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: Text(translator.translate('Items'), style: TextStyle(fontSize: cartFontAdjusetSize ,
                              fontFamily: 'Roboto_Thin',color: whiteTextColor) ,
                              textAlign: TextAlign.left ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex:  2,
                          child: Text(translator.translate('Quantity'),style: TextStyle(fontSize: cartFontAdjusetSize,
                              fontFamily: 'Roboto_Thin',color: whiteTextColor) ,softWrap: false,
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: Text(translator.translate('Price'),style: TextStyle(fontSize: cartFontAdjusetSize,
                              fontFamily: 'Roboto_Thin',color: whiteTextColor) ,
                              textAlign: TextAlign.right),
                        ),

                      ],
                    ),
                  ),
                ),
                //Items List
                Container(
                  height: _listTableHeight,
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    color: Colors.white,
                    child: ListView.builder(
                        itemCount:  unconfirmInvoice[0].orderPurchases.length,
                        itemBuilder: (BuildContext context , int index){
                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 10),
                                //Prod Name
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Text(unconfirmInvoice[0].invoiceProductInfo[index].productName == null ? ""
                                        : unconfirmInvoice[0].invoiceProductInfo[index].productName,
                                      style: TextStyle(color: darkGreenColor , fontSize: cartFontAdjusetSize  ,
                                          fontFamily: 'Roboto_Thin',
                                          fontWeight: FontWeight.bold),
                                      softWrap: true,
                                      textAlign: TextAlign.left ,),
                                  ),
                                ),
                                SizedBox(width: 10),
                                //Quantity
                                Expanded(
                                  flex:  2,
                                  child: Text(unconfirmInvoice[0].invoiceProductInfo[index].quantity == null? ""
                                      : "${unconfirmInvoice[0].invoiceProductInfo[index].quantity}" ,
                                      style: TextStyle(color: darkGreenColor, fontSize: cartFontAdjusetSize ,
                                          fontFamily: 'Roboto_Thin',
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                ),
                                SizedBox(width: 10),
                                //Subtotal
                                Expanded(
                                  flex: 1,
                                  child: Text(unconfirmInvoice[0].invoiceProductInfo[index].subtotalPerProduct == null ? ""
                                      : "${unconfirmInvoice[0].invoiceProductInfo[index].subtotalPerProduct}" ,
                                      style: TextStyle(color: darkGreenColor , fontSize: cartFontAdjusetSize,
                                          fontFamily: 'Roboto_Thin',
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.right),
                                ),

                              ],
                            ),
                          );

                        }
                    ),
                  ),
                ),
                //Total Amount
                SizedBox(height: 10,),
                Container(
                  height: _receiptHeight,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 10 , 0),
                    color: Colors.white,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Subtotal
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: Text('Subtotal',
                                    style: TextStyle(fontSize: cartFontAdjusetSize ,
                                        color: lightGreenColor,
                                        fontFamily: 'Roboto_Thin', fontWeight:  FontWeight.bold) ,),
                                ),
                                Expanded(
                                  flex:  2,
                                  child: Text(''),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    flex: 1,
                                    child: Text(unconfirmInvoice[0].subtotal == null ? "0" : "${unconfirmInvoice[0].subtotal}",
                                      style: TextStyle(fontSize: cartFontAdjusetSize ,
                                          color: lightGreenColor,
                                          fontFamily: 'Roboto_Thin', fontWeight:  FontWeight.bold) ,
                                      textAlign: TextAlign.right,)
                                ),

                              ],
                            ),),
                          //Delivery Fee
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: Text('Delivery Fee',
                                    style: TextStyle(fontSize: cartFontAdjusetSize ,
                                        color: lightGreenColor,
                                        fontFamily: 'Roboto_Thin', fontWeight:  FontWeight.bold) ,),
                                ),
                                Expanded(
                                  flex:  2,
                                  child: Text(''),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    flex: 1,
                                    child: Text(unconfirmInvoice[0].deliveryFee == null ? "0" : "${unconfirmInvoice[0].deliveryFee}",
                                      style: TextStyle(fontSize: cartFontAdjusetSize ,
                                          color: lightGreenColor,
                                          fontFamily: 'Roboto_Thin', fontWeight:  FontWeight.bold) ,
                                      textAlign: TextAlign.right,)
                                ),

                              ],
                            ),),
                          //Tax
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: Text('Tax',
                                    style: TextStyle(fontSize: cartFontAdjusetSize ,
                                        color: lightGreenColor,
                                        fontFamily: 'Roboto_Thin', fontWeight:  FontWeight.bold) ,),
                                ),
                                Expanded(
                                  flex:  2,
                                  child: Text(''),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    flex: 1,
                                    child: Text(unconfirmInvoice[0].tax == null ? "0" : "${((unconfirmInvoice[0].subtotal)*(unconfirmInvoice[0].tax/100)).toInt()}",
                                      style: TextStyle(fontSize: cartFontAdjusetSize ,
                                          color: lightGreenColor,
                                          fontFamily: 'Roboto_Thin', fontWeight:  FontWeight.bold) ,
                                      textAlign: TextAlign.right,)
                                ),

                              ],
                            ),),
                          //Discount
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: Text('Discount',
                                    style: TextStyle(fontSize: cartFontAdjusetSize ,
                                        color: lightGreenColor,
                                        fontFamily: 'Roboto_Thin', fontWeight:  FontWeight.bold) ,),
                                ),
                                Expanded(
                                  flex:  2,
                                  child: Text(''),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    flex: 1,
                                    child: Text("$discPrice",
                                      style: TextStyle(fontSize: cartFontAdjusetSize ,
                                          color: lightGreenColor,
                                          fontFamily: 'Roboto_Thin', fontWeight:  FontWeight.bold)  ,
                                      textAlign: TextAlign.right,)
                                ),

                              ],
                            ),)
                        ],
                      ),
                    ),
                  ),
                ),
                //Final Total
                Container(
                  height: _headerImgHeight,
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: AssetImage('assets/icons/receipt base.png'),fit: BoxFit.fill
                      )
                  ),
                  child: Container(
                    padding: EdgeInsets.only(right:10),
                    child: Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: Text('Total Amount',
                                style: TextStyle(fontSize: cartFontAdjusetSize ,
                                    color: lightGreenColor,
                                    fontFamily: 'Roboto_Thin', fontWeight:  FontWeight.bold) ,),
                            ),
                            Expanded(
                              flex:  2,
                              child: Text(''),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(unconfirmInvoice[0].total == null ? "0" : "${(unconfirmInvoice[0].total).toInt()}",
                                    style: TextStyle(fontSize: cartFontAdjusetSize ,
                                        color: lightGreenColor,
                                        fontFamily: 'Roboto_Thin', fontWeight:  FontWeight.bold) ,
                                    textAlign: TextAlign.right,),
                                )
                            ),

                          ],
                        )
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                //Buttom
                Container(
                    height: _btnHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //Delete Order
                        Container(
                          child: FlatButton(
                            onPressed: () async{
                              await deleteOrder(unconfirmInvoice[0].id);
                            },
                            child: Text(translator.translate('Cancel Order') ,
                                style: TextStyle(fontSize:  fontAdjustSize ,
                                    color: whiteTextColor,
                                    fontFamily: 'Roboto_Thin')),
                            color: darkGreenColor,
                          ),
                        ),
                        SizedBox(width: 10,),
                        //Submit Order
                        Container(
                          child: FlatButton(
                            onPressed: () async{
                              setState(() {
                                orderConfirm = true;
                              });
                              await submitOrder(unconfirmInvoice[0].id, orderConfirm);
                            },
                            child: Text(translator.translate('Order Now') ,
                                style: TextStyle(fontSize:  fontAdjustSize ,
                                    color: whiteTextColor,
                                    fontFamily: 'Roboto_Thin')),
                            color: darkGreenColor,
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ]
      ),

    );
  }

  void OrderedBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;
    double _headerFontSize = deviceWidth/22;

    var alert = AlertDialog(
      title:Text(translator.translate("Successfully Ordered") ,style: TextStyle(fontSize: _headerFontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      content: Text(translator.translate("Thank you for shopping with us.") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }
}
