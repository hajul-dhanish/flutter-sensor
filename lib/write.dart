import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'addnote.dart';

class Write extends StatefulWidget {
  const Write({Key? key}) : super(key: key);

  @override
  State<Write> createState() => _WriteState();
}

class _WriteState extends State<Write> {
  late List<bool> isSelected;

  final fb = FirebaseDatabase.instance;

  @override
  void initState() {
    // isSelected = [true, false];
    isSelected = [false, true];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('/LAB_AUTOMATION/');
    // isfinalSelected == 0 ? isSelected == true : 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lab Automation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ToggleSwitch(
              initialLabelIndex: 0,
              totalSwitches: 2,
              labels: ['OFF', 'ON'],
              onToggle: (index) {
                // print('switched to: $index');
                        ref.set({
                          // "Light": isSelected,
                          "Light": "$index",
                        }).asStream();
              },
            ),

            // ToggleButtons(
            //   borderColor: Colors.black,
            //   fillColor: Colors.green,
            //   borderWidth: 2,
            //   selectedBorderColor: Colors.black,
            //   selectedColor: Colors.white,
            //   borderRadius: BorderRadius.circular(0),
            //   children: <Widget>[
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(
            //         'ON',
            //         style: TextStyle(fontSize: 16),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(
            //         'OFF',
            //         style: TextStyle(fontSize: 16),
            //       ),
            //     ),
            //   ],
            //   onPressed: (int index) {
            //     // setState(() {
            //     //   for (int i = 0; i < isSelected.length; i++) {
            //     //     isSelected[i] = i == index;
            //     //     ref.set({
            //     //       // "Light": isSelected,
            //     //       "Light": isfinalSelected,
            //     //     }).asStream();
            //     //   }
            //     // });
            //     setState(() {
            //       var f;
            //       for (int i = 0; i < f.length; i++) {
            //         f[i] = i == index;
            //         ref.set({
            //           // "Light": isSelected,
            //           "Light": f,
            //         }).asStream();
            //       }
            //     });
            //   },
            //   isSelected: isSelected,
            // ),
          ],
        ),
      ),
    );
  }
}
