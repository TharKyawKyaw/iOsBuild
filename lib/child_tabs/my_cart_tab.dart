import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:i_love_liquor/child_tabs/order_confirm.dart';
import 'package:i_love_liquor/child_tabs/product_detail_tab.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/data_save/order_data.dart';
import 'package:http/http.dart' as http;
import 'package:i_love_liquor/data_save/order_place.dart';
import 'package:i_love_liquor/data_save/region_data.dart';
import 'dart:convert';
import 'package:i_love_liquor/data_save/user_data.dart';
import 'package:i_love_liquor/main_tabs/shop_tab.dart';
import 'package:i_love_liquor/main_tabs/account_tab.dart';
import 'package:i_love_liquor/main_tabs/home_tab.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'invoice_tab.dart';

bool orderSell;
int a=0;

List<Purchases> purchases = List<Purchases>();

List<Map<String , dynamic>> order_list = List<Map<String , dynamic>>();



class Item{
  const Item(this.name , this.deliPrice);
  final String name;
  final int deliPrice;
}
class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {

  TextEditingController address1Controller = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  RegionsData selectedTownship;
  int deli_price;
  String deli_township;
  ApplyOrder confirmInvoice = ApplyOrder();
  String _phone ;
  String _address;

  List<RegionsData> regionData = List<RegionsData>();



  bool orderConfirm = false;
  bool  _loading= true;
  final String serverToken = 'AAAATeNuIl4:APA91bFgi2q17Hd4bmIe4hLI8bPe69NLfsmCDWZ_Ji6c4Vq1tYoiHKle3yh5AbS-i7cvGTdrVZXpjgS45hLN-5wotxcRcSSpyiY6nQhqXeXzJeBrmxPGsq0HJR2qAH2NdmCNrPVHjBWu';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<DocumentSnapshot> noti;

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

  Future<List<ApplyOrder>> placeOrderVersion(ApplyOrder param) async{
    setState(() {
      orderConfirm = true;
    });
    var bodyValue= param.toJson();
    var bodyData = json.encode(bodyValue);

    final response = await http.post("$primaryUrl$orderUrl",
        headers: {"x-auth-token": "$user_token" , "Content-type": "application/json"},
        body:bodyData
    );
    print(response.body);
    var datas = List<ApplyOrder>();
    if(response.statusCode == 200){
      var datasJson = json.decode(response.body);

      if(mounted){
        setState(() {
          unconfirmInvoice = [];
          unconfirmInvoice.clear();
          datas.clear();
          orderSell = true;
          datas.add(ApplyOrder.fromJson(datasJson));
          unconfirmInvoice.addAll(datas);
       if(orderConfirm){
/*            id_list = [];
            name_list = [];
            quantity_list = [];
            price_list = [];
            subtotal_amount = 0;
            order_deli = 0;
            order_productName = "";
            order_price = 0;
            order_quantity = 0;
            total_price = 0;
            purchases = [];
            order_deliveryAddress ="";
            order_contactNumber = "";
            order_deliveryRegion = "";*/
            orderConfirm = false;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>
                  Invoice()),
            );
          }
        });
      }

      return datas;

    }else{
      return null;
    }
  }

  Future<List<RegionsData>> getRegions() async{

    setState(() {
      _loading = true;
    });
    var response = await http.get("$primaryUrl$regionUrl" ,
        headers: {"x-auth-token": "$user_token",});


    var datas = List<RegionsData>();
    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);
      for(var dataJson in datasJson){
        datas.add(RegionsData.fromJson(dataJson));
      }
      if(mounted){
        setState(() {
          _loading = false;
        });
      }
      return datas;
    }
  }
  @override
  initState(){

    //_calculate();
    getRegions().then((value){
      if(mounted){
        setState(() {
          regionData = [];
          regionData.addAll(value);

        });
      }
      _checkOrder();
    });

  }

  Widget build(BuildContext context) {


    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double fontAdjustSize = deviceWidth/40;
    double cartFontAdjusetSize = deviceWidth/35;
    double _fontSize = deviceWidth/30;
    double _iconSize = deviceWidth/12;
    double _titleFontSize = deviceWidth/20;
    double _titleImgHeight =deviceHeight/8;
    double _headerFontSize = deviceWidth/22;
    double _headerImgHeight = deviceHeight/20;
    double _listTableHeight =deviceHeight/3;
    double _receiptHeight =deviceHeight/7;
    double _btnHeight = deviceHeight/15;
    double _imageSize =deviceHeight/8;

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
          : orderConfirm
          ?Center(child: CircularProgressIndicator())
          : ListView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //Title Image
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
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
                      Expanded(
                        flex:  1,
                        child: Text(translator.translate('') ,
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
                      itemCount: name_list.length,
                      itemBuilder: (BuildContext context , int index){
                        return Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 10),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text(name_list[index] == null ? "" : name_list[index],  style: TextStyle(color: darkGreenColor , fontSize: cartFontAdjusetSize  ,
                                      fontFamily: 'Roboto_Thin',
                                      fontWeight: FontWeight.bold),
                                    softWrap: true,
                                    textAlign: TextAlign.left ,),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex:  2,
                                child: Text(quantity_list[index] == null? "" : "${quantity_list[index]}" , style: TextStyle(color: darkGreenColor, fontSize: cartFontAdjusetSize ,
                                    fontFamily: 'Roboto_Thin',
                                    fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ),
                              Expanded(
                                flex:  1,
                                child: GestureDetector(
                                  onTap: (){
                                    RemoveItem(index);
                                  },
                                  child: Text('Remove' , style: TextStyle(color: darkGreenColor, fontSize: cartFontAdjusetSize ,
                                      fontFamily: 'Roboto_Thin',
                                      fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: Text(price_list[index] == null ? "" : "${price_list[index]}" ,
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
              SizedBox(height: 5,),
              SizedBox(height: 5,),
              Container(
                  child: phoneField(_fontSize)),
              SizedBox(height: 5,),
              Container(
                  child: addressField1(_fontSize)),
              SizedBox(height: 5,),
              townshipField(_fontSize),
              SizedBox(height: 5,),
              //Payment Method
              Container(
                child:Theme(
                  data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white,
                      disabledColor: Colors.blue
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //Unicode
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Radio(
                                value: selectedBank,
                                groupValue: selectedPayment,
                                activeColor: Colors.white,
                                onChanged: (val){
                                  BankPaymentAlertBox(context);
                                  isBank  = true;
                                  isCOD = false;
                                }),
                            Container(
                              child: Row(
                                children: [
                                  Text('Card Payment',style: TextStyle(
                                      fontFamily: 'Roboto_Thin' ,
                                      color: whiteTextColor ,
                                      fontWeight: FontWeight.bold ,
                                      fontSize: _fontSize
                                  ),textAlign: TextAlign.center,),
                                  SizedBox(width: 5),
                                  Icon(Icons.payment_outlined,color: Colors.white,size: _iconSize),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Radio(
                                value: selectedCOD,
                                groupValue: selectedPayment,
                                activeColor: Colors.white,
                                onChanged: (val){
                                  setSelectedPayment(val);
                                  isBank  = false;
                                  isCOD = true;
                                }),
                            Container(
                              child: Row(
                                children: [
                                  Text('Cash On Delivery',style: TextStyle(
                                      fontFamily: 'Roboto_Thin' ,
                                      color: whiteTextColor ,
                                      fontWeight: FontWeight.bold ,
                                      fontSize: _fontSize
                                  ),textAlign: TextAlign.center,),
                                  SizedBox(width: 5),
                                  ImageIcon(

                                    AssetImage('assets/icons/dollar.png'),color: Colors.white,size: _iconSize,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
              ),),
              SizedBox(height: 5,),
              Container(
                  height: _btnHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Order
                      Container(
                        child: FlatButton(
                          onPressed: () async{
/*                            order_deliveryAddress = address1Controller.text;
                            order_contactNumber = phoneController.text;*/

                            PlaceOrder();
                          },
                          child: Text(translator.translate('Check Out') ,
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

  setSelectedPayment(int val){
    setState(() {
      selectedPayment= val;
    });
  }

  void DataAlertBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    double _fontSize = deviceWidth/25;
    double _inputSize  =deviceWidth/30;



    var alert = AlertDialog(
      content: Text(translator.translate("Please Enter address and contact number") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
    );
    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

  void PaymentAlertBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    double _fontSize = deviceWidth/25;
    double _inputSize  =deviceWidth/30;



    var alert = AlertDialog(
      content: Text(translator.translate("Please Choose Payment System") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
    );
    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

  void BankPaymentAlertBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    double _fontSize = deviceWidth/25;
    double _inputSize  =deviceWidth/30;

    var alert = AlertDialog(
      content: Text(translator.translate("Card payment not available yet") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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
          hintText: order_contactNumber == null ?translator.translate('Your Phone') : order_contactNumber,
          hintStyle: new TextStyle(
            fontFamily: 'Roboto_Thin',
            fontSize: _fontSize,
          )
      ),
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Roboto_Thin',
          fontSize: _fontSize,
        color: darkGreenColor,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: TextInputType.phone,
      controller: phoneController,
      onChanged: (String value){
        if(phoneController.text != null && phoneController.text != ""){
          order_contactNumber = phoneController.text;
        }
      },
    );
  }

  Widget addressField1(double _fontSize) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: order_deliveryAddress == null ? translator.translate('Your Address') : order_deliveryAddress,
          hintStyle: new TextStyle(
              fontFamily: 'Roboto_Thin',
              fontSize: _fontSize,
          )
      ),
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Roboto_Thin',
          fontSize: _fontSize,
        color: darkGreenColor,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: TextInputType.streetAddress,
      controller: address1Controller,
      onChanged: (String value){
      if(address1Controller.text != null && address1Controller.text != ""){
        order_deliveryAddress = address1Controller.text;
      }
    },
    );
  }

  Widget townshipField(double _fontSize){
    return Container(
      child: DropdownButton<RegionsData>(
        iconEnabledColor: Colors.white,
        dropdownColor: lightGreenColor,
        hint: Text(order_deliveryRegion == null ? 'Select Township': "$order_deliveryRegion\t$order_deli" , style: TextStyle(
            fontFamily: 'Roboto_Thin',
            fontSize: _fontSize ,
          color: Colors.white,
        ),),
        value: selectedTownship,
        onChanged: (RegionsData Value){
          setState(() {
            selectedTownship = Value;
            deli_township = selectedTownship.name;
            deli_price = selectedTownship.fee;
            order_deliveryRegion = deli_township;
            order_deli = deli_price;
            //_totalCalculate(order_deli);
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
                          fontSize: _fontSize ,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
                      SizedBox(width: 5),
                      Text(township.fee.toString() ,textAlign: TextAlign.center,style: TextStyle(
                          fontFamily: 'Roboto_Thin',
                          fontSize: _fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
                    ],
                  ))
          );
        }).toList(),

      ),
    );
  }

  void PlaceOrder() async{


    if(order_contactNumber!="" && order_deliveryAddress!="" &&
        order_contactNumber!=null && order_deliveryAddress!=null &&
        order_deliveryRegion != "" && order_deliveryRegion != null){

      if(isBank || isCOD){
        final String userID =main_id;

        if(userID != null || userID !=""){
          ApplyOrder applyOrder = ApplyOrder();
          applyOrder.orderPurchases = null;
          applyOrder.contactNumber = order_contactNumber;
          applyOrder.deliveryAddress = order_deliveryAddress;
          applyOrder.deliveryRegion = order_deliveryRegion;
          applyOrder.orderConfirmed = false;
          OrderCoupon orderCoupon = OrderCoupon();
          orderCoupon.gold = goldCoupon;
          orderCoupon.silver = silverCoupon;
          orderCoupon.bronze  = bronzeCoupon;
          purchases.clear();
          for(int j = 0 ; j<id_list.length ; j++){
            Purchases orderPurchases = Purchases();
            orderPurchases.productID = id_list[j];
            orderPurchases.quantity = quantity_list[j];
            purchases.add(orderPurchases);
          }
          applyOrder.orderPurchases =purchases ;
          applyOrder.orderCoupon =orderCoupon ;
    print("applyOrder\n${applyOrder.orderPurchases.length}");
          final List<ApplyOrder> order = await placeOrderVersion(applyOrder);
        }
      }
      else{
        PaymentAlertBox(context);
      }

    }
    else{
      DataAlertBox(context);
    }

  }

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

  void RemoveItem(int index){

    setState(() {
      id_list.removeAt(index);
      quantity_list.removeAt(index);
      price_list.removeAt(index);
      name_list.removeAt(index);
    });
    _checkOrder();
  }

  _checkOrder()  async{
    if (id_list.length==0) {
      id_list = [];
      name_list = [];
      quantity_list = [];
      price_list = [];
      subtotal_amount = 0;
      order_deli = 0;
      order_productName = "";
      order_price = 0;
      order_quantity = 0;
      total_price = 0;
      Future.delayed(Duration.zero, () => _showAlert(context));
    }
  }

  Widget _showAlert (BuildContext context){

    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;

    Widget okButton  = FlatButton(
        onPressed: (){
          Navigator.of(context,rootNavigator: true).pop();
          Navigator.pop(context);
        },
        child: Text(translator.translate("OK") ,style: TextStyle(fontSize: _fontSize,
            fontFamily: 'Roboto_Thin',
            fontWeight: FontWeight.bold),textAlign: TextAlign.center,));

    var alert = AlertDialog(
      content: Text(translator.translate("Your cart is empty") ,style: TextStyle(fontSize: _fontSize,
          fontFamily: 'Roboto_Thin',
          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      actions: [
        okButton
      ],
    );

    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return alert;
        });
  }

  _totalCalculate(int deli_price){
    setState(() {
      initial_amount = total_amount + deli_price;
    });

  }
}

/*_calculate(){
  int item_amount;
  int item;
  List<int> final_amount = <int>[];
  for(int i=0 ; i<price_list.length;i++){
    item_amount = price_list[i] as int;
    item = item_amount;
    final_amount.add(item) ;
  }
  item = 0;
  for(int j=0;j<final_amount.length;j++){
    item_amount = final_amount[j];
    item += item_amount;
    subtotal_amount = item;
  }
  tax = (subtotal_amount*0.05).toInt();
  discount =( subtotal_amount*(discount/100)).toInt();
  total_amount = subtotal_amount + tax + discount;
  initial_amount = total_amount;
  if(price_list.length == 0){
    subtotal_amount = 0;
  }
  item = 0;
}*/






