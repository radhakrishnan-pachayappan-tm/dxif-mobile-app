import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:rk/driver_details.dart';
import 'package:http/http.dart' as http;
import 'package:rk/models/inventory_models.dart';
import 'package:rk/network/repository.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

class ShowAvailableVehicle extends StatefulWidget {
  const ShowAvailableVehicle({Key? key,required this.location,required this.pickupDate, required this.dropoffDate}) : super(key: key);
  static const List<ListItem> items = [];
  final String location;
  final String pickupDate;
  final String dropoffDate;
  // static final List<Map> myProducts = List.generate(
  //     100000, (index) => {"id": index, "name": "Toyota Product $index"})
  //     .toList();

  @override
  State<ShowAvailableVehicle> createState() => _ShowAvailableVehicleState(location: location,pickupDate: pickupDate,dropoffDate: dropoffDate);
}

class _ShowAvailableVehicleState extends State<ShowAvailableVehicle> {
  _ShowAvailableVehicleState({Key? key,required this.location,required this.pickupDate, required this.dropoffDate});
  final String location;
  final String pickupDate;
  final String dropoffDate;

  late InventoryModel _inventoryModel ;
  late final List<String> _lstModel= [];
  bool _isLoading = true;
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    String param = '?dealer=20090&startDateTime=${pickupDate}&endDateTime=${dropoffDate}&station=${location}';
    //String param = '?dealer=20090&startDateTime=2022-02-09T14:00:00Z&endDateTime=2022-02-25T14:00:00Z&station=Toyota Boston Region';
    _inventoryModel = await Repository().getInventory(param);
    print("fetchData=> ${_inventoryModel.vehicleSummary?.length.toString()}");
    getModel();
    setState(() {
      _isLoading = false;
    });
  }

  getModel(){
    for(var vehicleSummary in _inventoryModel.vehicleSummary!){
        _lstModel.add(vehicleSummary.model!.modelDescription.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pick Your Vehicle'),
        ),
        body: _isLoading ==true ? Center(child: CircularProgressIndicator(),):

        Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Expanded(
                flex: 3,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      const Text('Pick Your Vehicle',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      _titleWidget(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Expanded(
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(
                          //         left: 20, right: 0, bottom: 10, top: 10),
                          //     child: DropdownSearch<String>(
                          //       dropdownSearchDecoration: const InputDecoration(
                          //         border: OutlineInputBorder(),
                          //         contentPadding: EdgeInsets.fromLTRB(
                          //             12, 12, 8, 0),
                          //         labelText: "Search a country",
                          //       ),
                          //       popupTitle: Container(
                          //         height: 50,
                          //         decoration: BoxDecoration(
                          //           color: Theme
                          //               .of(context)
                          //               .primaryColorDark,
                          //           borderRadius: const BorderRadius.only(
                          //             topLeft: Radius.circular(20),
                          //             topRight: Radius.circular(20),
                          //           ),
                          //         ),
                          //         child: const Center(
                          //           child: Text(
                          //             'Vehicle Type',
                          //             style: TextStyle(
                          //               // fontSize: 24,
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.white,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       popupShape: const RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.only(
                          //           topLeft: Radius.circular(24),
                          //           topRight: Radius.circular(24),
                          //         ),
                          //       ),
                          //       mode: Mode.DIALOG,
                          //       showSearchBox: true,
                          //       showSelectedItems: true,
                          //       items: const [
                          //         "Vehicle Type",
                          //         "India",
                          //         "USA",
                          //         "Brazil",
                          //         "Canada",
                          //         "Australia",
                          //         "Singapore"
                          //       ],
                          //       label: "Vehicle Type",
                          //       onChanged: print,
                          //       selectedItem: "Vehicle Type",
                          //     ),
                          //   ),
                          // ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10, top: 10),
                              child: DropdownSearch<String>(
                                mode: Mode.DIALOG,
                                showSearchBox: true,
                                showSelectedItems: true,
                                items: _lstModel,//_inventoryModel.vehicleSummary?[0].model?.modelDescription as List<String>,
                                label: "Model",
                                onChanged: print,
                                selectedItem: "Model",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
              Expanded(
                flex: 9,
                child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1,
                    ),
                    itemCount: _inventoryModel.vehicleSummary?.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        width: 300,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            top: 20.0, left: 20, right: 20.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(children: <Widget>[
                          const Padding(padding: EdgeInsets.only(top: 20.0)),
                          Container(
                              margin: const EdgeInsets.only(left: 15),
                              alignment: Alignment.topLeft,
                              child: Text(_inventoryModel.vehicleSummary![index].brand.toString()+' '+ _inventoryModel.vehicleSummary![index].model!.modelDescription.toString())),
                          Container(
                              height: 250.0,
                              child: Image.network(_inventoryModel.vehicleSummary![index].media![0].href.toString())),
                                  //'https://media.rti.toyota.com/config/pub/static/images/TOY/2021/rav4/exteriorcolor/carjellyimage/8e7670a342ac86668860e63f8362e8cd913add72114fa7f1e905390beee3182a_2021_810B_US_XLE-Premium-AWD-Hybrid_06X3_002.png')),
                          Container(
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () async {
                                final modelPrefs = await SharedPreferences.getInstance();
                                modelPrefs.setString('modelName', _inventoryModel.vehicleSummary![index].model!.modelDescription.toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                       DriverDetails()),
                                );
                                //setState(() {});
                              },
                              child: const Text("Select Vehicle"),
                            ),
                          )
                        ]),
                      );
                    }),
              )
            ]))
      // ),
    );
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

  // Future<InventoryModel> getInventoryModels() async {
  //   //   try {
  //   //   String token = '';//await Candidate().getToken();
  //   //   final response = await http.get(Uri.parse('uri'), headers: {
  //   //     'Content-Type': 'application/json',
  //   //     'Accept': 'application/json',
  //   //     'Authorization': 'Bearer $token',
  //   //   });
  //   //   print('Token : ${token}');
  //   //   print(response);
  //   //     if (response.statusCode == 200) {
  //   //       return InventoryModel.fromJson(
  //   //       json.decode(response.body) as Map<String, dynamic>);
  //   //     }
  //   //   //return "Test";
  //   // } catch (e) {
  //   //   print(e);
  //   //   return ;
  //   // }
  //   // }
  //   InventoryModel inventoryModel = await Repository().getInventory();
  //   print(inventoryModel);
  //   return inventoryModel;
  // }
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}
