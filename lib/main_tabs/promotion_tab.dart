import 'package:flutter/material.dart';
import 'package:i_love_liquor/child_tabs/products_list_tab.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/child_tabs/special_offers_tab.dart';
import 'package:i_love_liquor/child_tabs/my_cart_tab.dart';
import 'package:i_love_liquor/child_tabs/promotions_items.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';

class PromotionTab extends StatelessWidget {

  bool get wantKeepAlive => true;



  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize = deviceWidth/20;
    double _fontSize = deviceWidth/35;
    double _imageSize =deviceHeight/16;
    double _containerHeight = deviceHeight/20;
    double _containerWidth= deviceHeight/5;


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
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child:  Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //Royalty Card
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => RoyaltyCard()),
                          );
                        },
                        child: Image(
                          height: _imageSize,
                          width: _imageSize,
                          image: AssetImage('assets/promotions/Royalty Card.png'),
                        ),
                      ),
                      Container(
                        height: _containerHeight,
                        width: _containerWidth,
                        child: FlatButton(
                          onPressed: (){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) =>RoyaltyCard()),
                            );
                          },
                          child: Text(translator.translate('Royalty Card') , style: new TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto_Light',
                              fontSize: _fontSize),softWrap: false),
                        ),
                      )
                    ],
                  )
              ),
              //Coupon
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => Coupons()),
                          );
                        },
                        child: Image(
                          height: _imageSize,
                          width: _imageSize,
                          image: AssetImage('assets/promotions/Coupons.png'),
                        ),
                      ),
                      Container(
                        height: _containerHeight,
                        width: _containerWidth,
                        child: FlatButton(
                          onPressed: (){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) =>Coupons()),
                            );
                          },
                          child: Text(translator.translate('Coupons') , style: new TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto_Light',
                              fontSize: _fontSize),softWrap: false),
                        ),
                      )
                    ],
                  )
              ),
              //Special Offers
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) =>
                              ProductsListTab("Special Offers")),
                          );
                        },
                        child: Image(
                          height: _imageSize,
                          width: _imageSize,
                          image: AssetImage('assets/promotions/Special Offers.png'),
                        ),
                      ),
                      Container(
                        height: _containerHeight,
                        width: _containerWidth,
                        child: FlatButton(
                          onPressed: (){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) =>
                                ProductsListTab("Special Offers")),
                            );
                          },
                          child: Text(translator.translate('Special Offers') , style: new TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto_Light',
                              fontSize: _fontSize),softWrap: false),
                        ),
                      )
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}