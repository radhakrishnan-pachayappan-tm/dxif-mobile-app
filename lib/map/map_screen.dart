/*
 * Copyright 2019 Google LLC
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     https://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rk/main.dart';
import 'package:rk/models/station_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/geo_location_model.dart';
import '../models/theme_toyota.dart';
import 'locations.dart' as locations;

// void main() {
//   runApp(const MyApp());
// }

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapScreen> {

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {

    final dealerOffices = await locations.getToyotaDealerRegions();
    //GeoLocationModel geoRegion = await locations.getGeoInformation('boston');

    setState(() {
      _markers.clear();
      for (final office in dealerOffices) {
        final marker = Marker(
          markerId: MarkerId(office.stationName.toString()),
            position: LatLng(office.lat!.toDouble(), office.lng!.toDouble()),
            // position: LatLng(geoRegion.results![0].geometry!.location!.lat!.toDouble(), geoRegion.results![0].geometry!.location!.lng!.toDouble()),
          // icon: office.name.contains('Boston') ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
          //     : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: office.stationName.toString(),
            snippet: office.address,
          ),
          consumeTapEvents: true,
            onTap: () {
              setState(() async {

                final locationPrefs = await SharedPreferences.getInstance();
                locationPrefs.setString('address1', office.address.toString());
                locationPrefs.setString('state', office.stateName.toString());
                locationPrefs.setString('zip', office.zipcode.toString());
                locationPrefs.setString('city', office.city.toString());
                locationPrefs.setString('dealerCd', office.dealerCd.toString());
                locationPrefs.setString('station', office.stationName.toString());
                locationPrefs.setString('timezoneOffset', office.timeZoneOffset.toString());


                // print(locationPrefs.getString('city')! + locationPrefs.getString('zip')!);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(title: office.stationName.toString())),
                );
                print(office.stationName.toString());
              });
          },
        );
        _markers[office.stationName.toString()] = marker;
        // marker.addListener('mouseover', () => infoWindow.open(map, marker))
        // marker.addListener('mouseout', () => infoWindow.close())
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text('Toyota/Lexus Dealer Locations'),
          backgroundColor: ThemeClass.kToDark,//Colors.red//[700],
        ),
        body: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(42.015710, -71.235800),
            zoom: 2,
          ),
          markers: _markers.values.toSet(),

        ),
      //   floatingActionButton: FloatingActionButton.extended(
      //   //onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat), onPressed: () {  },
      // ),
      );

  }
}
