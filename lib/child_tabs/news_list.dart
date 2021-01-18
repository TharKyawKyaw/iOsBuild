import 'package:flutter/material.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'my_cart_tab.dart';

class NewsShow extends StatefulWidget {

  final news_title;
  final news_picture;
  final news_paragraph1;
  final news_paragraph2;
  final news_paragraph3;
  final news_paragraph4;
  final news_paragraph5;

  NewsShow(this.news_title , this.news_picture , this.news_paragraph1 ,this.news_paragraph2,
      this.news_paragraph3 , this.news_paragraph4 ,this.news_paragraph5);

  @override
  _NewsShowState createState() => _NewsShowState();
}

class _NewsShowState extends State<NewsShow> {

  List<String> _newsList = List<String>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _newsList = [];
    });
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController _textController = new TextEditingController(
      text: this.widget.news_paragraph1
    );
    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize = deviceWidth/20;
    double _headerFontSize = deviceWidth/25;
    double _fontSize =deviceWidth/30;

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
          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(this.widget.news_picture),
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
                      child: Row(
                        children: [
                          Text(this.widget.news_title,
                            style: new TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto_Thin',
                                fontSize: _headerFontSize , fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1),
                    Expanded(
                        flex: 10,
                        child: SingleChildScrollView(
                          child: Container(
                            child: Text('\t\t\t\t${this.widget.news_paragraph1}\n\n\t\t\t\t${this.widget.news_paragraph2}\n\n'
                                '\t\t\t\t${this.widget.news_paragraph3}\n\n\t\t\t\t${this.widget.news_paragraph4}\n\n'
                                '\t\t\t\t${this.widget.news_paragraph5}\n\n',
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



