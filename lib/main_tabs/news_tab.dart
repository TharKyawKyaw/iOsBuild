import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i_love_liquor/child_tabs/news_list.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/data_save/news_data.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'package:i_love_liquor/main_tabs/promotion_tab.dart';
import 'package:i_love_liquor/child_tabs/my_cart_tab.dart';
import 'package:http/http.dart' as http;
import 'promotion_tab.dart';
import 'shop_tab.dart';
import 'home_tab.dart';

bool news_open = false;
List<NewsInfo> news_info = List<NewsInfo>();
class NewsTab extends StatefulWidget {
  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  bool get wantKeepAlive => true;


  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize =deviceWidth/20;
    double _containerHeight = deviceHeight/1.22;

    double _aspectRatio = (deviceWidth/1)/(deviceHeight/4);

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
      body: news_open
          ? Center(child: CircularProgressIndicator()):
      GridView.builder(
          itemCount: news_info.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:1,
              childAspectRatio: _aspectRatio),
          itemBuilder: (BuildContext context, int index) {
            return Single_news(
              news_title: news_info[index].title,
              news_picture: news_info[index].imageURL,
              paragraph1: news_info[index].paragraph1,
              paragraph2: news_info[index].paragraph2,
              paragraph3: news_info[index].paragraph3,
              paragraph4: news_info[index].paragraph4,
              paragraph5: news_info[index].paragraph5,
            );
          }),
/*      SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0,5,0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: _containerHeight,
              child: GridView.builder(
                  itemCount: news_info.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:1,
                      childAspectRatio: _aspectRatio),
                  itemBuilder: (BuildContext context, int index) {
                    return Single_news(
                      news_title: news_info[index].title,
                      news_picture: news_info[index].imageURL,
                      paragraph1: news_info[index].paragraph1,
                      paragraph2: news_info[index].paragraph2,
                      paragraph3: news_info[index].paragraph3,
                      paragraph4: news_info[index].paragraph4,
                      paragraph5: news_info[index].paragraph5,
                    );
                  }),
            )
          ],
        ),
      ),*/

    );
  }
}

class Single_news extends StatelessWidget {
  final String news_title;
  final String news_picture;
  final String paragraph1;
  final String paragraph2;
  final String paragraph3;
  final String paragraph4;
  final String paragraph5;

  Single_news({
    this.news_title,
    this.news_picture,
    this.paragraph1,
    this.paragraph2,
    this.paragraph3,
    this.paragraph4,
    this.paragraph5,
  });


  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontsize = deviceWidth/30;
    double _bgColorHeight = deviceWidth/12;
    double _imageHeight =deviceHeight/3.5;

    return Container(
      width: double.infinity,
      height: _imageHeight,
      child:
      InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  NewsShow(this.news_title ,this.news_picture , this.paragraph1, this.paragraph2 ,
                      this.paragraph3, this.paragraph4, this.paragraph5)),
            );
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                new Container(
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(news_picture),
                          fit: BoxFit.fill,
                        ))),
                Container(
                  width: double.infinity,
                  height: _bgColorHeight,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                  ),
                  //padding: EdgeInsets.only(bottom: 5),
                  child: Container(
                    child: Center(
                      child: Text(this.news_title ,style: TextStyle(
                          fontFamily: 'Roboto_Thin' ,
                          color: Colors.white ,
                          fontWeight: FontWeight.bold ,
                          fontSize: _fontsize
                      ),textAlign: TextAlign.center,),
                    ),
                  ),
                )
              ],

            ),
          )
      ),
    );
  }


}