import 'package:flutter/material.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';

import 'my_cart_tab.dart';

class OurStoreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    double _titleFontSize = deviceWidth/20;
    double _headerFontSize = deviceWidth/25;
    double _shopfontSize  =deviceWidth/28;
    double _fontSize  =deviceWidth/30;
    double _paddingHeight = deviceHeight/100;

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
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("${(releasedata[0].contactUsImg).toString()}"),
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
                      child: Text('Our Store',
                        style: new TextStyle(
                          color: whiteTextColor,
                            fontFamily: 'Roboto_Thin',
                            fontWeight: FontWeight.bold,
                            fontSize: _headerFontSize, ),
                          textAlign: TextAlign.justify
                      ),
                    ),
                    SizedBox(height: 1),
                    Expanded(
                      flex: 10,
                      child:
                      ListView.builder(
                          itemCount: branchesdata.length,
                          itemBuilder: (
                              BuildContext context , int index){
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${branchesdata[index].branchName}",
                                    style: new TextStyle(
                                      color: whiteTextColor,
                                      fontFamily: 'Roboto_Thin',
                                      fontSize: _shopfontSize,

                                    ),
                                    textAlign: TextAlign.justify,),
                                  SizedBox(height: _paddingHeight,),
                                  Text("${branchesdata[index].address}",
                                    style: new TextStyle(
                                      color: whiteTextColor,
                                      fontFamily: 'Roboto_Thin',
                                      fontSize: _fontSize,

                                    ),
                                    textAlign: TextAlign.justify,),
                                  SizedBox(height: _paddingHeight,),
                                  Text("${branchesdata[index].phone}\n",
                                    style: new TextStyle(
                                      color: whiteTextColor,
                                      fontFamily: 'Roboto_Thin',
                                      fontSize: _fontSize,
                                    ),
                                    textAlign: TextAlign.justify,),
                                  SizedBox(height: _paddingHeight,),
                                ],
                              ),
                            );
                          }),
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
