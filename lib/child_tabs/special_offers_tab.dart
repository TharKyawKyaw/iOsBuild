import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/child_tabs/my_cart_tab.dart';
import 'package:i_love_liquor/data_save/products_data.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';
import 'package:i_love_liquor/main_tabs/home_tab.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'product_detail_tab.dart';
import 'package:http/http.dart' as http;
import 'my_cart_tab.dart';

String search_text;
bool isSearch = false;
TextEditingController searchController = new TextEditingController();

class SpecialOffers extends StatefulWidget {


  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {

  var item_ml=[
    '75ml',
    '150ml',
    '75ml',
    '75ml',
    '150ml',
    '75ml',
    '150ml',
    '75ml',
    '75ml',
    '150ml',
    '75ml',
    '150ml',
    '75ml',
    '75ml',
    '150ml',
    '75ml',
    '150ml',
    '75ml',
    '75ml',
  ];
  var special_items=[
    {
      'name': 'Gift 1',
      'picture': 'assets/gifts/gift1.jpg',
      'price': 10000,
    },
    {
      'name': 'Gift 2',
      'picture': 'assets/gifts/gift2.jpg',
      'price': 10000,
    },
    {
      'name': 'Gift 3',
      'picture': 'assets/gifts/gift3.jpg',
      'price': 10000,
    },
    {
      'name': 'Gift 4',
      'picture': 'assets/gifts/gift4.jpg',
      'price': 10000,
    },
    {
      'name': 'Gift 5',
      'picture': 'assets/gifts/gift5.jpg',
      'price': 10000,
    },
    {
      'name': 'Gift 6',
      'picture': 'assets/gifts/gift6.jpg',
      'price': 10000,
    },
    {
      'name': 'Gift 7',
      'picture': 'assets/gifts/gift7.jpg',
      'price': 10000,
    },
    {
      'name': 'Gift 8',
      'picture': 'assets/gifts/gift8.jpg',
      'price': 10000,
    },
  ];

  var special_list_image=[
    'assets/gifts/gift1.jpg',
    'assets/gifts/gift2.jpg',
    'assets/gifts/gift3.jpg',
    'assets/gifts/gift4.jpg',
    'assets/gifts/gift5.jpg',
    'assets/gifts/gift6.jpg',
    'assets/gifts/gift7.jpg',
    'assets/gifts/gift8.jpg',
  ];
  var special_list_name=[
    'gift1',
    'gift2',
    'gift3',
    'gift4',
    'gift5',
    'gift6',
    'gift7',
    'gift8',
  ];
  var special_list_price=[
    10000,
    20000,
    30000,
    40000,
    80000,
    70000,
    60000,
    50000,
  ];

  List<ProductInfo> categoryInfo = List<ProductInfo>();
  List<ProductInfo> displayCategoryInfo = List<ProductInfo>();
  @override



  @override
  Widget build(BuildContext context) {



    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double _titleFontSize = deviceWidth/20;
    double _containerHeight = deviceHeight/1.35;
    double _searchBoxHeight =deviceHeight/15;
    double _aspectRatio = (deviceWidth/2)/ (deviceHeight/2.6);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: _searchBoxHeight,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                children: [
                  Expanded(
                      flex: 11,
                      child: Container(
                          color: Colors.white,
                          height: _searchBoxHeight,
                          child: searchField())),
                  Expanded(
                    flex: 1,
                    child: Container(
                        color: Colors.white,
                        height: _searchBoxHeight,
                        child: Icon(Icons.search)
                    ),)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              height: _containerHeight,
              child: GridView.builder(
                  itemCount: special_list_image.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                      childAspectRatio: _aspectRatio),
                  itemBuilder: (BuildContext context , int index) {
                    return Single_prod(
                      prod_name: special_list_name[index],
                      prod_picture: special_list_image[index],
                      prod_price: special_list_price[index],
                      //prod_ml: item_ml[index].toString(),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget searchField() {

    double deviceWidth = MediaQuery.of(context).size.width;
    double _searchFontSize = deviceWidth/25;

    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        hintStyle: TextStyle(
            fontFamily: 'Roboto_Thin',fontSize:_searchFontSize ),
        hintText: 'Search...',
      ),

      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Roboto_Thin',fontSize:_searchFontSize ),
      keyboardType: TextInputType.name,
      controller: searchController,
      onChanged: (search_text) {
        search_text = searchController.text.toLowerCase();
        if(search_text == null || search_text ==''){
          isSearch = false;
          setState(() {
            displayCategoryInfo = categoryInfo ;
          });

        }
        else{
          setState(() {
            isSearch = true;
            displayCategoryInfo = categoryInfo.where((note){
              var notetext = note.name.toLowerCase();
              return notetext.contains(search_text);
            }).toList();
            print(displayCategoryInfo.length);
          });
        }
        print(isSearch);
      },
    );
  }
}



class Single_prod extends StatelessWidget {
  final String prod_name;
  final String prod_picture;
  final String prod_ml;
  final int prod_price;

  Single_prod({
    this.prod_name,
    this.prod_picture,
    this.prod_ml,
    this.prod_price,
  });


  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double _fontsize = deviceWidth/30;
    double _gridHeight = deviceHeight/3.5;
    double _gridContainerHeight = deviceHeight/10;
    return Card(
        child: Material(
            color: Colors.white,
            child: InkWell(onTap: (){
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) =>
                  SpecialProduct(this.prod_name,this.prod_price , this.prod_picture )),
              );
            },
                child: GridTile(
                  header: Container(
                    height: _gridHeight,
                    child: Center(child: Image.asset(prod_picture)),
                  ),
                  child: Text(''),
                  footer: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.white12,
                    child: Container(
                        alignment: Alignment.bottomLeft,
                        height: _gridContainerHeight,
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(prod_price.toString() ,
                                      style: TextStyle( fontSize: _fontsize,
                                          fontFamily: 'Roboto_Thin',
                                          fontWeight: FontWeight.bold),
                                      softWrap: false,

                                      textAlign: TextAlign.left,),
                                    Icon(Bottom_Icons.base_icons_shop)
                                  ],
                                )
                            ),
                            Text(prod_ml.toString() ,
                              style: TextStyle( fontSize: _fontsize,
                                fontFamily: 'Roboto_Thin',),
                              softWrap: false,
                              textAlign: TextAlign.left,),
                            Text(prod_name.toString() ,
                              style: TextStyle( fontSize: _fontsize,
                                  fontFamily: 'Roboto_Thin',
                                  fontWeight: FontWeight.bold),
                              softWrap: false,
                              textAlign: TextAlign.left,),
                          ],
                        )
                    ),
                  ),
                )
            ))
    );
  }


}


class SpecialProduct extends StatefulWidget {


  final prod_name;
  final prod_price;
  final prod_picture;
  const SpecialProduct(this.prod_name , this.prod_price , this.prod_picture);
  @override
  _SpecialProductState createState() => _SpecialProductState();
}

class _SpecialProductState extends State<SpecialProduct> {




  int item_count = 1;
  int item_price;

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
      body: ListView(
        padding: EdgeInsets.all(5),
        primary: true,
        shrinkWrap: true,
        children: <Widget> [
          //Product Image
          Container(
            height: _imageSize,
            child: Container(
                child: Image.asset(widget.prod_picture)
            ),
          ),
          //Product Name
          Container(
            child: Container(
                child: Center(
                  child: Text(widget.prod_name , style: TextStyle(
                      fontSize: nameFontSize , fontFamily: 'Roboto_Thin' ,fontWeight: FontWeight.bold
                  ),) ,
                )),
          ),
          SizedBox(height: _paddingHeight,),
          //Product Price
          Container(
            child: Container(
                child: Center(
                  child: Text(widget.prod_price.toString()+" MMK" , style: TextStyle(
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
                child: Text(translator.translate('Add to Cart') ,style: TextStyle(
                    color: whiteTextColor ,
                    fontFamily: 'Roboto_Thin',fontSize: btnFontSize,
                    fontWeight: FontWeight.bold
                ),softWrap: false),
                onPressed: (){
                  //getCurrentDate();
                  if(!isSignin){
                    if(item_count != 0 ){
                      setState(() {
                        order_productName = widget.prod_name.toString();
                        order_price = widget.prod_price;
                        order_quantity = item_count;
                        total_price = (item_count*order_price);
/*                      name_list.add(order_productName);
                      quantity_list.add(order_quantity);
                      price_list.add(total_price);*/
                        if(name_list.length != 0){
                          for(int i=0;i<name_list.length ; i++){
                            if(name_list[i].toString() == order_productName){
                              quantity_list[i] += order_quantity;
                              price_list[i] += total_price ;
                              OrderedBox(context);
                              break;
                            }
                            else if(name_list[i].toString() != order_productName){
                              if(i==name_list.length-1){
                                name_list.add(order_productName);
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
                          quantity_list.add(order_quantity);
                          price_list.add(total_price);
                          OrderedBox(context);
                        }

                      });


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
                Text('Product Details' , style: TextStyle(
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
                Text('Product Details' , style: TextStyle(
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
                Text('Product Details' , style: TextStyle(
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
                Text('Product Details' , style: TextStyle(
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
                child: Text('Kirin Ichiban has a beautiful golden color with notes of European aroma hops and a silky, '
                    'smooth taste with a balanced hop finish. Ichiban means "number one", a fitting name for our beer, which uses only the first-press of the wort. '
                    'First press brewing is able to extract a higher concentration of flavor to create a distinctly crisp, '
                    'smooth and full-bodied beer.' ,style: TextStyle(
                    fontSize: infoSize , fontFamily: 'Roboto_Thin',fontWeight: FontWeight.bold
                ), textAlign: TextAlign.justify,),),
            ),
          ),
        ],
      ),
    );
  }


/*  getCurrentDate(){

    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {

      finalDate = formattedDate.toString() ;

    });

  }*/

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

  void AlartBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;


    var alert = AlertDialog(
      content: Text(translator.translate("Please Login first") ,style: TextStyle(
          fontSize: _fontSize , fontFamily: 'Roboto_Thin'
      ),textAlign: TextAlign.center,),
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

}