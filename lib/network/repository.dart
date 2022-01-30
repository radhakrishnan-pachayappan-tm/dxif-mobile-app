import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rk/models/inventory_models.dart';
import 'package:rk/models/reservation_model.dart';
import 'package:rk/reservation_details.dart';

import '../map/locations.dart';
import '../models/api_urls.dart';
import '../models/station_model.dart';
import '../models/token.dart';
import 'api_base_helper.dart';

class Repository {
  APIBaseHelper _helper = APIBaseHelper();

  // Repository getRepository;
  //
  // static final Repository _singleton = Repository._internal();
  //
  // factory Repository() {
  //   return _singleton;
  // }
  //
  // Repository._internal();
  // make this nullable by adding '?'
  static Repository? _instance;

  Repository._() {
    // initialization and stuff
  }

  factory Repository() {
    if (_instance == null) {
      _instance = new Repository._();
    }
    // since you are sure you will return non-null value, add '!' operator
    return _instance!;
  }

  static const NETWORK_ERROR = 'Please check your internet connection...';

  Future<InventoryModel> getInventory(String param) async {
    APIUrls apiUrls = APIUrls.fromJson(
      json.decode(
        await rootBundle.loadString('assets/jsons/config.json'),
      ) as Map<String, dynamic>,
    );
    return InventoryModel.fromJson(
        await _helper.get(apiUrls.getInventoryModels! + param));
  }

  Future<List<StationModel>> getStation() async {
    APIUrls apiUrls = APIUrls.fromJson(
      json.decode(
        await rootBundle.loadString('assets/jsons/config.json'),
      ) as Map<String, dynamic>,
    );

    final response = await _helper.get(apiUrls.getStationInfo!);

    //return response;
    // List jsonResponse = json.decode(response.body);
    List<StationModel> result = (response as List)
        .map((station) => StationModel.fromJson(station))
        .toList();

    return result;
    // return StationModel.fromJson(
    //     await _helper.get(apiUrls.getStationInfo!));
  }
  // Future<DetailNews> getDetailNews(url) async {
  //   return DetailNews.fromJson(await _helper.get(url));
  // }

  Future<bool> createReservation(Reservation data) async {
    APIUrls apiUrls = APIUrls.fromJson(
      json.decode(
        await rootBundle.loadString('assets/jsons/config.json'),
      ) as Map<String, dynamic>,
    );

    await _helper.post(apiUrls.post_create_reservation, data);

    return true;
  }
}
