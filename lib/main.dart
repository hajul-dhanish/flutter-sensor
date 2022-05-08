import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:sensor/write.dart';

import 'addnote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "todo app",
      theme: ThemeData(
        primaryColor: Colors.greenAccent[700],
      ),
      home: stateone(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class stateone extends StatefulWidget {
  const stateone({Key? key}) : super(key: key);

  @override
  State<stateone> createState() => _stateoneState();
}

class _stateoneState extends State<stateone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Home()),
                );
              });
            }, child: const Text("Door Status"),),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Write()),
              );
            }, child: const Text("Live Lab"),),
            ElevatedButton(onPressed: (){}, child: const Text("Automation"),),

            const SizedBox(height: 10),
            ElevatedButton(onPressed: (){
              setState(() {

              });
            }, child: const Icon(Icons.refresh)),

          ],
        ),
      ),
    );
  }
}



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final fb = FirebaseDatabase.instance;
  TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();
  var l;
  var g;
  var M;
  // var k;
  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('/Lab/');

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.indigo[900],
      //   onPressed: () {
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => addnote(),
      //       ),
      //     );
      //   },
      //   child: Icon(
      //     Icons.add,
      //   ),
      // ),
      appBar: AppBar(
        title: const Text(
          'Smart-Lab',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.indigo[900],
      ),
      body: FirebaseAnimatedList(
        query: ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          var v =
          snapshot.value.toString(); // {subtitle: webfun, title: subscribe}

          var M =
          snapshot.key.toString();

          g = v.replaceAll(
            RegExp("{|}|subtitle: |title: "),
              ""); // webfun, subscribe
          g.trim();

          l = g.split(','); // [webfun,  subscribe}]
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(onPressed: (){
                  setState(() {

                  });
                }, child: const Icon(Icons.refresh)),
                ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.indigo[100],
                  // leading: IconButton(
                  //   icon: Icon(
                  //     Icons.delete,
                  //     color: Color.fromARGB(255, 255, 0, 0),
                  //   ),
                  //   onPressed: () {
                  //     ref.child(snapshot.key!).remove();
                  //   },
                  // ),
                  trailing: l[0] == "OPEN" ? const Icon(Icons.online_prediction) : const Icon(Icons.close),
                  title: Text(
                    "${M} : ${l[0]}",
                    // 'dd',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // subtitle: Text(
                  //   l[0],
                  //   // 'dd',
                  //
                  //   style: TextStyle(
                  //     fontSize: 25,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }

//   upd() async {
//     // DatabaseReference ref1 = FirebaseDatabase.instance.ref("/Lab/");
//     DatabaseReference ref1 = fb.ref().child('/Lab/');
//
//
// // Only update the name, leave the age and address!
//     await ref1.update({
//       "title": second.text,
//       "subtitle": third.text,
//     });
//     second.clear();
//     third.clear();
//   }
}