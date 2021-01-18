import 'package:flutter/material.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/child_tabs/my_cart_tab.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'package:i_love_liquor/main_tabs/home_tab.dart';
import 'package:localize_and_translate/localize_and_translate.dart';



class LanguageTab extends StatefulWidget {
  @override
  _LanguageTabState createState() => _LanguageTabState();
}

class _LanguageTabState extends State<LanguageTab> {

  int selectedLanguage;
  int selectedEng = 2;
  int selectedMm = 1;
  int selectedMmZg = 3;
  var language = translator.currentLanguage;
   Function onChanged;

   setSelectedLanguage(int val){
     setState(() {
       selectedLanguage = val;
     });
   }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if(language == 'en'){
        selectedLanguage = selectedEng;
        print(selectedLanguage);
      }
      else if(language =='my_zg'){
        selectedLanguage = selectedMmZg;
        print(selectedLanguage);
      }
      else{
        selectedLanguage = selectedMm;
        print(selectedLanguage);
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _imageSize =deviceHeight/8;
    double _fontSize = deviceWidth/30;
    double _titleFontSize = deviceWidth/20;


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
      body: Padding(
        padding: EdgeInsets.all(8),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(language == 'en' || language == 'my_zg'){
                          translator.setNewLanguage(
                              context,
                              newLanguage: 'my',
                              remember: false,
                              restart: true);
                        }
                      },
                      child: Image(
                        height: _imageSize,
                        width: _imageSize,
                        image: AssetImage('assets/icons/Mm.png'),
                      ),
                    ),
                    Radio(
                        value: selectedMm,
                        groupValue: selectedLanguage,
                        activeColor: Colors.white,
                        onChanged: (val){
                          setSelectedLanguage(val);
                          if(language == 'en'|| language == 'my_zg'){
                            translator.setNewLanguage(
                                context,
                                newLanguage: 'my',
                                remember: false,
                                restart: true);
                          }
                        }),
                    Text('Myanmar Unicode',style: TextStyle(
                        fontFamily: 'Roboto_Thin' ,
                        color: whiteTextColor ,
                        fontWeight: FontWeight.bold ,
                        fontSize: _fontSize
                    ),textAlign: TextAlign.center,)
                  ],
                ),
              ),
              //ZawGyi
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(language == 'en' || language == 'my'){
                          translator.setNewLanguage(
                              context,
                              newLanguage: 'my_zg',
                              remember: false,
                              restart: true);
                        }
                      },
                      child: Image(
                        height: _imageSize,
                        width: _imageSize,
                        image: AssetImage('assets/icons/Mm.png'),
                      ),
                    ),
                    Radio(
                        value: selectedMmZg,
                        groupValue: selectedLanguage,
                        activeColor: Colors.white,
                        onChanged: (val){
                          setSelectedLanguage(val);
                          if(language == 'en'|| language == 'my'){
                            translator.setNewLanguage(
                                context,
                                newLanguage: 'my_zg',
                                remember: false,
                                restart: true);
                          }
                        }),
                    Text('Myanmar Zawgyi',style: TextStyle(
                        fontFamily: 'Roboto_Thin' ,
                        color: whiteTextColor ,
                        fontWeight: FontWeight.bold ,
                        fontSize: _fontSize
                    ),textAlign: TextAlign.center,)
                  ],
                ),
              ),
              //English
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          if(language == 'my_zg'|| language == 'my'){
                            translator.setNewLanguage(
                                context,
                                newLanguage: 'en',
                                remember: false,
                                restart: true);
                          }
                        },
                        child: Image(
                          height: _imageSize,
                          width: _imageSize,
                          image: AssetImage('assets/icons/Eng.png'),
                        ),
                      ),
                      Radio(
                          value: selectedEng,
                          groupValue: selectedLanguage,
                          activeColor: Colors.white,
                          onChanged: (val){
                            setSelectedLanguage(val);
                            if(language == 'my_zg'|| language == 'my'){
                              translator.setNewLanguage(
                                  context,
                                  newLanguage: 'en',
                                  remember: false,
                                  restart: true);
                            }
                          }),

                      Text('English',style: TextStyle(
                          fontFamily: 'Roboto_Thin' ,
                          color: whiteTextColor ,
                          fontWeight: FontWeight.bold ,
                          fontSize: _fontSize
                      ),textAlign: TextAlign.center,)

                    ]
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
