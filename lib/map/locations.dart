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

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import '../models/geo_location_model.dart';
import '../models/map_location_model.dart';
import '../models/station_model.dart';
import '../network/repository.dart';

part 'locations.g.dart';

@JsonSerializable()
class LatLng {
  LatLng({
    required this.lat,
    required this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

@JsonSerializable()
class Region {
  Region({
    required this.coords,
    required this.id,
    required this.name,
    required this.zoom,
  });

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);

  final LatLng coords;
  final String id;
  final String name;
  final double zoom;
}

@JsonSerializable()
class Office {
  Office({
    required this.address,
    required this.id,
    required this.image,
    required this.lat,
    required this.lng,
    required this.name,
    required this.phone,
    required this.region,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeToJson(this);

  final String address;
  final String id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String region;
}

@JsonSerializable()
class Locations {
  Locations({
    required this.offices,
    required this.regions,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Office> offices;
  final List<Region> regions;
}

Future<Locations> getToyotaDealerOffices() async {
  //const googleLocationsURL = 'https://about.google/static/data/locations.json';
  https: //maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,
  // +Mountain+View,+CA&key=YOUR_API_KEY
  // Retrieve the locations of Google offices
  // try {
  //   final jsondata = await rootBundle.loadString('assets/jsons/locations.json');
  //   print(jsondata.toString());
  //   final response = await http.get(Uri.parse(googleLocationsURL));
  //
  //   if (response.statusCode == 200) {
  //     return Locations.fromJson(
  //
  //         json.decode(jsondata) as Map<String, dynamic>);
  //     //json.decode(response.body) as Map<String, dynamic>);
  //   }
  // } catch (e) {
  //   print(e);
  // }

  // Fallback for when the above HTTP request fails.
  return Locations.fromJson(
    json.decode(
      await rootBundle.loadString('assets/jsons/locations.json'),
    ) as Map<String, dynamic>,
  );
}

Future<List<StationModel>> getToyotaDealerRegions() async {

  //List<MapLocationModel> locations = [];
  List<StationModel> _stations = (await Repository().getStation()) as List<StationModel>;

  for(var _station in _stations) {
    GeoLocationModel geoRegion = await getGeoInformation(_station.stationName.toString());
    print(geoRegion.results);
    if(geoRegion.results!.length > 0) {
      _station.lat = geoRegion.results![0].geometry!.location!.lat!.toDouble();
      _station.lng = geoRegion.results![0].geometry!.location!.lng!.toDouble();
    }
    else {
      _station.lat = 33.658040;
      _station.lng = -117.758560;
    }
  }

  // for(var _station in _stations){
  //
  //   String _geocodeUri =
  //       'https://maps.googleapis.com/maps/api/geocode/json?address=${_station.city.toString() + ',' + _station.address! + ',' + _station.zipcode.toString()}&key=AIzaSyA6pV-x2fPg8lVIBtIW2T0rC5iiiDVRmMs';
  //
  //   final response = await http.get(Uri.parse(_geocodeUri));
  //
  //   if (response.statusCode == 200) {
  //     GeoLocationModel _geolocation = GeoLocationModel.fromJson(
  //         json.decode(response.body) as Map<String, dynamic>);
  //
  //   }
  //
  // }

  return _stations;
  // Fallback for when the above HTTP request fails.
  // else {
  //   return MapLocationModel.fromJson(
  //     json.decode(
  //       await rootBundle.loadString('assets/jsons/locations.json'),
  //     ) as Map<String, dynamic>,
  //   );
  // }
}

Future<GeoLocationModel> getGeoInformation(String address) async {


    String _geocodeUri =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=AIzaSyA6pV-x2fPg8lVIBtIW2T0rC5iiiDVRmMs';

    final response = await http.get(Uri.parse(_geocodeUri));

   // if (response.statusCode == 200) {
      GeoLocationModel _geolocation = GeoLocationModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>);

    //}

  return _geolocation;
}
