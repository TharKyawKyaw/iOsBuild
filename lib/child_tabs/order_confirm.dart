import 'package:flutter/material.dart';
import 'package:i_love_liquor/child_tabs/my_cart_tab.dart';
import 'package:i_love_liquor/child_tabs/product_detail_tab.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/data_save/order_data.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';
import 'package:i_love_liquor/main_tabs/home_tab.dart';
import 'package:i_love_liquor/main_tabs/shop_tab.dart';
import 'package:http/http.dart' as http;
import 'package:i_love_liquor/data_save/user_data.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'map.dart';
import 'map_tab.dart';

class OrderConfirm extends StatefulWidget {
  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Item selectedTownship;
  int deli_price;
  String deli_township;
  List<Item> _towns = <Item>[
    const Item('Ahlone' , 2000),
    const Item('Bahan' , 2000),
    const Item('BaYintNaung' , 3000),
    const Item('BoTaHtaung' , 2500),
    const Item('Dagon' , 2500),
    const Item('Dawbon' , 2500),
    const Item('East Dagon' , 3000),
    const Item('Hlaing' , 2000),
    const Item('Hledan' , 2000),
    const Item('Insein' , 3000),
    const Item('KaMarYut' , 2500),
    const Item('Kyaut Myaung' , 2000),
    const Item('KyautTaDar' , 2500),
    const Item('KyeeMyinDaing' , 2500),
    const Item('LanmaDaw' , 2000),
    const Item('Latha' , 2500),
    const Item('MawTin' , 2000),
    const Item('MaYanGone' , 2500),
    const Item('MingalarTaungNyunt' , 2000),
    const Item('MingalarZay' , 2500),
    const Item('MyayNeGone' , 2000),
    const Item('North Dagon' , 3000),
    const Item('North Okkalarpa' , 3000),
    const Item('PabeTan' , 2500),
    const Item('PazunDaung' , 2500),
    const Item('SanChaung' , 2000),
    const Item('South Dagon' , 3000),
    const Item('South Okkalarpa' , 2000),
    const Item('Tarmwe' , 2000),
    const Item('TharKeTa' , 2500),
    const Item('ThinGanGyun' , 2000),
    const Item('Thuwana' , 2000),
    const Item('Yankin' , 0),
    const Item('Yuzana Garden' , 3000),
  ];


  @override
  Widget build(BuildContext context) {


    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize = deviceWidth/20;
    double _fontSize = deviceWidth/30;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              //Phone
              Container(
                child: Center(
                  child: new SizedBox(
                    width: double.infinity,
                    child: phoneField(_fontSize),
                  ),
                ),
              ),
              SizedBox(height: 10),
              //Address
              Container(
                child: Center(
                  child: new SizedBox(
                    width: double.infinity,
                    child: addressField(_fontSize),
                  ),
                ),
              ),
              SizedBox(height: 10),
              townshipField(_fontSize),
              //Submit Btn
              Container(
                child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () async {
                        order_contactNumber = phoneController.text;
                        order_deliveryAddress = addressController.text;
                        if(order_contactNumber!="" && order_deliveryAddress!="" &&
                            order_contactNumber!=null && order_deliveryAddress!=null){
                          setState(() {
                            order_deliveryRegion = deli_township;
                            order_deli = deli_price;
                          });
                          Navigator.pop(context);
                        }
                        else{
                          AlartBox(context);
                        }
                      },
                      child: Text(translator.translate('Submit') , style: TextStyle(color: Colors.white , fontSize: _fontSize)),
                      color: darkGreenColor,
                    )
                ),
              ),
            ],
          ),

      ),
    );
  }

  void AlartBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;

    var alert = AlertDialog(
      content: Text(translator.translate("Please Enter address and contact number") ,style: TextStyle(fontSize: _fontSize),textAlign: TextAlign.center,),
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
          border: InputBorder.none,
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

  Widget addressField(double _fontSize) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
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
    return Container(
      child: DropdownButton<Item>(
        hint: Text('Select Township'),
        value: selectedTownship,
        onChanged: (Item Value){
          setState(() {
            selectedTownship = Value;
            deli_township = selectedTownship.name;
            deli_price = selectedTownship.deliPrice;
          });
        },
        items: _towns.map((Item township){
          return DropdownMenuItem (
              value: township,
              child: Container(
                  child: Row(
                    children: [
                      Text(township.name ,textAlign: TextAlign.center,),
                      SizedBox(width: 10,),
                      Text(township.deliPrice.toString() ,textAlign: TextAlign.center,),
                    ],
                  ))
          );
        }).toList(),

      ),
    );
  }



}
