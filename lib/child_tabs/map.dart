/*import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

class MapPage extends StatefulWidget {
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  double latPoint , lngPoint ;
  LatLng constPoint ;
  List<Marker> myMarker = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PlatformMap(
          initialCameraPosition: CameraPosition(
            target: const LatLng(16.8061996, 96.1331954),
            zoom: 16.0,
          ),
          markers: Set.from(myMarker),
          //mapType: MapType.satellite,
          onTap: (location) {
            print('onTap: $location');
            setState(() {
              myMarker = [];
              constPoint = location;
              latPoint = constPoint.latitude;
              lngPoint = constPoint.longitude;
              print(latPoint);
              print(lngPoint);
              myMarker.add(
                  Marker(
                    markerId: MarkerId('marker_2'),
                    position: LatLng(latPoint, lngPoint),
                    icon: BitmapDescriptor.defaultMarker,
                  )
              );
            });
          } ,
          onCameraMove: (cameraUpdate) => print('onCameraMove: $cameraUpdate'),
          compassEnabled: true,
          onMapCreated: (controller) {
            Future.delayed(Duration(seconds: 2)).then(
                  (_) {
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    const CameraPosition(
                      bearing: 270.0,
                      target: LatLng(16.8061996, 96.1331954),
                      tilt: 30.0,
                      zoom: 18,
                    ),
                  ),
                );
                controller
                    .getVisibleRegion()
                    .then((bounds) => print("bounds: ${bounds.toString()}"));
              },
            );
          },
        ),
      ),
    );

  }


}*/

/*import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_love_liquor/child_tabs/my_cart_tab.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
//import 'package:location/location.dart';
//import 'package:permission/permission.dart';
import 'package:i_love_liquor/import_icon/bottom__icons_icons.dart';
import 'package:location/location.dart';

LocationData userPos;
bool map_loading = true;

class GoogMap extends StatefulWidget {
  @override
  _GoogMapState createState() => _GoogMapState();
}

class _GoogMapState extends State<GoogMap> {

  List<Marker> myMarker = [];

  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: lightGreenColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(titleTexts ,
            style: TextStyle(color: whiteTextColor ,
                fontFamily: 'Roboto_Thin',fontSize: deviceWidth/20),
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
        body: Container(
          color: Colors.black26,
          child: GoogleMap(
              initialCameraPosition:
              CameraPosition(target: LatLng(
                  16.8061996  , 96.1331954) , zoom: 16),
              markers: Set.from(myMarker),
              onTap: _handleTap,
              myLocationEnabled: true,
            ),
        ),

    );
  }

  _handleTap(LatLng tappedPoint){
    print(tappedPoint);
    setState(() {
      myMarker = [];
      myMarker.add(
          Marker(
            markerId: MarkerId(tappedPoint.toString()),
            position: tappedPoint,
          )
      );
    });
  }

}*/


/*
class GoogMap extends StatefulWidget {
  @override
  _GoogMapState createState() => _GoogMapState();
}

class _GoogMapState extends State<GoogMap> {


  Location location = Location();

  LocationData currentLocation;

  List<Marker> myMarker = [];

  void initState() {
    setState(() {
      map_loading = true;
    });
    location.onLocationChanged.listen((value) {
      setState(() {
        if(userPos == null){
          map_loading = false;
          currentLocation = value;
        }
        else{
          currentLocation = userPos;
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: lightGreenColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(titleTexts ,
            style: TextStyle(color: whiteTextColor ,
                              fontFamily: 'Roboto_Thin',fontSize: deviceWidth/20),
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
        padding: EdgeInsets.all(10),
        child: map_loading
            ?Center(child: CircularProgressIndicator())
        :Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: currentLocation == null
                  ? CircularProgressIndicator()
                  : Text("Location:" + currentLocation.toString() + " " ),
            ),
            Expanded(
              flex: 6,
              child: GoogleMap(
                initialCameraPosition:
                CameraPosition(target: LatLng(
                    currentLocation.latitude, currentLocation.longitude) , zoom: 16),
                markers: Set.from(myMarker),
                onTap: _handleTap,
              ),
            )
          ],
        ),

      )

    );
  }

  _handleTap(LatLng tappedPoint){
    print(tappedPoint);
    setState(() {
      myMarker = [];
      myMarker.add(
          Marker(
              markerId: MarkerId(tappedPoint.toString()),
              position: tappedPoint,
          )
      );
      userPos = tappedPoint as LocationData;
      print(userPos);
  });
}

}*/




