import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rk/models/department_model.dart';
import 'package:rk/models/home_office_model.dart';
import 'package:rk/models/state_model.dart';

const NETWORK_ERROR = 'Please check your internet connection...';
const SERVER_ERROR = 'Something went wrong, please try again...';

Future<Department> getToyotaDepartments() async {

  return Department.fromJson(
    json.decode(
      await rootBundle.loadString('assets/jsons/department.json'),
    ) as Map<String, dynamic>,
  );

  // String Departments = await rootBundle.loadString("assets/jsons/department.json");
  // return Departments;
  //Map _mapCompnay = jsonDecode(jsonCompany);
}

Future<HomeOffice> getHomeOfficeDetails() async {

  return HomeOffice.fromJson(
    json.decode(
      await rootBundle.loadString('assets/jsons/home_office.json'),
    ) as Map<String, dynamic>,
  );
}

Future<StateModel> getStates() async {

  return StateModel.fromJson(
    json.decode(
      await rootBundle.loadString('assets/jsons/states.json'),
    ) as Map<String, dynamic>,
  );
}

Future<bool> createReservation(data) async {
return true;
}
