
/*import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:location/location.dart';
import 'package:map/map.dart';


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool map_loading = false;
  LatLng _latLng = LatLng(16.8061996, 96.1331954);
  LatLng _newPin;
  Location location = Location();
  Offset _tapOffset;
  LocationData currentLocation;
  final controller = MapController(
    location: LatLng(16.8061996, 96.1331954),
  );

  void _gotoDefault() {
    setState(() {
      _latLng.latitude = currentLocation.latitude;
      _latLng.longitude = currentLocation.longitude;
    });
    controller.center = _latLng;
    print(controller.tileSize);
    print(controller.zoom.sign);
  }

  void _onDoubleTap() {
    controller.zoom += 0.5;
  }

  void _onSingleTap() {
    _newPin = controller.center;
    print(_newPin.longitude);
  }

  void _onTapUP(TapUpDetails details){

  }

  void _onTapDown(TapDownDetails details){
    _tapOffset = details.localPosition;
    print(_tapOffset);
  }
  void initState() {
    location.onLocationChanged.listen((value) {
      setState(() {
        currentLocation = value;
      });
    });
  }

  Offset _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    //controller.tileSize = 256 / devicePixelRatio;

    return Scaffold(
      appBar: AppBar(
        title: Text('Map Demo'),
      ),
      body: GestureDetector(
        onDoubleTap: _onDoubleTap,
        onTapUp: _onTapUP,
        onTapDown: _onTapDown,
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        onScaleEnd: (details) {
          print(
              "Location: ${controller.center.latitude}, ${controller.center.longitude}");
        },
        child: Map(
          controller: controller,
          provider: const CachedGoogleMapProvider(),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _gotoDefault,
        tooltip: 'My Location',
        child: Icon(Icons.my_location),
      ),
    );
  }
}

/// You can enable caching by using [CachedNetworkImageProvider] from cached_network_image package.
class CachedGoogleMapProvider extends MapProvider {
  const CachedGoogleMapProvider();

  @override
  ImageProvider getTile(int x, int y, int z) {
    //Can also use CachedNetworkImageProvider.
    return NetworkImage(
        'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425');
  }
}*/

