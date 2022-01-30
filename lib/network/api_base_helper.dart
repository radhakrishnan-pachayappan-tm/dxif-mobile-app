import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rk/models/reservation_model.dart';
import 'package:rk/models/token.dart';

import '../models/api_urls.dart';
import '../utils.dart';
import 'exception.dart';

class APIBaseHelper {
  Future<dynamic> get(url) async {
    var responseJson;

    try {

      APIUrls apiUrls =  APIUrls.fromJson(
        json.decode(
          await rootBundle.loadString('assets/jsons/config.json'),
        ) as Map<String, dynamic>,
      );

      Token token =  Token.fromJson(
        json.decode(
          await rootBundle.loadString('assets/jsons/token.json'),
        ) as Map<String, dynamic>,
      );




Uri uri = Uri.parse(apiUrls.baseUrl.toString() + url.toString());
print("Req url=> ${uri.toString()}");

      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.accessToken}',
      });
      responseJson = _returnResponse(response);
      // print("")

    } on SocketException {
      throw NetworkException(NETWORK_ERROR, url);
    } on TimeoutException {
      throw ApiNotRespondingException('Timeout Exception');
    }
    return responseJson;
  }

  Future<dynamic> post(url,data) async {
    var responseJson;

    try {

      APIUrls apiUrls =  APIUrls.fromJson(
        json.decode(
          await rootBundle.loadString('assets/jsons/config.json'),
        ) as Map<String, dynamic>,
      );

      Token token =  Token.fromJson(
        json.decode(
          await rootBundle.loadString('assets/jsons/token.json'),
        ) as Map<String, dynamic>,
      );

      Uri uri = Uri.parse(apiUrls.baseUrl.toString() + url.toString());
      print("Req url=> ${uri.toString()}");

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token.accessToken}',
        },
        body: //data,
        json.encode(
          data
        ),
      );

      responseJson = _returnResponse(response);
      // print("")

    } on SocketException {
      throw NetworkException(NETWORK_ERROR, url);
    } on TimeoutException {
      throw ApiNotRespondingException('Timeout Exception');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    print('response code : ${response.statusCode.toString()}, '
        'body: ${response.body.toString()}');
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());

        return responseJson;
        break;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode :'
            '\ ${response.statusCode}',"url");
    }
  }
}
