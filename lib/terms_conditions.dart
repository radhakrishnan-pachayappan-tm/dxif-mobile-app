import 'package:flutter/material.dart';
import 'package:rk/models/theme_toyota.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(height: 100, width:double.infinity,color: Colors.black12,),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text('Terms & Conditions', style: TextStyle(color: ThemeClass.kToDark,fontWeight: FontWeight.bold),),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                  ))
            ],
          ),
          const SizedBox(height: 20),
          Container(height: 1, width:double.infinity,color: Colors.black12,),
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
        ],
      ),
    );
  }
}

//stls
