import 'package:flutter/material.dart';
import 'package:i_love_liquor/child_tabs/privacy_tab.dart';
import 'package:i_love_liquor/child_tabs/question_answer_tab.dart';
import 'package:i_love_liquor/child_tabs/tac_tab.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'languages_tab.dart';

class SettingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize = deviceWidth/20;
    double _fontSize = deviceWidth/35;
    double _headerContainerHeight = deviceHeight/15;
    double titlefont_size = deviceWidth/25;
    double _paddingHeignt =deviceHeight/100;
    double _paddingWidth =12;
    double _imageSize = deviceHeight/20;
    double _buttonWidth =deviceWidth/2;
    double _containerHeight =deviceHeight/12;
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
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(10,0, 10, 0),
        children: <Widget>[
          //Title
          Container(
            height: _headerContainerHeight,
            child: Center(
              child: Text(translator.translate('Setting'), style: new TextStyle(
                  color: whiteTextColor,
                  fontFamily: 'Roboto_Light',
                  fontSize: titlefont_size),
                  textAlign: TextAlign.start,
                  softWrap: false),
            ),
          ),
          SizedBox(height: _paddingHeignt,),
          //Languages
          Container(
            height: _containerHeight,
            width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageTab()));
                    },
                    child: Image(
                      height: _imageSize,
                      width: _imageSize,
                      image: AssetImage('assets/icons/Language.png'),
                    ),
                  ),
                  SizedBox(width: _paddingWidth,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageTab()));
                    },
                    child: Text(translator.translate('Languages') , style: new TextStyle(
                        color:whiteTextColor,
                        fontFamily: 'Roboto_Light',
                        fontSize: _fontSize),
                        textAlign: TextAlign.start,
                        softWrap: false),
                  ),
                  /*Container(
                    alignment: Alignment.centerLeft,
                    width: _buttonWidth,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageTab()));
                      },
                      child:  Text(translator.translate('Languages') , style: new TextStyle(
                          color:whiteTextColor,
                          fontFamily: 'Roboto_Light',
                          fontSize: _fontSize),
                          textAlign: TextAlign.start,
                          softWrap: false),
                    ),
                  )*/
                ],
              )
          ),
          SizedBox(height: _paddingHeignt,),
          //Terms And Conditions
          Container(
            height: _containerHeight,
            width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TermsTab()));
                    },
                    child: Image(
                      height: _imageSize,
                      width: _imageSize,
                      image: AssetImage('assets/icons/Terms and Conditions.png'),
                    ),
                  ),
                  SizedBox(width: _paddingWidth,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TermsTab()));
                    },
                    child: Text(translator.translate('Terms and Conditions') , style: new TextStyle(
                        color:whiteTextColor,
                        fontFamily: 'Roboto_Light',
                        fontSize: _fontSize),
                        textAlign: TextAlign.start,
                        softWrap: false),
                  ),
                  /*Container(
                    alignment: Alignment.centerLeft,
                    width: _buttonWidth,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TermsTab()));
                      },
                      child:  Text(translator.translate('Terms and Conditions') , style: new TextStyle(
                          color:whiteTextColor,
                          fontFamily: 'Roboto_Light',
                          fontSize: _fontSize),
                          textAlign: TextAlign.start,
                          softWrap: false),
                    ),
                  )*/
                ],
              )
          ),
          SizedBox(height: _paddingHeignt,),
          //Privacy
          Container(
            height: _containerHeight,
            width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyTab()));
                    },
                    child: Image(
                      height: _imageSize,
                      width: _imageSize,
                      image: AssetImage('assets/icons/Privacy Policy.png'),
                    ),
                  ),
                  SizedBox(width: _paddingWidth,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyTab()));
                    },
                    child: Text(translator.translate('Privacy Policy') , style: new TextStyle(
                        color: whiteTextColor,
                        fontFamily: 'Roboto_Light',
                        fontSize: _fontSize),
                        textAlign: TextAlign.start,
                        softWrap: false),
                  ),
                  /*Container(
                    alignment: Alignment.centerLeft,
                    width: _buttonWidth,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyTab()));
                      },
                      child: Text(translator.translate('Privacy Policy') , style: new TextStyle(
                          color: whiteTextColor,
                          fontFamily: 'Roboto_Light',
                          fontSize: _fontSize),
                          textAlign: TextAlign.start,
                          softWrap: false),
                    ),
                  )*/
                ],
              )
          ),
          SizedBox(height: _paddingHeignt,),
          //Q & A
          Container(
            height: _containerHeight,
            width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QandATab()));
                    },
                    child: Image(
                      height: _imageSize,
                      width: _imageSize,
                      image: AssetImage('assets/icons/QnA.png'),
                    ),
                  ),
                  SizedBox(width: _paddingWidth,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QandATab()));
                    },
                    child: Text(translator.translate('Question & Answer') , style: new TextStyle(
                        color: whiteTextColor,
                        fontFamily: 'Roboto_Light',
                        fontSize: _fontSize),
                        textAlign: TextAlign.start,
                        softWrap: false),
                  ),
                  /*Container(
                    alignment: Alignment.centerLeft,
                    width: _buttonWidth,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QandATab()));
                      },
                      child:  Text(translator.translate('Question & Answer') , style: new TextStyle(
                          color: whiteTextColor,
                          fontFamily: 'Roboto_Light',
                          fontSize: _fontSize),
                          textAlign: TextAlign.start,
                          softWrap: false),
                    ),
                  )*/
                ],
              )
          ),
        ],
      ),
    );
  }
}
