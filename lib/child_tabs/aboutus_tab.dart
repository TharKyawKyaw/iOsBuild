import 'package:flutter/material.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';

import 'my_cart_tab.dart';

class AboutUsTab extends StatefulWidget {
  @override
  _AboutUsTabState createState() => _AboutUsTabState();
}

class _AboutUsTabState extends State<AboutUsTab> {

  void initState() {
    // TODO: implement initState
    super.initState();
    if(releasedata[0].paragraph1 == null){
      print(releasedata[0].paragraph1);
      releasedata[0].paragraph1 = "";
    }
    if(releasedata[0].paragraph2 == null){
      print(releasedata[0].paragraph2);
      releasedata[0].paragraph2 = "";
    }
    if(releasedata[0].paragraph3 == null){
      print(releasedata[0].paragraph3);
      releasedata[0].paragraph3 = "";
    }
    if(releasedata[0].paragraph4 == null){
      print(releasedata[0].paragraph4);
      releasedata[0].paragraph4 = "";
    }
    if(releasedata[0].paragraph5 == null){
      print(releasedata[0].paragraph5);
      releasedata[0].paragraph5 = "";
    }


  }
  @override
  Widget build(BuildContext context) {


    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize = deviceWidth/20;
    double _headerFontSize = deviceWidth/25;
    double _fontSize  =deviceWidth/30;



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
        actions: <Widget>[
          IconButton(
            icon: Icon(Bottom_Icons.base_icons_shop),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    MyCart()),
              );
            },
          ),
        ],
      ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),

            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("${(releasedata[0].aboutUsImg).toString()}"),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text('About Us',
                          style: new TextStyle(
                            color: whiteTextColor,
                              fontFamily: 'Roboto_Thin',
                              fontWeight: FontWeight.bold,
                              fontSize: _headerFontSize ),
                        ),
                      ),
                      SizedBox(height: 1),
                      Expanded(
                        flex: 10,
                          child: SingleChildScrollView(
                            child: Container(
                                child: Text('\t\t\t${releasedata[0].paragraph1}\n\n'
                                    '\t\t\t${releasedata[0].paragraph2} \n\n'
                                    '\t\t\t${releasedata[0].paragraph3.toString()== null ? "" : releasedata[0].paragraph3} \n\n'
                                    '\t\t\t${releasedata[0].paragraph4.toString()== null ? "" : releasedata[0].paragraph4}\n\n'
                                    '\t\t\t${releasedata[0].paragraph5.toString()== null ? "" : releasedata[0].paragraph5}\n\n',
                                  style: new TextStyle(
                                    color: whiteTextColor,
                                    fontFamily: 'Roboto_Thin',
                                    fontSize: _fontSize,
                                  ),
                                  textAlign: TextAlign.justify,)
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ],
            )
        ),
    );
  }
}
