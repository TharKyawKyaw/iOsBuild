import 'package:flutter/material.dart';
//import 'package:custom_navigator/custom_navigation.dart';
import 'package:flutter/services.dart';
import 'package:i_love_liquor/child_tabs/aboutus_tab.dart';
import 'package:i_love_liquor/child_tabs/ourstore_tab.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'home_tab.dart';
import 'shop_tab.dart';
import 'promotion_tab.dart';
import 'news_tab.dart';
import 'account_tab.dart';


class BottomNavigationBarController extends StatefulWidget {
  BottomNavigationBarController({Key key}) : super(key: key);

  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> with SingleTickerProviderStateMixin{



  int _selectedIndex = 0;
  List<int> _history = [0];
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  TabController _tabController;
  List<Widget> mainTabs;
  List<BuildContext> navStack = [null, null , null , null , null]; // one buildContext for each tab to store history  of navigation

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 5);
    mainTabs = <Widget>[
      Navigator(
          onGenerateRoute: (RouteSettings settings){
            return PageRouteBuilder(pageBuilder: (context, animiX, animiY) { // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
              navStack[0] = context;
              return HomeTab();
            });
          }),
      Navigator(
          onGenerateRoute: (RouteSettings settings){
            return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {  // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
              navStack[1] = context;
              return ShopTab();
            });
          }),
      Navigator(
          onGenerateRoute: (RouteSettings settings){
            return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {  // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
              navStack[2] = context;
              return PromotionTab();
            });
          }),
      Navigator(
          onGenerateRoute: (RouteSettings settings){
            return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {  // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
              navStack[3] = context;
              return NewsTab();
            });
          }),
      Navigator(
          onGenerateRoute: (RouteSettings settings){
            return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {  // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
              navStack[4] = context;
              return AccountTab();
            });
          }),
    ];
    super.initState();
  }

  Widget build(BuildContext context) {


    double deviceWidth = MediaQuery.of(context).size.width;
    double font_size = deviceWidth /35;
    double icon_size = deviceWidth /20;
    double shopicon_size = deviceWidth /17;

    final List<BottomNavigationBarRootItem> bottomNavigationBarRootItems = [
      BottomNavigationBarRootItem(
        bottomNavigationBarItem: BottomNavigationBarItem(
          backgroundColor: darkGreenColor,
          icon: Icon(Bottom_Icons.base_icons_home , size: icon_size,),

          title: Text(translator.translate('Home'),style: TextStyle(
              fontFamily: 'Roboto_Thin',fontSize: font_size ),),
        ),
      ),
      BottomNavigationBarRootItem(
        bottomNavigationBarItem: BottomNavigationBarItem(
          backgroundColor: darkGreenColor,
          icon: Icon(Bottom_Icons.base_icons_shop ,size: shopicon_size,),
          title: Text(translator.translate('Shop'),style: TextStyle(
              fontFamily: 'Roboto_Thin',fontSize: font_size ),),
        ),
      ),
      BottomNavigationBarRootItem(
        bottomNavigationBarItem: BottomNavigationBarItem(
          backgroundColor: darkGreenColor,
          icon: Icon(Bottom_Icons.base_icons_promotion ,size: icon_size),
          title: Text(translator.translate('Promotion'),style: TextStyle(
              fontFamily: 'Roboto_Thin',fontSize: font_size ),),
        ),
      ),
      BottomNavigationBarRootItem(
        bottomNavigationBarItem: BottomNavigationBarItem(
          backgroundColor: darkGreenColor,
          icon: Icon(Bottom_Icons.base_icons_news ,size: icon_size),
          title: Text(translator.translate('News'),style: TextStyle(
              fontFamily: 'Roboto_Thin',fontSize: font_size ),),
        ),
      ),
      BottomNavigationBarRootItem(
        bottomNavigationBarItem: BottomNavigationBarItem(
          backgroundColor: darkGreenColor,
          icon: Icon(Icons.person, size: shopicon_size,),
          title: Text(translator.translate('Account'),style: TextStyle(
              fontFamily: 'Roboto_Thin',fontSize: font_size ),),
        ),
      ),
    ];

    return WillPopScope(
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: mainTabs,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavigationBarRootItems.map((e) => e.bottomNavigationBarItem).toList(),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
      onWillPop: () async{
        if (Navigator.of(navStack[_tabController.index]).canPop()) {
          Navigator.of(navStack[_tabController.index]).pop();
          setState((){ _selectedIndex = _tabController.index; });
          return false;
        }else{
          if(_tabController.index == 0){
            setState((){ _selectedIndex = _tabController.index; });
            SystemChannels.platform.invokeMethod('SystemNavigator.pop'); // close the app
            return true;
          }else{
            _tabController.index = 0; // back to first tap if current tab history stack is empty
            setState((){ _selectedIndex = _tabController.index; });
            return false;
          }
        }
      },
    );
  }




  @override


  void _onItemTapped(int index) {
    _tabController.index = index;
    setState(() => _selectedIndex = index);
  }

}

class BottomNavigationBarRootItem {
  final String routeName;
  final NestedNavigator nestedNavigator;
  final BottomNavigationBarItem bottomNavigationBarItem;

  BottomNavigationBarRootItem({
    @required this.routeName,
    @required this.nestedNavigator,
    @required this.bottomNavigationBarItem,
  });
}

abstract class NestedNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  NestedNavigator({Key key, @required this.navigatorKey}) : super(key: key);
}

/*class HomeNavigator extends NestedNavigator {
  HomeNavigator({Key key, @required GlobalKey<NavigatorState> navigatorKey})
      : super(
    key: key,
    navigatorKey: navigatorKey,
  );

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => HomeTab();
            break;
          case '/home/1':
            builder = (BuildContext context) => AboutUsTab();
            break;
          case '/home/1':
            builder = (BuildContext context) => OurStoreTab();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },
    );
  }
}*/

/*class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeSubPage())),
          child: Text('Open Sub-Page'),
        ),
      ),
    );
  }
}

class HomeSubPage extends StatefulWidget {
  const HomeSubPage({Key key}) : super(key: key);

  @override
  _HomeSubPageState createState() => _HomeSubPageState();
}

class _HomeSubPageState extends State<HomeSubPage> with AutomaticKeepAliveClientMixin{
  @override
  // implement wantKeepAlive
  bool get wantKeepAlive => true;


  String _text;

  @override
  void initState() {
    _text = 'Click me';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Sub Page'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Testing())),
          child: Text(_text),
        ),
      ),
    );
  }

}

class Testing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Testing1())),
          child: Text("test"),
        ),
      ),
    );
  }
}

class Testing1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing1'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){},
          child: Text('Test1'),
        ),
      ),
    );
  }
}*/


/* convert it to statfull so i can use AutomaticKeepAliveClientMixin to avoid disposing tap *//*

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with AutomaticKeepAliveClientMixin{

  @override
  // implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Page'),
      ),
      body: Container(
        child: Center(
          child: Text('Settings Page'),
        ),
      ),
    );
  }

}*/
