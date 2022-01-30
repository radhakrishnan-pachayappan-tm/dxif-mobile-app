import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rk/driver_details.dart';
import 'package:rk/models/department_model.dart';
import 'package:rk/reservation_details.dart';
import 'package:rk/terms_conditions.dart';
import 'package:rk/utils.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/department_model.dart';
import 'models/department_model.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  State<BillingScreen> createState() => _BillingScreen();
}

class _BillingScreen extends State<BillingScreen> {
  _BillingScreen({Key? key});
  bool _isLoading = true;
  late Department? _departments;
  late List<DeptDetails> _depatDetails ;
  List<String> _dropDownItems =[];
  late String _selectedValue = "0000";

  //late DeptDetails selectedValue = Map({"TMNA Officers": "950001_DG"}) as DeptDetails;
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    fetchDepartment();
  }

   fetchDepartment() async {
    // final Departments = await getToyotaDepartments();

    // Map _mapDepartment = jsonDecode(Departments);
    _departments = await getToyotaDepartments();//_mapDepartment["deptDetails"];
    print(_departments?.deptDetails?.length.toString());
    _depatDetails = _departments!.deptDetails!;
    print(_depatDetails.length);
     // _depatDetails.map((e) => _dropDownItems.add(e.deptName.toString()));
     _depatDetails.forEach((element) {_dropDownItems.add(element.deptName.toString());});
    print(_dropDownItems.length);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing & Rental Terms'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: <Widget>[
                const SizedBox(height: 20),
                const Text('Billing & Rental Terms',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    _titleWidget(),
                const SizedBox(height: 40),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Account Billable',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold))),
                const SizedBox(height: 10),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        'In case of an accident or additional fees, this department will be billed accordingly.',
                        style: TextStyle(fontSize: 15.0))),
                const SizedBox(height: 20),

              DropdownSearch<String>(
                items: _dropDownItems,
                label: "Department",
                onChanged: (data) {
                  print(data);
                  final selectedValue = _depatDetails.where((element) => element.deptName == data);
                  // _selectedValue = SelectedValue.single.deptCode.toString();
                  print(selectedValue.single.deptCode);
                  setState(() {
                    _selectedValue = selectedValue.single.deptCode.toString();
                  });
                },
                selectedItem: "-Select-",
                showSearchBox: true,

                // validator: (DeptDetails item) {
                //   if (item == null)
                //     return "Required field";
                //   else if (item == "Brazil")
                //     return "Invalid item";
                //   else
                //     return null;
                // },
              ),

                    // DropdownSearch<DeptDetails>(
                    //   showSelectedItems: true,
                    //   compareFn: (i, s) => i == s,
                    //   dropdownSearchDecoration: InputDecoration(
                    //     labelText: "Person",
                    //     contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   items: _departments,
                    //   //onFind: (String? filter) => getData(filter),
                    //   onChanged: (data) {
                    //     print(data);
                    //   },
                    //   dropdownBuilder: _customDropDownExample,
                    //   popupItemBuilder: _customPopupItemBuilderExample2,
                    // ),

                // DropdownSearch<DeptDetails>(
                //   //mode of dropdown
                //   mode: Mode.DIALOG,
                //   //to show search box
                //   showSearchBox: true,
                //   showSelectedItems: true,
                //   compareFn: (i, s) => i == s,
                //   //dropdownSearchDecoration:,
                //   //list of dropdown items
                //   //items: const ["Department","Depart"],
                //   //  items: _departments!.deptDetails,
                //   // itemAsString: (DeptDetails? u) => u!.deptName!,
                //   items: _depatDetails.map((Map val){
                //     return DropdownMenuItem<String>(
                //       value: val["deptCode"],
                //       child: new Text(val["deptName"]),
                //     );
                //   }).toList(),
                //   label: "Department",
                //   onChanged: print,
                //   //selectedItem: "",
                // ),

                    // SearchChoices.single(
                    //   hint: Text('Select'),
                    //   items: _departments.map((item) {
                    //     return new DropdownMenuItem<DeptDetails>(
                    //         child: Text(item.deptName.toString()), value: item);
                    //   }).toList(),
                    //   isExpanded: true,
                    //   value: selectedValue,
                    //   isCaseSensitiveSearch: true,
                    //   searchHint: new Text(
                    //     'Select ',
                    //     style: new TextStyle(fontSize: 20),
                    //   ),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       selectedValue = value;
                    //       print(selectedValue);
                    //     });
                    //   },
                    // ),
                const SizedBox(height: 30),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Department Code',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold))),
                const SizedBox(height: 10),
                    TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: _selectedValue.toString(),
                      hintText: 'Enter Your Last Name'),
                ),
                const SizedBox(height: 30),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Disclaimer',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold))),
                const SizedBox(height: 10),
                Container(
                  child: const Text(
                    "Toyota/Lexus has the right to change the details of your reservation based on...Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tortor etiam feugiat in elit, augue. Ultricies platea leo arcu donec donec ac amet. Imperdiet varius sed nisl sagittis ac. Viverra nulla potenti sed in at. Ridiculus vitae gravida sed convallis enim scelerisque ultrices adipiscing id. Vehicula mattis enim, eget libero viverra turpis in. Pulvinar eleifend sit varius elit, viverra suspendisse tempus, luctus. Volutpat tincidunt cras eu odio arcu, pharetra imperdiet massa netus. Morbi aliquet sapien mauris massa, eget aliquam lobortis libero.",
                    style: TextStyle(),
                    // textAlign: TextAlign.left,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 0.1,
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                ),
                const SizedBox(height: 30),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Terms & Conditions',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold))),
              Container(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton(
                     child: RichText(
                        text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.check_circle_rounded, size: 14,color: Colors.green,),
                            ),
                            TextSpan(
                              style: TextStyle(color: Colors.black),
                              text: "  Terms & Conditions Accepted",
                            ),
                            WidgetSpan(
                              child: Icon(Icons.navigate_next, size: 14,color: Colors.black,),
                            ),
                          ],
                        ),
                      ),
                      //child: const Text('Terms & Conditions Accepted',style: Icons.navigate_next,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TermsAndConditions()),
                        );
                      },
                    ),
                  padding: const EdgeInsets.only(left: 5.0,top: 2.0,bottom: 0.0)
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const DriverDetails()),
                    //     );
                    //   },
                    //   child: const Text("Back"),
                    // ),

                    ElevatedButton(
                      onPressed: () async {
                        final depatName = _depatDetails.where((element) => element.deptCode == _selectedValue);

                        final departmentPrefs = await SharedPreferences.getInstance();
                        departmentPrefs.setString('code', _selectedValue);
                        departmentPrefs.setString('name', depatName.single.deptName.toString());

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ReservationDetails()),
                        );
                      },
                      child: const Text("Submit"),
                    )
                  ],
                ),
              ]))),
    );
  }

  Widget _customPopupItemBuilderExample2(
      BuildContext context, DeptDetails? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.deptName ?? ''),
        //subtitle: Text(item?.createdAt?.toString() ?? ''),
        leading: CircleAvatar(
          // this does not work - throws 404 error
          // backgroundImage: NetworkImage(item.avatar ?? ''),
        ),
      ),
    );
  }

  Widget _customDropDownExample(BuildContext context, DeptDetails? item) {
    if (item == null) {
      return Container();
    }

    return Container(
      child: (item.deptCode == null)
          ? ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: CircleAvatar(),
        title: Text("No item selected"),
      )
          : ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: CircleAvatar(
          // this does not work - throws 404 error
          // backgroundImage: NetworkImage(item.avatar ?? ''),
        ),
        title: Text(item.deptName.toString()),
        // subtitle: Text(
        //   item.createdAt.toString(),
        // ),
      ),
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
              color: Colors.green,
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
              color: Colors.green,
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
              color: Colors.green,
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
              color: Colors.black,
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
}
