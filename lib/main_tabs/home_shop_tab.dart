import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:i_love_liquor/child_tabs/special_offers_tab.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/child_tabs/products_list_tab.dart';
import 'package:i_love_liquor/child_tabs/my_cart_tab.dart';
import 'package:i_love_liquor/data_save/products_data.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_tab.dart';
import 'first_tab.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeShopTab extends StatefulWidget {
  bool get wantKeepAlive => true;
  @override
  _HomeShopTabState createState() => _HomeShopTabState();
}

class _HomeShopTabState extends State<HomeShopTab>{

  bool _slidePlay = true;
  bool dataLoading = true;
  var _slider=[];

  var special_list_item=new List(3);
  var special_list_name=[
    'Gift Set',
    'New Items',
    'Special Offers',
  ];

  @override
  bool get wantKeepAlive => true;

  _dataClear()async{
    setState(()  {
      shop_list.clear();
      category_list.clear();
      is_shopList = true;
      prodimage_list.clear();
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    _dataClear();
    if(promotiondata[0].imageURL6 != null &&promotiondata[0].imageURL6 != "" ){
      _slider.add(promotiondata[0].imageURL6);
    }
    if(promotiondata[0].imageURL7 != null &&promotiondata[0].imageURL7 != "" ){
      _slider.add(promotiondata[0].imageURL7);
    }
    if(promotiondata[0].imageURL8 != null &&promotiondata[0].imageURL8 != "" ){
      _slider.add(promotiondata[0].imageURL8);
    }
    if(promotiondata[0].imageURL9 != null &&promotiondata[0].imageURL9 != "" ){
      _slider.add(promotiondata[0].imageURL9);
    }
    if(promotiondata[0].imageURL10 != null &&promotiondata[0].imageURL10 != "" ){
      _slider.add(promotiondata[0].imageURL10);
    }
    if(is_shopList){
      for(int i=0;i<productdata.length;i++){
        if(productdata[i].category.toLowerCase() != special_list_name[0].toLowerCase()
            && productdata[i].category.toLowerCase() != special_list_name[1].toLowerCase()
            && productdata[i].category.toLowerCase() != special_list_name[2].toLowerCase()){
          if(productdata[i].category.toLowerCase() != "Gift".toLowerCase()){
            if(i==0){
              shop_list.add(productdata[i].category);
              prodimage_list.add(productdata[i].categoryUrl);
            }
            if(i>0){
              if(shop_list.length == 0){
                if(productdata[i].category.toLowerCase() != productdata[i-1].category.toLowerCase()){
                  shop_list.add(productdata[i].category);
                  prodimage_list.add(productdata[i].categoryUrl);
                }
              }
              else{
                if(productdata[i].category.toLowerCase() != productdata[i-1].category.toLowerCase()){
                  for(int j=0;j<shop_list.length;j++){
                    if(productdata[i].category.toLowerCase() != shop_list[j].toLowerCase()){
                      shop_list.add(productdata[i].category);
                      prodimage_list.add(productdata[i].categoryUrl);
                      break;
                    }
                    else if(productdata[i].category.toLowerCase() == shop_list[j].toLowerCase()){
                      break;
                    }
                  }
                }
              }
            }
          }
        }
        else if(productdata[i].category.toLowerCase() == special_list_name[0].toLowerCase()){
          special_list_item[0] = productdata[i].categoryUrl.toString();
        }
        else if(productdata[i].category.toLowerCase() == special_list_name[1].toLowerCase()){
          special_list_item[1] = productdata[i].categoryUrl.toString();
        }
        else if(productdata[i].category.toLowerCase() == special_list_name[2].toLowerCase()){
          special_list_item[2] = productdata[i].categoryUrl.toString();
        }
        setState(() {
          is_shopList = false;
        });
      }
      category_list = shop_list.toSet().toList();



/*    fetchProducts().then((value){
      setState(() {
        productdata.addAll(value);
        print(productdata.length);
      });
    });*/
    }}

  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize = deviceWidth/20;
    double _fontSize =deviceWidth/30;
    double _containerHeight =deviceWidth/15;
    double top_layout = (deviceHeight/5.2);
    double full_width = deviceHeight/4.25;
    double _aspectRatio = (deviceWidth/3)/(deviceHeight/5.2);
    double _producctaspectRatio = (deviceWidth/2)/(deviceHeight/4);

    Widget image_carousel = new Container(

        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        height: full_width,
        child: new Carousel(
          boxFit: BoxFit.fill,
          images: [
            ExactAssetImage('assets/final_images/slider_1.jpg'),
            ExactAssetImage('assets/final_images/slider_2.jpg'),
            ExactAssetImage('assets/final_images/slider_3.jpg'),
          ],
          autoplay: true,
          animationCurve: Curves.fastLinearToSlowEaseIn,
          animationDuration: Duration(milliseconds: 1000),
          showIndicator: false,
        ));


    Widget image_slider= new Container(
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      height: full_width,
      width: double.infinity,
      child: new CarouselSlider(
          items: _slider.map((image) => Container(
            width: double.infinity,
            child: Center(
                child: Image.network(image, fit: BoxFit.fill ,
                  width: double.infinity,)
            ),
          )).toList(),
          options: CarouselOptions(
            autoPlayAnimationDuration:  Duration(milliseconds: 1000),
            autoPlayInterval:  Duration(seconds: 3),
            height: full_width,
            viewportFraction: 1,
            aspectRatio: 1,
            autoPlay: _slidePlay,
          )),

    );

    return Scaffold(
        backgroundColor: lightGreenColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(titleTexts ,
            style: TextStyle(color: whiteTextColor , fontSize: _titleFontSize,
              fontFamily: 'Roboto_Thin',),
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
        body: is_shopList
            ?Center(child: CircularProgressIndicator())
            :ListView(
          padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
          shrinkWrap: true,
          children: <Widget>[
            //Special Items List
            Container(
              height: top_layout,
              width: double.infinity,
              child: GridView.builder(
                  itemCount: special_list_item.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                      childAspectRatio: _aspectRatio),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) =>
                            ProductsListTab(special_list_name[index].toString())),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(5,0, 0, 0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            new Container(
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new NetworkImage(special_list_item[index]),
                                      fit: BoxFit.fill,
                                    ))),
                            Container(
                              width: double.infinity,
                              height: _containerHeight,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                              ),
                              //padding: EdgeInsets.only(bottom: 5),
                              child: Container(
                                child: Center(
                                  child: Text(special_list_name[index] ,style: TextStyle(
                                      fontFamily: 'Roboto_Thin' ,
                                      color: Colors.white ,
                                      fontWeight: FontWeight.bold ,
                                      fontSize: _fontSize
                                  ),textAlign: TextAlign.center,),
                                ),
                              ),
                            )
                          ],

                        ),
                      ),
                    );
                  }
              ),
            ),

            image_slider,
            //Normal Items List
            GridView.builder(
                itemCount: category_list.length,
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.vertical,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio: _producctaspectRatio),
                itemBuilder: (BuildContext context , int index){
                  return
                    InkWell(
                        onTap: (){
                          if(0<productdata.length){
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) =>
                                ProductsListTab(category_list[index].toString())),
                            );
                          }
                          else{
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              new Container(
                                  decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                        image: new NetworkImage(prodimage_list[index].toString()),
                                        fit: BoxFit.fill,
                                      ))),
                              Container(
                                width: double.infinity,
                                height: _containerHeight,
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                ),
                                //padding: EdgeInsets.only(bottom: 5),
                                child: Container(
                                  child: Center(
                                    child: Text(category_list[index] ,style: TextStyle(
                                        fontFamily: 'Roboto_Thin' ,
                                        color: Colors.white ,
                                        fontWeight: FontWeight.bold ,
                                        fontSize: _fontSize
                                    ),textAlign: TextAlign.center,),
                                  ),
                                ),
                              )
                            ],

                          ),
                        )
                    );
                }
            )
          ],
        )

    );
  }
}

/*
class Single_prod extends StatelessWidget {
  int product_place;

  Single_prod({this.product_place});
  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    double _fontSize =deviceWidth/30;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          child: Image.asset("assets/home/Home_1.png"),
        ),
        Text('Beer' ,style: TextStyle(
            fontFamily: 'Roboto_Thin' ,
            color: Colors.white ,
            fontWeight: FontWeight.bold ,
            fontSize: _fontSize
        ),)
      ],

    );
  }


}*/
