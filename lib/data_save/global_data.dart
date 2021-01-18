import 'package:flutter/material.dart';
import 'package:i_love_liquor/main_tabs/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


double elevationShadow = 2;
//Screen background
Color fbBgColor = Color(0XFF0069cb);
Color ggBgColor = Colors.red[300];
Color lightGreenColor =Color(0xFF229b72);
Color darkGreenColor = Color(0XFF0b7551);
Color whiteTextColor = Color(0xFFd4e5df);

TextStyle profileTextstyle = TextStyle(color: whiteTextColor);
TextAlign profileTextAlign = TextAlign.left;

//Title Data

String titleTexts = "\" I Love Liquor Minagalar Par \"";
Text titleText = Text(titleTexts , style: TextStyle(color: whiteTextColor ,fontSize: 20));

AppBar titleAppBar = new AppBar(
  automaticallyImplyLeading: false,
  title: titleText,
  backgroundColor: darkGreenColor,
  elevation: elevationShadow,
  centerTitle: true,
);

double btnFontSize ;
double font_size , titlefont_size ,image_Size , container_Height ,container_Width;
Widget SizeController(BuildContext context){

  double deviceHeight = MediaQuery.of(context).size.height;
  double deviceWidth = MediaQuery.of(context).size.width;

  font_size = deviceWidth/40;
  titlefont_size = deviceWidth/20;
  image_Size =deviceHeight/12;
  container_Height = deviceHeight/20;
  container_Width= deviceHeight/7;

}

Future<String> setTokenData(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('UserToken', value);
}

Future<String> getTokenData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('UserToken');
  return token;
}







