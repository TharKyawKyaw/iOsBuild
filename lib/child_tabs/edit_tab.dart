import 'package:flutter/material.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/data_save/user_data.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'package:i_love_liquor/main_tabs/account_tab.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'dart:convert';
import 'dart:io';




class EditTab extends StatefulWidget {
  @override
  _EditTabState createState() => _EditTabState();
}

class _EditTabState extends State<EditTab> {

  TextEditingController userController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<List<UserData>> updateUser(String phone ,String email , String address) async{

    final response = await http.patch('$primaryUrl$editUrl',
        headers: {"x-auth-token": "$user_token" , "Content-type": "application/json"},
        body:jsonEncode({
          "phone": phone,
          "email": email,
          "address": address
        }));

    if(response.statusCode == 200){
      final String responseString = response.body;
      setState(() {
        userInfo[0].phoneNumber = phone;
        userInfo[0].email = email;
        userInfo[0].address = address;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AccountTab()));
      return null;
    }else{
      return null;
    }
  }

 @override
  Widget build(BuildContext context) {


    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;


    double _titleFontSize = deviceWidth/20;
    double _fontSize = deviceWidth/30;
    double _btnHeight = deviceHeight/15;


    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
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
        padding: EdgeInsets.fromLTRB(5,10, 5, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            //Email
            Container(
              child: Center(
                child: new SizedBox(
                  width: double.infinity,
                  child: emailField(_fontSize),
                ),
              ),
            ),
            SizedBox(height: 10),
            //Submit Btn
            Container(
              width: double.infinity,
                height: _btnHeight,
                child: FlatButton(
                  onPressed: (){
                    if(phoneController.text != "" && emailController.text != "" && addressController.text != "" &&
                        phoneController.text !=null && emailController.text != null && addressController.text != null  ){
                      setState(() async{
                        user_phone = phoneController.text;
                        user_email = emailController.text;
                        user_address = addressController.text;
                        infoLoading = true;
                        final List<UserData> updateInfo = await updateUser(user_phone ,user_email ,user_address);
                      });
                    }
                    else {
                      AlartBox(context);
                    }
                  },

                  child: Text(translator.translate('Submit') , style: TextStyle(color: Colors.white ,
                      fontFamily: 'Roboto_Thin',fontSize: _fontSize)),
                  color: darkGreenColor,
                )
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );

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

  Widget emailField(double _fontSize) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: translator.translate('Your Email'),
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
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
    );
  }



  void AlartBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;


    var alert = AlertDialog(
      content: Text("Please Enter all data" ,style: TextStyle(fontSize: _fontSize ,
        fontFamily: 'Roboto_Thin',)),
    );

    showDialog(context: context,
    builder: (BuildContext context){
      return alert;
    });
  }




}
