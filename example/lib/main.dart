import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import './side_menu.dart';
// import 'dart:convert';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:scoped_model/scoped_model.dart';

import 'dart:async';

// import './BackgroundCollectedPageCopy.dart';
// import './BackgroundCollectingTaskCopy.dart';
// import './SelectBondedDevicePage.dart';
import 'bluetooth_connection.dart';

// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import './profile.dart';
// import './themes.dart';
import 'package:flutter_bluetooth_serial_example/user_preferences.dart';

// void main() => runApp(MyApp());

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserPreferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // static final String title = 'User Profile';

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BluetoothConnectionPage(),
    );

    // return Builder(
    //   builder: (context) => MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: title,
    //     theme: ThemeData(
    //       primarySwatch: Colors.green,
    //     ),
    //     home: BluetoothConnectionPage(),
    //   ),
    // );
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomePage createState() => new _HomePage();
// }

// class _HomePage extends State<HomePage> {
//   BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

//   String _address = "...";

//   Timer? _discoverableTimeoutTimer;
//   int _discoverableTimeoutSecondsLeft = 0;

//   BackgroundCollectingTask? _collectingTask;

//   bool _autoAcceptPairingRequests = false;

//   @override
//   void initState() {
//     super.initState();

//     // Get current state
//     FlutterBluetoothSerial.instance.state.then((state) {
//       setState(() {
//         _bluetoothState = state;
//       });
//     });

//     Future.doWhile(() async {
//       // Wait if adapter not enabled
//       if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
//         return false;
//       }
//       await Future.delayed(Duration(milliseconds: 0xDD));
//       return true;
//     }).then((_) {
//       // Update the address field
//       FlutterBluetoothSerial.instance.address.then((address) {
//         setState(() {
//           if (address != null){
//             _address = address;
//           }
//         });
//       });
//     });

//     // Listen for futher state changes
//     FlutterBluetoothSerial.instance
//         .onStateChanged()
//         .listen((BluetoothState state) {
//       setState(() {
//         _bluetoothState = state;

//         // Discoverable mode is disabled when Bluetooth gets disabled
//         _discoverableTimeoutTimer = null;
//         _discoverableTimeoutSecondsLeft = 0;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
//     _collectingTask?.dispose();
//     _discoverableTimeoutTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Bluetooth Serial'),
//       ),
//       body: Column(
//         children: <Widget>[ 
//         ListView(
//           children: <Widget>[          
//             Divider(),
//             ListTile(title: const Text('Multiple connections example')),
//             ListTile(
//               title: ElevatedButton(
//                 child: ((_collectingTask?.inProgress ?? false)
//                     ? const Text('Disconnect and stop background collecting')
//                     : const Text('Connect to start background collecting')),
//                 onPressed: () async {
//                   if (_collectingTask?.inProgress ?? false) {
//                     await _collectingTask?.cancel();
//                     setState(() {
//                       /* Update for `_collectingTask.inProgress` */
//                     });
//                   } else {
//                     final BluetoothDevice? selectedDevice =
//                         await Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return SelectBondedDevicePage(
//                               checkAvailability: false);
//                         },
//                       ),
//                     );

//                     if (selectedDevice != null) {
//                       await _startBackgroundTask(context, selectedDevice);
//                       setState(() {
//                       });
//                     }
//                   }
//                 },
//               ),
//             ),
//             ScopedModel<BackgroundCollectingTask>(
//               model: _collectingTask!,
//               child: BackgroundCollectedPage(),
//             ) ,
//           ],
//         ),
        
//         ]
//       ),
//     );
//   }

//   Future<void> _startBackgroundTask(
//     BuildContext context,
//     BluetoothDevice server,
//   ) async {
//     try {
//       _collectingTask = await BackgroundCollectingTask.connect(server);
//       await _collectingTask?.start();
//     } catch (ex) {
//       _collectingTask?.cancel();
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Error occured while connecting'),
//             content: Text("${ex.toString()}"),
//             actions: <Widget>[
//               new TextButton(
//                 child: new Text("Close"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }

// Tim, [23/3/22 12:23 PM]
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late final BluetoothConnection _connection;
//   List<int> _buffer = List<int>.empty(growable: true);
//   bool inProgress = false;

//   late GlobalKey<ScaffoldState> _scaffoldKey;
//   // late List<String> _demoData;
//   late List<String> club;
//   late List<int> lieAngle;
//   late List<int> swingSpeed;
//   late List<int> shaftLean;
//   late List<String> date;
//   late List<String> time;
//   late List<bool> isFavorited;
//   late List<TextEditingController> controllers;

//   late int totalSwingSpeed = 0;
//   late int totalShaftLean = 0;
//   late int totalLieAngle = 0;
//   late double averageSwingSpeed;
//   late double averageShaftLean;
//   late double averageLieAngle;
//   late List<double> averageStats = [];

//   @override
//   void initState() {
//     controllers = [];
//     for (int i = 0; i < 4; i++) {
//       controllers.add(TextEditingController());
//     }
//     club = ["", "", "", ""];
//     lieAngle = [10, 20, 30, 40];
//     swingSpeed = [120, 100, 150, 160];
//     shaftLean = [10, 10, 10, 10];
//     date = ['11/02/2022', '12/02/2022', '13/02/2022', '14/02/2022'];
//     time = ['11:02am', '10:50am', '7:25pm', '8:30pm'];
//     isFavorited = [false, false, false, false];
//     _scaffoldKey = GlobalKey();
//     super.initState();
//   }

// // This method will run when widget is unmounting
//   @override
//   void dispose() {
//     // disposing states
//     _scaffoldKey.currentState?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldKey,
//         drawer: NavDrawer(
//           club: club,
//           lieAngle: lieAngle,
//           swingSpeed: swingSpeed,
//           shaftLean: shaftLean,
//           date: date,
//           time: time,
//           isFavorited: isFavorited,
//           controllers: controllers,
//         ),
//         appBar: AppBar(
//           title: const Text('GOLFOMETER'),
//         ),
//         body: RefreshIndicator(
//           child: ListView.builder(
//             itemBuilder: (ctx, idx) {
//               var reversedControllers = controllers.reversed.toList();
//               var clubreversedList = club.reversed.toList();
//               var lieAnglereversedList = lieAngle.reversed.toList();
//               var swingSpeedreversedList = swingSpeed.reversed.toList();
//               var shaftLeanreversedList = shaftLean.reversed.toList();
//               var datereversedList = date.reversed.toList();
//               var timereversedList = time.reversed.toList();
//               var favoritedreversedList = isFavorited.reversed.toList();
//               return Card(
//                   child: Column(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Expanded(
//                           flex: 2,
//                           child: Container(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                     padding: EdgeInsets.all(10),
//                                     child: Text('Swing ${club.length - idx}')),
//                                 Row(
//                                   children: <Widget>[
//                                     Container(
//                                       padding: EdgeInsets.only(left: 10),
//                                       child: Text("Golf Club: "),
//                                     ),
//                                     Container(
//                                       padding:
//                                           EdgeInsets.only(left: 5, bottom: 3),
//                                       width: 140,
//                                       height: 40,
//                                       child: TextField(
//                                         controller: reversedControllers[idx],
//                                         textAlign: TextAlign.justify,
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               EdgeInsets.only(left: 7),
//                                           hintText: clubreversedList[idx] == ""
//                                               ? "eg. Iron 7"
//                                               : "",
//                                           labelStyle:
//                                               TextStyle(color: Colors.black),
//                                           border: OutlineInputBorder(),
//                                         ),
//                                         onSubmitted: (String value) {
//                                           setState(() {
//                                             clubreversedList[idx] = value;
//                                           });
//                                           SchedulerBinding.instance!
//                                               .addPostFrameCallback((_) {
//                                             club = clubreversedList.reversed
//                                                 .toList();
//                                           });
//                                           reversedControllers[idx].text =
//                                               clubreversedList[idx];
//                                         },
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Container(
//                                   padding: EdgeInsets.all(10),
//                                   child: Text('${datereversedList[idx]}')),
//                               Container(
//                                   padding: EdgeInsets.all(10),
//                                   child: Text('${timereversedList[idx]}')),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   IntrinsicHeight(
//                     child: Container(
//                       padding: EdgeInsets.only(bottom: 10, top: 5),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: <Widget>[
//                           Expanded(
//                               flex: 1,
//                               child: Container(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Container(child: Text('Lie Angle')),
//                                     Container(
//                                         padding: EdgeInsets.only(top: 10),
//                                         child: Text(
//                                             '${lieAnglereversedList[idx]}')),
//                                   ],
//                                 ),
//                               )),
//                           Expanded(
//                               flex: 1,
//                               child: Container(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Container(child: Text('Swing Speed')),
//                                     Container(
//                                         padding: EdgeInsets.only(top: 10),
//                                         child: Text(
//                                             '${swingSpeedreversedList[idx]}')),
//                                   ],
//                                 ),
//                               )),
//                           Expanded(
//                               flex: 1,
//                               child: Container(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Container(child: Text('Shaft Lean')),
//                                     Container(
//                                         padding: EdgeInsets.only(top: 10),
//                                         child: Text(
//                                             '${shaftLeanreversedList[idx]}')),
//                                   ],
//                                 ),
//                               )),
//                           Expanded(
//                               flex: 1,
//                               child: Container(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     IconButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           favoritedreversedList[idx] =
//                                               !favoritedreversedList[idx];
//                                         });
//                                         SchedulerBinding.instance!
//                                             .addPostFrameCallback((_) {
//                                           isFavorited = favoritedreversedList
//                                               .reversed
//                                               .toList();
//                                         });
//                                       },
//                                       icon: favoritedreversedList[idx]
//                                           ? Icon(Icons.favorite)
//                                           : Icon(Icons.favorite_border),
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ));
//             },
//             itemCount: club.length,
//             physics: const AlwaysScrollableScrollPhysics(),
//           ),
//           onRefresh: () {
//             return Future.delayed(
//               const Duration(seconds: 1),
//               () {
//                 setState(() {
//                   controllers.addAll(
//                       [TextEditingController(), TextEditingController()]);
//                   club.addAll(["", ""]);
//                   lieAngle.addAll([20, 40]);
//                   swingSpeed.addAll([150, 160]);
//                   shaftLean.addAll([-10, -4]);
//                   date.addAll(['15/02/2022', '16/02/2022']);
//                   time.addAll(['1:30pm', '4:30pm']);
//                   isFavorited.addAll([false, false]);
//                 });
//                 // showing snackbar
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Page Refreshed'),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }