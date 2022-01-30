import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rk/models/home_office_model.dart';
import 'package:rk/models/state_model.dart';
import 'package:rk/show_vehicle.dart';
import 'package:rk/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'billing.dart';

class DriverDetails extends StatefulWidget {
  // final GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  DriverDetails({Key? key}) : super(key: key);
  // final String _valueChanged1 = '';
  // final String _valueToValidate1 = '';
  // final String _valueSaved1 = '';

  @override
  State<DriverDetails> createState() => _DriverDetails();
}

class _DriverDetails extends State<DriverDetails> {
  bool? isReservedForSomeone = false;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final titleController = TextEditingController();
  final primaryEmailController = TextEditingController();
  final secEmailController = TextEditingController();
  final licenseController = TextEditingController();
  final phoneController = TextEditingController();

  String _expiryDateTime = '';
  late String _homeofficeSelectedValue = "-Select-";
  late String _stateSelectedValue = "-Select-";

  bool _isLoading = true;
  late HomeOffice? _homeOffice;
  late List<Data> _homeofficeDetails;
  List<String> _homeOfficeDropDownItems = [];

  late StateModel? _states;
  late List<StateDetails> _stateDetails;
  List<String> _stateDropDownItems = [];

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    fetchHomeOffice();
    fetchStates();
  }

  fetchHomeOffice() async {
    _homeOffice = await getHomeOfficeDetails(); //_mapDepartment["deptDetails"];
    _homeofficeDetails = _homeOffice!.data!;
    _homeofficeDetails.forEach((element) {
      _homeOfficeDropDownItems.add(element.subname![0].displayName.toString());
    });

    setState(() {
      _isLoading = false;
    });
  }

  fetchStates() async {
    _states = await getStates(); //_mapDepartment["deptDetails"];
    _stateDetails = _states!.data!;
    _stateDetails.forEach((element) {
      _stateDropDownItems.add(element.viewValue.toString());
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Details'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.,
                        children: <Widget>[
                      const SizedBox(height: 20),
                      const Text('Driver Details',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      _titleWidget(),
                      const SizedBox(height: 20),
                      const Text('*Information should match drivers license'),
                      const SizedBox(height: 20),

                      SizedBox(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                            Checkbox(
                              value: isReservedForSomeone,
                              onChanged: (bool? value) {
                                setState(() {
                                  isReservedForSomeone = value;
                                });
                              },
                            ),
                            const Text(
                              'I am reserving for someone else',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ])),
                      // const Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text('First Name',
                      //         style: TextStyle(fontSize: 15.0))),
                      TextField(
                        controller: firstNameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'First Name',
                            hintText: 'Enter Your First Name'),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: lastNameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Last Name',
                            hintText: 'Enter Your Last Name'),
                      ),
                      const SizedBox(height: 20),
                      DropdownSearch<String>(
                        items: _homeOfficeDropDownItems,
                        label: "Home Office",
                        onChanged: (data) {
                          print(data);
                          final selectedValue = _homeofficeDetails.where(
                              (element) =>
                                  element.subname![0].displayName == data);
                          setState(() {
                            _homeofficeSelectedValue = selectedValue
                                .single.subname![0].name
                                .toString();
                          });
                        },
                        selectedItem: "-Select-",
                        showSearchBox: true,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Title',
                            hintText: 'Enter Title'),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: primaryEmailController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Primary Email',
                            hintText: 'Enter Primary Email'),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: secEmailController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Secondary Email',
                            hintText: 'Enter Secondary Email'),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mobile Number',
                            hintText: 'Enter Mobile Number'),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: licenseController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Drivers License #',
                            hintText: 'Enter Primary Drivers License Number'),
                      ),
                      const SizedBox(height: 20),
                      DropdownSearch<String>(
                        items: _stateDropDownItems,
                        label: "State",
                        onChanged: (data) {
                          print(data);
                          final selectedValue = _stateDetails
                              .where((element) => element.viewValue == data);
                          setState(() {
                            _stateSelectedValue =
                                selectedValue.single.value.toString();
                          });
                        },
                        selectedItem: "-Select-",
                        showSearchBox: true,
                      ),
                      const SizedBox(height: 20),
                      Form(
                        // key: _oFormKey,
                        child: DateTimePicker(
                          type: DateTimePickerType.date,
                          dateMask: 'd MMM, yyyy',

                          // controller: _controller1,
                          //initialValue: _initialValue,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050),
                          icon: const Icon(Icons.event),
                          dateLabelText: 'DL Expiration Date',
                          locale: const Locale('en', 'US'),
                          selectableDayPredicate: (date) {
                            if (date.weekday == 6 || date.weekday == 7) {
                              return false;
                            }
                            return true;
                          },
                          onChanged: (val) => setState(() {
                            print("_valueChanged2=> $val");
                            // DateTime now = DateTime.now();
                            String formattedDate =
                                DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(DateTime.parse(val));
                            print("formattedDate=> $formattedDate");
                            _expiryDateTime = formattedDate;
                          }),
                          // onChanged: (val) => setState(() => _valueChanged1 = val),
                          // validator: (val) {
                          //   setState(() => _valueToValidate1 = val ?? '');
                          //   return null;
                          // },
                          // onSaved: (val) => setState(() => _valueSaved1 = val ?? ''),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          // ElevatedButton(
                          //   onPressed: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(builder: (context) => const ShowAvailableVehicle()),
                          //     );
                          //   },
                          //   child: const Text("Back"),
                          // ),
                        ],
                      ),
                    ])),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      final driverDetailsPrefs =
                          await SharedPreferences.getInstance();
                      driverDetailsPrefs.setBool(
                          'isReservedForSomeone', isReservedForSomeone!);
                      driverDetailsPrefs.setString(
                          'firstName', firstNameController.text);
                      driverDetailsPrefs.setString(
                          'lastName', lastNameController.text);
                      driverDetailsPrefs.setString(
                          'email', primaryEmailController.text);
                      driverDetailsPrefs.setString(
                          'phone', phoneController.text);
                      driverDetailsPrefs.setString(
                          'secEmail', secEmailController.text);
                      driverDetailsPrefs.setString(
                          'state', _stateSelectedValue);
                      driverDetailsPrefs.setString(
                          'expiry', _expiryDateTime);
                      driverDetailsPrefs.setString(
                          'licence', licenseController.text);
                      driverDetailsPrefs.setString(
                          'title', titleController.text);
                      driverDetailsPrefs.setString(
                          'homeOffice', _homeofficeSelectedValue);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BillingScreen()),
                      );
                    },
                    child: const Text("Next"),
                  ),
                ),
              )
            ],
          )),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.navigate_before),
      //       label: 'Back',
      //       backgroundColor: Colors.red,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.navigate_next),
      //       label: 'Next',
      //       backgroundColor: Colors.red,
      //     ),
      //   ],
      //   // currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.red, //Colors.amber[800],
      //   unselectedItemColor: Colors.red,
      //   backgroundColor: Colors.white,
      //   onTap: _onItemTapped,
      // ),
    );
  }

  void _onItemTapped(int index) {
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DriverDetails(),))
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const DriverDetails()),
    // );
    // setState(() {
    //   _selectedIndex = index;
    // });
  }

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: Colors.green,
              border: Border.all(
                color: Colors.black,
                width: 0.1,
              ),
            ),
            width: 10,
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(0),
            width: 50,
            height: 1,
            color: Colors.black,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: Colors.green,
              border: Border.all(
                color: Colors.black,
                width: 0.1,
              ),
            ),
            width: 10,
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(0),
            width: 50,
            height: 1,
            color: Colors.black,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: Colors.black,
              border: Border.all(
                color: Colors.black,
                width: 0.1,
              ),
            ),
            width: 10,
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(0),
            width: 50,
            height: 1,
            color: Colors.black,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: Colors.black26,
              border: Border.all(
                color: Colors.black,
                width: 0.1,
              ),
            ),
            width: 10,
            height: 10,
          )
        ],
      ),
    );
  }
}
