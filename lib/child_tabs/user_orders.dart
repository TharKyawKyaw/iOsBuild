import 'package:flutter/material.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/data_save/order_place.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';


bool _isLoading;

class UserInvoice extends StatefulWidget {

  final invoice_code;

  const UserInvoice(this.invoice_code);
  @override

  _UserInvoiceState createState() => _UserInvoiceState();
}

class _UserInvoiceState extends State<UserInvoice> {
  ApplyOrder _userInvoice = ApplyOrder();
  int discPrice = 0;
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _isLoading = true;
    });
    _invoice();
  }

  void _invoice(){

    if(_isLoading){
      setState(() {
        _userInvoice = null;
      });
      for(int i=0 ; i<userOrders.length ; i++){
        if(widget.invoice_code == userOrders[i].orderID){
          _userInvoice = userOrders[i];
          discPrice = _userInvoice.discount.toInt();
          _isLoading = false;
        }
      }
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
      body: _isLoading
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
                        itemCount:  _userInvoice.orderPurchases.length,
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
                                    child: Text(_userInvoice.invoiceProductInfo[index].productName == null ? ""
                                        : _userInvoice.invoiceProductInfo[index].productName,
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
                                  child: Text(_userInvoice.invoiceProductInfo[index].quantity == null? ""
                                      : "${_userInvoice.invoiceProductInfo[index].quantity}" ,
                                      style: TextStyle(color: darkGreenColor, fontSize: cartFontAdjusetSize ,
                                      fontFamily: 'Roboto_Thin',
                                      fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                ),
                                SizedBox(width: 10),
                                //Subtotal
                                Expanded(
                                  flex: 1,
                                  child: Text(_userInvoice.invoiceProductInfo[index].subtotalPerProduct == null ? ""
                                      : "${_userInvoice.invoiceProductInfo[index].subtotalPerProduct}" ,
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
                                    child: Text(_userInvoice.subtotal == null ? "0" : "${_userInvoice.subtotal}",
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
                                    child: Text(_userInvoice.deliveryFee == null ? "0" : "${_userInvoice.deliveryFee}",
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
                                    child: Text(_userInvoice.tax == null ? "0" : "${((_userInvoice.subtotal)*(_userInvoice.tax/100)).toInt()}",
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
                                  child: Text(_userInvoice.total == null ? "0" : "${(_userInvoice.total).toInt()}",
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
              ],
            ),
          ]
      ),

    );
  }
}
