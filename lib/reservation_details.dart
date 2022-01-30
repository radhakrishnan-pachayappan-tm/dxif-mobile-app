import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rk/models/reservation_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network/repository.dart';

class ReservationDetails extends StatefulWidget {
  const ReservationDetails({Key? key}) : super(key: key);

  @override
  State<ReservationDetails> createState() => _ReservationDetails();
}

class _ReservationDetails extends State<ReservationDetails> {
  _ReservationDetails({Key? key});

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    createReservation();
  }

  createReservation() async {
    final reservations = await prepareReservationData();
    print(reservations.toJson());
    // print(reservations.filter?.model?.modelDescription);
    await Repository().createReservation(reservations);
}

  Future<Reservation> prepareReservationData() async{

  final reservationPreference = await SharedPreferences.getInstance();
  late Reservation reservationData = Reservation();

  reservationData.dealerCd = reservationPreference.getString('dealerCd');
  reservationData.contactLess = reservationPreference.getBool('contactLess');
  reservationData.action = 'submit';
  reservationData.reservationType = reservationPreference.getString('reservationType');
  reservationData.timezoneOffset = reservationPreference.getString('timezoneOffset');

  Model model =  Model();
  model.modelDescription = reservationPreference.getString('modelName');
  Filter filter = Filter();
  filter.model = model;
  reservationData.filter = filter;

  ReservedBy reservedBy = ReservedBy();
  reservedBy.firstName = reservationPreference.getString('firstName');
  reservedBy.lastName = reservationPreference.getString('lastName');
  reservedBy.userId = '521923';
  reservationData.reservedBy = reservedBy;

  ReservedFor reservedFor = ReservedFor();
  reservedFor.firstName = reservationPreference.getString('firstName');
  reservedFor.lastName = reservationPreference.getString('lastName');
  reservedFor.userId = '521923';
  reservedFor.customerType = 'TMNA Customer';
  reservedFor.email = reservationPreference.getString('email');
  reservedFor.phone = reservationPreference.getString('phone');
  reservationData.reservedFor = reservedFor;

  Department department = Department();
  department.name = reservationPreference.getString('name');
  department.code = reservationPreference.getString('code');
  reservationData.department = department;

  Reserve reserve = Reserve();
  reserve.startDateTime = reservationPreference.getString('startDateTime');
  reserve.endDateTime = reservationPreference.getString('endDateTime');
  reserve.station = reservationPreference.getString('location');
  reservationData.reserve = reserve;

  TermsAndCondition termsAndCondition = TermsAndCondition();
  termsAndCondition.accepted = 'Yes';
  termsAndCondition.timestamp = '2022-02-09T00:00:00.000Z';//reservationPreference.getString('endDateTime');
  reservationData.termsAndCondition = termsAndCondition;

  DriverDetails driverDetails = DriverDetails();
  driverDetails.firstName = reservationPreference.getString('firstName');
  driverDetails.lastName = reservationPreference.getString('lastName');
  driverDetails.phone = reservationPreference.getString('phone');
  driverDetails.email = reservationPreference.getString('email');
  driverDetails.customerType = 'TMNA Customer';
  driverDetails.expiry = '2022-02-09T00:00:00.000Z';//reservationPreference.getString('expiry');
  driverDetails.homeOffice = reservationPreference.getString('homeOffice');
  driverDetails.licence = reservationPreference.getString('licence');
  driverDetails.secEmail = reservationPreference.getString('secEmail');
  driverDetails.state = reservationPreference.getString('state');
  driverDetails.title = reservationPreference.getString('title');

  List<DriverDetails> lstDriverDetails = [];
  lstDriverDetails.add(driverDetails);

  reservationData.driverDetails = lstDriverDetails;

  return reservationData;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
         child: Container(),
    ));
  }
}
