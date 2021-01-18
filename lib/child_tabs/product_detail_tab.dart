import 'package:flutter/material.dart';
import 'package:i_love_liquor/child_tabs/my_cart_tab.dart';
import 'package:i_love_liquor/child_tabs/products_list_tab.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/data_save/products_data.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'package:i_love_liquor/main_tabs/account_tab.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';
import 'package:i_love_liquor/main_tabs/home_tab.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


List<String> name_list= <String>[];
List<String> id_list= <String>[];
List<int> price_list = <int>[];
List<int> quantity_list= <int>[];
String finalDate;

int total_price  =0;

class ProductsDetail extends StatefulWidget {


  final prod_id;
  const ProductsDetail(this.prod_id);
  @override
  _ProductsDetailState createState() => _ProductsDetailState();
}

class _ProductsDetailState extends State<ProductsDetail> {

  int item_count = 1;
  int item_price;
  bool productLoading = true;
  List<ProductInfo> productDetail = List<ProductInfo>();

  Future<List<ProductInfo>> fetchProducts() async{

    var response = await http.get("$primaryUrl$productUrl/${widget.prod_id}");
    var datas = List<ProductInfo>();
    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);
      datas.add(ProductInfo.fromJson(datasJson));
      if(mounted){
        setState(() {
          productLoading = false;
        });
      }
      return datas;
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts().then((value){
      if(mounted){
        setState(() {
          productDetail.addAll(value);
        });
      }
    });

  }


  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize = deviceWidth/20;
    double nameFontSize  = deviceWidth/15;
    double priceFontSize  = deviceWidth/20;
    double infoFontSize  = deviceWidth/25;
    double btnFontSize = deviceWidth/32;
    double infoSize  = deviceWidth/30;
    double _iconSize  = deviceWidth/25;
    double _sizeBoxWidth = deviceWidth/10;
    double _imageSize = deviceHeight/3;
    double _paddingHeight = deviceHeight/100;

    return Scaffold(
      backgroundColor: Colors.white,
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
      body: productLoading
        ? Center(child: CircularProgressIndicator())
            :ListView(
        padding: EdgeInsets.all(5),
        primary: true,
        shrinkWrap: true,
          children: <Widget> [
            //Product Image
            Container(
              height: _imageSize,
              child: Container(
                  child: Image.network(productDetail[0].imageURL)
              ),
            ),
            SizedBox(height: _paddingHeight,),
            //Product Name
            Container(
              child: Container(
                  child: Center(
                      child: Text(productDetail[0].name , style: TextStyle(
                        fontSize: nameFontSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold
                      ),) ,
                  )),
            ),
            SizedBox(height: _paddingHeight,),
            //Product Price
            Container(
              child: Container(
                  child: Center(
                    child: Text(productDetail[0].price.toString()+" MMK" , style: TextStyle(
                        fontSize: priceFontSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold
                    ),) ,
                  )),
            ),
            SizedBox(height: _paddingHeight,),
            //Add to cart
            Container(
              child: Center(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Text('')),
                      //Remove Btn
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Transform.scale(
                            scale: 1.5,
                            child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    if(item_count<=1){
                                      item_count = 1;
                                    }
                                    else if(item_count >1){
                                      item_count -= 1;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove ,size: _iconSize)
                            ),
                          ),
                        ),
                      ),
                      //TextBox
                      Expanded(
                        flex:1,
                        child: Container(
                            color: lightGreenColor,
                            child: Center(
                              child: Text('$item_count' ,
                                  style: TextStyle(
                                      fontFamily: 'Roboto_Thin',
                                      color: whiteTextColor,
                                      fontWeight: FontWeight.bold,fontSize: infoFontSize)),
                            )
                        ),
                      ),
                      //Add Btn
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Transform.scale(scale: 1.5,
                            child: IconButton(
                              onPressed: (){
                                setState(() {
                                  item_count ++;
                                });
                              },
                              icon: Icon(Icons.add,size: _iconSize,),
                            ),),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Text('')),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: _paddingHeight,),
            //Add to cart Button
            Container(
              width: double.infinity,
                color: lightGreenColor,
              child: FlatButton(
                child: Text(translator.translate('Add to Cart') ,
                    style: TextStyle(
                    color: whiteTextColor ,
                    fontFamily: 'Roboto_Thin',fontSize: btnFontSize,
                  fontWeight: FontWeight.bold
                ),softWrap: false),
                onPressed: (){
                  if(user_token != null ){
                    if(item_count <= productDetail[0].stock ){
                      setState(() {
                        order_productID = productDetail[0].id.toString();
                        order_productName = productDetail[0].name.toString();
                        order_price = productDetail[0].price;
                        order_quantity = item_count;
                        total_price = (item_count*order_price);
                        if(id_list.length != 0){
                          for(int i=0;i<id_list.length ; i++){
                            if(id_list[i].toString() == order_productID){
                              quantity_list[i] += order_quantity;
                              id_list[i] = order_productID;
                              price_list[i] += total_price ;
                              OrderedBox(context);
                              break;
                            }
                            else if(id_list[i].toString() != order_productID){
                              if(i==id_list.length-1){
                                name_list.add(order_productName);
                                id_list.add(order_productID);
                                quantity_list.add(order_quantity);
                                price_list.add(total_price);
                                OrderedBox(context);
                                break;
                              }
                            }
                          }
                        }
                        else{
                          name_list.add(order_productName);
                          id_list.add(order_productID);
                          quantity_list.add(order_quantity);
                          price_list.add(total_price);
                          OrderedBox(context);
                        }
                      });
                    }
                    else{
                      OutofStockBox(context);
                    }
                  }
                  else{
                    AlartBox(context);
                  }
                },
              )
            ),
            SizedBox(height: _paddingHeight,),
            //Product Details
            Container(
              child: Center(
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Product Details' ,style: TextStyle(
                        fontSize: infoFontSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold
                    ), textAlign: TextAlign.center,)),
              ),
            ),
            SizedBox(height: _paddingHeight,),
            //Product Infos
            Container(
              child: Row(
                children: [
                  Text('Category' ,style: TextStyle(
                      fontSize: infoSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold
                  ),textAlign: TextAlign.left,),
                  SizedBox(width: _sizeBoxWidth,),
                  Text(':' , textAlign: TextAlign.center,),
                  SizedBox(width: _sizeBoxWidth,),
                  Text(productDetail[0].category , style: TextStyle(
                      fontSize: infoSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold
                  ), textAlign: TextAlign.left,),
                ],
              ),
            ),
            SizedBox(height: _paddingHeight,),
            Container(
              child: Row(
                children: [
                  Text('Region    ' ,style: TextStyle(
                      fontSize: infoSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold
                  ), textAlign: TextAlign.left,),
                  SizedBox(width: _sizeBoxWidth,),
                  Text(':' , textAlign: TextAlign.center,),
                  SizedBox(width: _sizeBoxWidth,),
                  Text(productDetail[0].region , style: TextStyle(
                      fontSize: infoSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold
                  ),textAlign: TextAlign.left,),
                ],
              ),
            ),
            SizedBox(height: _paddingHeight,),
            Container(
              child: Row(
                children: [
                  Text('ABV         ' , style: TextStyle(
                      fontSize: infoSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold
                  ),textAlign: TextAlign.left,),
                  SizedBox(width: _sizeBoxWidth,),
                  Text(':' , textAlign: TextAlign.center,),
                  SizedBox(width: _sizeBoxWidth,),
                  Text("${productDetail[0].alcoholVolume.toString()}\%" , style: TextStyle(
                      fontSize: infoSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold
                  ),textAlign: TextAlign.left,),
                ],
              ),
            ),
            SizedBox(height: _paddingHeight,),
            Container(
              child: Row(
                children: [
                  Text('Size         ' ,style: TextStyle(
                      fontSize: infoSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold
                  ), textAlign: TextAlign.left,),
                  SizedBox(width: _sizeBoxWidth,),
                  Text(':' , textAlign: TextAlign.center,),
                  SizedBox(width: _sizeBoxWidth,),
                  Text("${productDetail[0].size} ml" , style: TextStyle(
                      fontSize: infoSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold
                  ),textAlign: TextAlign.left,),
                ],
              ),
            ),
            SizedBox(height: _paddingHeight,),
            //Product Description
            Container(
              child: Center(
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Product Description' , style: TextStyle(
                        fontSize: infoFontSize , fontFamily: 'Roboto_Thin',fontWeight: FontWeight.bold
                    ),textAlign: TextAlign.left,)),
              ),
            ),
            SizedBox(height: _paddingHeight,),
            Container(
              child: Center(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("\t\t\t\t\t${productDetail[0].desctiption}" ,style: TextStyle(
                      fontSize: infoSize , fontFamily: 'Roboto_Thin',fontWeight: FontWeight.bold
                  ), textAlign: TextAlign.justify,),),
              ),
            ),
          ],
      ),
    );
  }


  void OrderedBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;

    var alert = AlertDialog(
      content: Text(translator.translate("Added to your cart") ,style: TextStyle(
          fontSize: _fontSize , fontFamily: 'Roboto_Thin'
      ),textAlign: TextAlign.center,),
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

  void OutofStockBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;

    var alert = AlertDialog(
      content: Text(translator.translate("Sorry stock only left")+"${productDetail[0].stock}" ,style: TextStyle(
          fontSize: _fontSize , fontFamily: 'Roboto_Thin'
      ),textAlign: TextAlign.center,),
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

  void AlartBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;
    Widget registerBtn  = Center(
      child: FlatButton(
        onPressed: (){
            Navigator.of(context,rootNavigator: true).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  AccountTab()),
            );
          },
        child: Text(translator.translate("Register") ,style: TextStyle(
            fontSize: _fontSize , fontFamily: 'Roboto_Thin'
        ),textAlign: TextAlign.center,),
      ),
    );

    var alert = AlertDialog(
      content: Text(translator.translate("Please Login first") ,style: TextStyle(
          fontSize: _fontSize , fontFamily: 'Roboto_Thin'
      ),textAlign: TextAlign.center,),
      actions: [
        registerBtn,
      ],
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

}

