import 'package:flutter/material.dart';
import 'package:i_love_liquor/child_tabs/user_orders.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/data_save/order_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:i_love_liquor/data_save/order_place.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

bool _isLoading = true;
bool _noOrder = false;
class PurchasedHistory extends StatefulWidget {
  @override
  _PurchasedHistoryState createState() => _PurchasedHistoryState();
}

class _PurchasedHistoryState extends State<PurchasedHistory> {
  List<ApplyOrder> _orderList = List<ApplyOrder>();

  Future<List<ApplyOrder>> fetchOrders(String userID) async{
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
  }
  @override
  void initState() {
    // TODO: implement ini
    fetchOrders(userInfo[0].id).then((value){

      if(mounted){
        setState(() {
          userOrders = [];
          _orderList = [];
          _orderList.addAll(value);
          for(int i=0 ; i<_orderList.length ; i++){
            userOrders.add(_orderList[i]);
          }

          if(userOrders.length == 0){
            setState(() {
              _noOrder = true;
            });
          }
          else{
            _noOrder = false;
          }
        });
      }
    });

  }
  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize = deviceWidth/20;
    double _fontSize = deviceWidth/25;
    double _containerHeight =deviceHeight/15;

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
      ),
      body: _isLoading
        ?Center(child: CircularProgressIndicator())
          :_noOrder
          ?Center(child: Text(translator.translate('No Order Yet'),style: TextStyle(
        fontSize: _fontSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold ,
        color: Colors.white70,
      ),)):
      ListView.builder(
        padding: EdgeInsets.fromLTRB(10,0, 10, 0),
        itemCount: userOrders.length,
          itemBuilder: (BuildContext context, int i){

              return GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserInvoice(userOrders[i].orderID)));
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0,5, 0, 5),
                  child: Container(
                    height: _containerHeight,
                    color: Colors.black12,
                    child: Center(
                      child: Text("${userOrders[i].order_date}", style: new TextStyle(
                          color: whiteTextColor,
                          fontFamily: 'Roboto_Light',
                          fontSize: titlefont_size),
                          textAlign: TextAlign.start,
                          softWrap: false),
                    ),
                  ),
                ),
              );
          }
      )
    );
  }

}
