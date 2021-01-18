import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/child_tabs/my_cart_tab.dart';
import 'package:i_love_liquor/data_save/products_data.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'product_detail_tab.dart';
import 'package:http/http.dart' as http;
import 'my_cart_tab.dart';

String search_text;
bool isSearch = false;
TextEditingController searchController = new TextEditingController();

class ProductsListTab extends StatefulWidget {

  final category_name;
  const ProductsListTab(this.category_name);
  @override
  _ProductsListTabState createState() => _ProductsListTabState();
}

class _ProductsListTabState extends State<ProductsListTab> {

  List<ProductData> categoryInfo = List<ProductData>();
  List<ProductData> displayCategoryInfo = List<ProductData>();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      categoryInfo = [];
      displayCategoryInfo = [];
    });
    for(int i=0; i<productdata.length;i++){
      if(productdata[i].category.toLowerCase() == widget.category_name.toString().toLowerCase()){
        categoryInfo.add(productdata[i]);
        displayCategoryInfo = categoryInfo;
      }
    }
  }

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
                      itemCount: displayCategoryInfo.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                          childAspectRatio: _aspectRatio),
                      itemBuilder: (BuildContext context , int index) {
                        return Single_prod(
                          prod_id: displayCategoryInfo[index].id,
                          prod_name: displayCategoryInfo[index].name,
                          prod_picture: displayCategoryInfo[index].imageURL,
                          prod_price: displayCategoryInfo[index].price,
                          prod_ml: displayCategoryInfo[index].size,
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
          });
        }
      },
    );
  }
}



class Single_prod extends StatelessWidget {

  final String prod_id;
  final String prod_name;
  final String prod_picture;
  final String prod_ml;
  final int prod_price;



  Single_prod({
    this.prod_id,
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
                    ProductsDetail(this.prod_id)),
              );
            },
                child: GridTile(
                  header: Container(
                    height: _gridHeight,
                    child: Center(child: Image.network(prod_picture)),
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
                          Text("${prod_ml} ml" ,
                            style: TextStyle( fontSize: _fontsize,
                                fontFamily: 'Roboto_Thin',
                                fontWeight: FontWeight.bold),
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
