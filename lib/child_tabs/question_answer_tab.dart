import 'package:flutter/material.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';

class QandATab extends StatefulWidget {

  @override
  _QandATabState createState() => _QandATabState();
}

class _QandATabState extends State<QandATab> {
  String paragraph1;

  String paragraph2;

  String paragraph3;

  String paragraph4;

  String paragraph5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize = deviceWidth/20;
    double _fontSize = deviceWidth/30;
    double _headerFontSize = deviceWidth/25;
    double _paddingHeight = deviceHeight/80;
    double _paragraphTitle = deviceWidth/25;
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
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Center(child: Text('F A Q', style: TextStyle(color: whiteTextColor ,
                    fontFamily: 'Roboto_Thin',fontSize: _headerFontSize)),),
              ),

              SizedBox(height: _paddingHeight,),
              SizedBox(height: _paddingHeight,),
              ListView.builder(
                  itemCount: questiondata.length,
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context , int index){
                    if(questiondata[index].paragraph1 !=null){
                      paragraph1 = "\t\t\t\t\t${questiondata[index].paragraph1}";
                      if(questiondata[index].paragraph2 !=null){
                        paragraph2 = "\n\t\t\t\t\t${questiondata[index].paragraph2}";
                        if(questiondata[index].paragraph3 !=null){
                          paragraph3 = "\n\t\t\t\t\t${questiondata[index].paragraph3}";
                          if(questiondata[index].paragraph4 !=null){
                            paragraph4 = "\n\t\t\t\t\t${questiondata[index].paragraph4}";
                            if(questiondata[index].paragraph5 !=null){
                              paragraph5 = "\n\t\t\t\t\t${questiondata[index].paragraph5}";
                            }
                            else{
                              paragraph5 ="";
                            }
                          }
                          else{
                            paragraph4 ="";
                          }
                        }
                        else{
                          paragraph3 ="";
                        }
                      }
                      else{
                        paragraph2 ="";
                      }
                    }
                    print(paragraph1);
                    print(paragraph2);
                    print(paragraph3);
                    print(paragraph4);
                    print(paragraph5);
                    return Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('${questiondata[index].question}', style: TextStyle(color: whiteTextColor ,
                              fontFamily: 'Roboto_Thin',fontSize:_paragraphTitle ),
                                softWrap: true,textAlign: TextAlign.start,
                        ),
                            ),
                            SizedBox(height: _paddingHeight,),
                            Container(
                              child: Text('$paragraph1'
                                  '$paragraph2'
                                  '$paragraph3'
                                  '$paragraph4'
                                  '$paragraph5',
                                style: TextStyle(color: whiteTextColor ,
                                 fontFamily: 'Roboto_Thin',fontSize:_fontSize ),softWrap: true,textAlign: TextAlign.justify),
                            ),
                          ],
                        )
                    );
                  }

                /* Container(
                child: Center(child: Text('Question And Answer', style: TextStyle(color: whiteTextColor ,
                    fontFamily: 'Roboto_Thin',fontSize: _headerFontSize)),),
              ),
              SizedBox(height: _paddingHeight,),*/
              ),
            ],
          )
        )
    );
  }
}
