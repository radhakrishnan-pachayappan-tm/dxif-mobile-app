import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:rk/UserModel.dart';
import 'package:rk/show_vehicle.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'map/map_screen.dart';
import 'models/theme_toyota.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primaryColor: Color(0xffCC0000)
        primarySwatch: ThemeClass.kToDark
      ),
      home: const MyHomePage(title: 'User Reservation'),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US')],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState( location: title);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({Key? key, required this.location}); //: super(key: key);
  final String location;
  final GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();

  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _locationController = TextEditingController(text: locationValue);
  late TextEditingController _pickUpDateController = TextEditingController();
  bool? isContactLessPickup = false;

  String _startDateTime = '';
  String _endDateTime = '';
  String _valueToValidate1 = '';
  String _valueToValidate2 = '';
  String _valueSaved1 = '';
  String _valueSaved2 = '';

  String locationValue = '';
  dynamic radioItem = '';

// Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'Business';

  // Group Value for Radio Button.
  int id = 1;

  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'en_US';
    _controller1 = TextEditingController(text: DateTime.now().toString());
    _controller2 = TextEditingController(text: DateTime.now().toString());
    locationValue = location.toString();
    _locationController = TextEditingController(text: locationValue);

    _getValue();
  }

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = '2000-10-22 14:30';
        // _controller1.text = '2000-09-20 14:30';
        // _controller2.text = '2020-09-20 07:30';
        // _controller2.text = '2001-10-21 15:31';
        // _controller3.text = '2002-11-22';
        // _controller4.text = '17:01';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.,
          children: <Widget>[
            const Text('Reservation Details', style: TextStyle(fontSize: 15.0)),
            const SizedBox(height: 20),
            _titleWidget(),
            const SizedBox(height: 20),
            // const Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text('Request Type', style: TextStyle(fontSize: 15.0))),
            SizedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: isContactLessPickup,
                        onChanged: (bool? value) {
                          setState(() {
                            isContactLessPickup = value;
                          });
                        },
                      ),
                      const Text(
                        'I want contactless pick-up and drop-off',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ])),
            //const Text('I want contactless pick-up and drop-off', style: TextStyle(fontSize: 15.0)),
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Request Type',
                    style: TextStyle(fontSize: 17.0),
                  ),
                  Radio(
                    activeColor: Colors.blue,
                    value: 1,
                    groupValue: id,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = 'Business';
                        id = 1;
                      });
                    },
                  ),
                  const Text(
                    'Business',
                    style: TextStyle(fontSize: 17.0),
                  ),
                  Radio(
                    activeColor: Colors.blue,
                    value: 2,
                    groupValue: id,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = 'Personal';
                        id = 2;
                      });
                    },
                  ),
                  const Text(
                    'Personal',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Pick-Up & Drop-Off Location',

                    style: TextStyle(fontSize: 15.0))),
            const SizedBox(height: 10),
            // InkWell(onTap:() => _goToMap(), child: Text('Pick-Up & Drop-Off Location')),
            InkWell(child: TextField(onTap:() {_goToMap();},
              controller: _locationController,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                prefixIcon: Icon(Icons.location_on),
                hintText: 'City, Zipcode or Location',
              ),

            )),
            // DropdownSearch<String>(
            //   //mode of dropdown
            //   mode: Mode.DIALOG,
            //   //to show search box
            //   showSearchBox: true,
            //   showSelectedItems: true,
            //   //list of dropdown items
            //   items: const [
            //     "India",
            //     "USA",
            //     "Brazil",
            //     "Canada",
            //     "Australia",
            //     "Singapore"
            //   ],
            //   label: "Pick-Up & Drop-Off location",
            //   onChanged: print,
            //   selectedItem: "",
            // ),
            const SizedBox(height: 30),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Pick-Up Date & Time',
                    style: TextStyle(fontSize: 15.0))),
            Form(
              key: _oFormKey,
              child: DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                firstDate: DateTime(2000),
                lastDate: DateTime(2050),
                icon: const Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Hour",
                use24HourFormat: false,
                locale: const Locale('en', 'US'),
                selectableDayPredicate: (date) {
                  if (date.weekday == 6 || date.weekday == 7) {
                    return false;
                  }
                  return true;
                },
                onChanged: (val) => setState(()
                {
                print("_valueChanged2=> $val");
                // DateTime now = DateTime.now();
                String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(val));
                print("formattedDate=> $formattedDate");
                _startDateTime = formattedDate;

                }
                ),
                validator: (val) {
                  setState(() => _valueToValidate1 = val ?? '');
                  return null;
                },
                onSaved: (val) => setState(() => _valueSaved1 = val ?? ''),
              ),
            ),
            const SizedBox(height: 30),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Drop-Off Date & Time',
                    style: TextStyle(fontSize: 15.0))),
            DateTimePicker(
              type: DateTimePickerType.dateTimeSeparate,
              dateMask: 'd MMM, yyyy',
              // controller: _controller2,
              //initialValue: _initialValue,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: const Icon(Icons.event),
              dateLabelText: 'Date',
              timeLabelText: "Hour",
              use24HourFormat: false,
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
                String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(val));
              print("formattedDate=> $formattedDate");
              _endDateTime = formattedDate;

              }),
              validator: (val) {
                print("new => $val");
                setState(() => _valueToValidate2 = val ?? '');
                return null;
              },
              onSaved: (val) => setState(() => _valueSaved2 = val ?? ''),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                String location = '';
                String pickupDate= '';
                String dropOfDate = '';

                final reservationPrefs = await SharedPreferences.getInstance();
                reservationPrefs.setString('location', _locationController.text);
                reservationPrefs.setString('startDateTime', _startDateTime);
                reservationPrefs.setString('endDateTime', _endDateTime);
                reservationPrefs.setString('reservationType', radioButtonItem);
                reservationPrefs.setBool('contactLess', isContactLessPickup!);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowAvailableVehicle(
                      location:_locationController.text,
                      pickupDate:_startDateTime,
                      dropoffDate: _endDateTime,
                  )),
                );
                print(_locationController.text);
                print(_endDateTime);
                print(_startDateTime);
                setState(() {});
              },
              child: const Text('Show Available Vehicles'),
            ),
          ],
        ),
      ),
      drawer: Drawer(child: ListView(
        children: [
          const DrawerHeader(child: Text("Fleet Management"), decoration: BoxDecoration(color: ThemeClass.kToDark),),
          ListTile(title: const Text("Company Fleet Management"),onTap: (){

          Navigator.pop(context);
          },),
          ListTile(title: const Text("Reserve Company Car"),onTap: (){

            Navigator.pop(context);
          },),
        ],

      ),),
    );
  }

  _goToMap() {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapScreen()),
    );
  }

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.center,
      child: Row
        (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: Colors.black,
              border: Border.all(
                color: Colors.black,
                width: 0.1,
              ),
            ),
            width: 10, height: 10,
          )
          ,
          Container(margin: const EdgeInsets.all(0),
            width: 50, height: 1, color: Colors.black,

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
            width: 10, height: 10,
          ),
          Container(margin: const EdgeInsets.all(0),
            width: 50, height: 1, color: Colors.black,

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
            width: 10, height: 10,
          ),
          Container(margin: const EdgeInsets.all(0),
            width: 50, height: 1, color: Colors.black,

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
            width: 10, height: 10,
          )
        ],
      ),
    );
  }

  // Future<List<UserModel>> getData(filter) async {
  //   var response = await Dio().get(
  //     "https://5d85ccfb1e61af001471bf60.mockapi.io/user",
  //     queryParameters: {"filter": filter},
  //   );
  //
  //   final data = response.data;
  //   if (data != null) {
  //     return UserModel.fromJsonList(data);
  //   }
  //
  //   return [];
  // }
}
