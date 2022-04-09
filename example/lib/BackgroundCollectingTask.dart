// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:scoped_model/scoped_model.dart';

// class DataSample {
//   double temperature1;
//   double temperature2;
//   double waterpHlevel;
//   DateTime timestamp;

//   DataSample({
//     required this.temperature1,
//     required this.temperature2,
//     required this.waterpHlevel,
//     required this.timestamp,
//   });
// }

// class BackgroundCollectingTask extends Model {
//   static BackgroundCollectingTask of(
//     BuildContext context, {
//     bool rebuildOnChange = false,
//   }) =>
//       ScopedModel.of<BackgroundCollectingTask>(
//         context,
//         rebuildOnChange: rebuildOnChange,
//       );

//   final BluetoothConnection _connection;
//   List<int> _buffer = List<int>.empty(growable: true);

//   // @TODO , Such sample collection in real code should be delegated
//   // (via `Stream<DataSample>` preferably) and then saved for later
//   // displaying on chart (or even stright prepare for displaying).
//   // @TODO ? should be shrinked at some point, endless colleting data would cause memory shortage.
//   List<DataSample> samples = List<DataSample>.empty(growable: true);

//   bool inProgress = false;

//   BackgroundCollectingTask._fromConnection(this._connection) {
//     _connection.input!.listen((data) {
//       _buffer += data;

//       while (true) {
//         // If there is a sample, and it is full sent
//         int index = _buffer.indexOf('t'.codeUnitAt(0));
//         if (index >= 0 && _buffer.length - index >= 7) {
//           final DataSample sample = DataSample(
//               temperature1: (_buffer[index + 1] + _buffer[index + 2] / 100),
//               temperature2: (_buffer[index + 3] + _buffer[index + 4] / 100),
//               waterpHlevel: (_buffer[index + 5] + _buffer[index + 6] / 100),
//               timestamp: DateTime.now());
//           _buffer.removeRange(0, index + 7);

//           samples.add(sample);
//           notifyListeners(); // Note: It shouldn't be invoked very often - in this example data comes at every second, but if there would be more data, it should update (including repaint of graphs) in some fixed interval instead of after every sample.
//           //print("${sample.timestamp.toString()} -> ${sample.temperature1} / ${sample.temperature2}");
//         }
//         // Otherwise break
//         else {
//           break;
//         }
//       }
//     }).onDone(() {
//       inProgress = false;
//       notifyListeners();
//     });
//   }

//   static Future<BackgroundCollectingTask> connect(
//       BluetoothDevice server) async {
//     final BluetoothConnection connection =
//         await BluetoothConnection.toAddress(server.address);
//     return BackgroundCollectingTask._fromConnection(connection);
//   }

//   void dispose() {
//     _connection.dispose();
//   }

//   Future<void> start() async {
//     inProgress = true;
//     _buffer.clear();
//     samples.clear();
//     notifyListeners();
//     _connection.output.add(ascii.encode('start'));
//     await _connection.output.allSent;
//   }

//   Future<void> cancel() async {
//     inProgress = false;
//     notifyListeners();
//     _connection.output.add(ascii.encode('stop'));
//     await _connection.finish();
//   }

//   Future<void> pause() async {
//     inProgress = false;
//     notifyListeners();
//     _connection.output.add(ascii.encode('stop'));
//     await _connection.output.allSent;
//   }

//   Future<void> reasume() async {
//     inProgress = true;
//     notifyListeners();
//     _connection.output.add(ascii.encode('start'));
//     await _connection.output.allSent;
//   }

//   Iterable<DataSample> getLastOf(Duration duration) {
//     DateTime startingTime = DateTime.now().subtract(duration);
//     int i = samples.length;
//     do {
//       i -= 1;
//       if (i <= 0) {
//         break;
//       }
//     } while (samples[i].timestamp.isAfter(startingTime));
//     return samples.getRange(i, samples.length);
//   }
// }

import 'dart:convert';
import 'dart:convert' show utf8;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';

class DataSample {
  double lieAngle;
  double swingSpeed;
  double shaftLean;
  DateTime timestamp;
  String date;
  String time;

  DataSample({
    required this.lieAngle,
    required this.swingSpeed,
    required this.shaftLean,
    required this.timestamp,
    required this.date,
    required this.time,
  });
}

class BackgroundCollectingTask extends Model {
  static BackgroundCollectingTask of(
    BuildContext context, {
    bool rebuildOnChange = false,
  }) =>
      ScopedModel.of<BackgroundCollectingTask>(
        context,
        rebuildOnChange: rebuildOnChange,
      );

  // to try:
  // arduino convert to utf 16? - lacking memory
  // this code try to read in ascii

  final BluetoothConnection _connection;
  List<int> _buffer = List<int>.empty(growable: true);

  // @TODO , Such sample collection in real code should be delegated
  // (via `Stream<DataSample>` preferably) and then saved for later
  // displaying on chart (or even stright prepare for displaying).
  // @TODO ? should be shrinked at some point, endless colleting data would cause memory shortage.
  List<DataSample> samples = List<DataSample>.empty(growable: true);

  bool inProgress = false;

  BackgroundCollectingTask._fromConnection(this._connection) {
    _connection.input!.listen((Uint8List data) {
      _buffer += data;

      while (true) {
        // If there is a sample, and it is full sent
        // int index = _buffer.indexOf('t'.codeUnitAt(0));
        // var encoded = utf8.encode('G');
        const asciiEncoder = AsciiEncoder();
        const sample = 'G';
        final asciiValues = asciiEncoder.convert(sample);
        // int index = _buffer.indexOf('G'.codeUnitAt(0));
        int index = _buffer.indexOf(asciiValues[0]);
        // int index = 42;
        if (index >= 0 && _buffer.length - index >= 11) {
          final DataSample sample = DataSample(
              // lieAngle:
              //     (_buffer[index + 1] + _buffer[index + 2] + _buffer[index + 3])
              //         .toDouble(),
              lieAngle: double.parse(ascii.decode([_buffer[index + 1]]) + ascii.decode([_buffer[index + 2]]) + ascii.decode([_buffer[index + 3]])),
              swingSpeed: double.parse(ascii.decode([_buffer[index + 4]]) + ascii.decode([_buffer[index + 5]]) + ascii.decode([_buffer[index + 6]]) + ascii.decode([_buffer[index + 7]])),
              // swingSpeed: (_buffer[index + 4] +
              //         _buffer[index + 5] +
              //         _buffer[index + 6] +
              //         _buffer[index + 7])
              //     .toDouble(),
              shaftLean: double.parse(ascii.decode([_buffer[index + 8]]) + ascii.decode([_buffer[index + 9]]) + ascii.decode([_buffer[index + 10]])),

              // shaftLean: (_buffer[index + 8] +
              //         _buffer[index + 9] +
              //         _buffer[index + 10])
              //     .toDouble(),
              timestamp: DateTime.now(),
              date: DateFormat.yMd().format(DateTime.now()),
              time: DateFormat.jm().format(DateTime.now()));

          _buffer.removeRange(0, index + 11);

          samples.add(sample);
          notifyListeners(); // Note: It shouldn't be invoked very often - in this example data comes at every second, but if there would be more data, it should update (including repaint of graphs) in some fixed interval instead of after every sample.
          //print("${sample.timestamp.toString()} -> ${sample.temperature1} / ${sample.temperature2}");
        }
        // Otherwise break
        else {
          break;
        }
      }
    }).onDone(() {
      inProgress = false;
      notifyListeners();
    });
  }

  static Future<BackgroundCollectingTask> connect(
      BluetoothDevice server) async {
    final BluetoothConnection connection =
        await BluetoothConnection.toAddress(server.address);
    return BackgroundCollectingTask._fromConnection(connection);
  }

  void dispose() {
    _connection.dispose();
  }

  Future<void> start() async {
    inProgress = true;
    _buffer.clear();
    samples.clear();
    notifyListeners();
    _connection.output.add(ascii.encode('start'));
    await _connection.output.allSent;
  }

  Future<void> cancel() async {
    inProgress = false;
    notifyListeners();
    _connection.output.add(ascii.encode('stop'));
    await _connection.finish();
  }

  Future<void> pause() async {
    inProgress = false;
    notifyListeners();
    _connection.output.add(ascii.encode('stop'));
    await _connection.output.allSent;
  }

  Future<void> reasume() async {
    inProgress = true;
    notifyListeners();
    _connection.output.add(ascii.encode('start'));
    await _connection.output.allSent;
  }

  Iterable<DataSample> getLastOf(Duration duration) {
    DateTime startingTime = DateTime.now().subtract(duration);
    int i = samples.length;
    do {
      i -= 1;
      if (i <= 0) {
        break;
      }
    } while (samples[i].timestamp.isAfter(startingTime));
    return samples.getRange(i, samples.length);
  }
}
