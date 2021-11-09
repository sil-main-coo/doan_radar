import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/map_bloc.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  List<Marker> allMarker = [];

  @override
  Widget build(BuildContext context) {
    final mapBloc = MapBloc();
    mapBloc.getBytesFromCanvas(50.w, 50.w);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Định vị vật thể'),
          backgroundColor: Color(0xFF444d6a),
        ),
        body: StreamBuilder<Uint8List>(
            stream: mapBloc.stIcon,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                case ConnectionState.active:
                  if (snapshot.data == null)
                    return const CircularProgressIndicator();
                  return _buildMap(snapshot.data);
                case ConnectionState.done:
              }
              return null; // unreachable
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: _goToTheLake,
          child: Icon(Icons.my_location),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final position = LatLng(20.9808164,105.7940398);
    final GoogleMapController controller = await _controller.future;
    // final currentLocation= await _currentLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 18)));
  }

  Widget _buildMap(Uint8List icon) {
    final position = LatLng(20.9808164,105.7940398);

    allMarker.add(Marker(
        markerId: MarkerId('current'),
        draggable: false,
        position: position,
        icon: BitmapDescriptor.fromBytes(icon),
        onTap: () {
          // _scaffoldKey.currentState.showBottomSheet(
          //       (context){
          //     return BottomSheetContainer();
          //   },
          // );
        }));
    return GoogleMap(
      markers: Set.from(allMarker),
      zoomGesturesEnabled: true,
      compassEnabled: true,
      mapToolbarEnabled: true,
      scrollGesturesEnabled: true,
      trafficEnabled: true,
      mapType: MapType.terrain,
      initialCameraPosition: CameraPosition(
        target: position,
        zoom: 17,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
