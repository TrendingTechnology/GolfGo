import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bluetooth_serial_example/side_menu.dart';

// import 'package:flutter_bluetooth_serial_example/BackgroundCollectingTaskCopy.dart';
import 'package:flutter_bluetooth_serial_example/BackgroundCollectingTask.dart';
import 'package:intl/intl.dart';
import 'dart:math';
// import 'package:flutter_bluetooth_serial_example/BackgroundCollectingTaskCopyCopy.dart';

Random rnd = new Random();

class BackgroundCollectedPage extends StatefulWidget {
  @override
  State<BackgroundCollectedPage> createState() =>
      _BackgroundCollectedPageState();
}

class _BackgroundCollectedPageState extends State<BackgroundCollectedPage> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late List<String> club;
  late List<bool> isFavorited;
  late List<TextEditingController> controllers;

  late List<double> lieAngle;
  late List<double> swingSpeed;
  late List<double> shaftLean;
  late List<String> date;
  late List<String> time;

  num? get argumentsShift => null;

  // late int numSwings;

  @override
  void initState() {
    controllers = [];
    for (int i = 0; i < 4; i++) {
      controllers.add(TextEditingController());
    }
    club = ["", "", "", ""];
    lieAngle = [10, 20, 30, 40];
    swingSpeed = [120, 100, 150, 160];
    shaftLean = [10, 10, 10, 10];
    date = ['11/02/2022', '12/02/2022', '13/02/2022', '14/02/2022'];
    time = ['11:02am', '10:50am', '7:25pm', '8:30pm'];
    isFavorited = [false, false, false, false];
    // numSwings = club.length;
    _scaffoldKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    // disposing states
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final BackgroundCollectingTask task =
    //     BackgroundCollectingTask.of(context, rebuildOnChange: true);

    // if (task.samples.isNotEmpty) {
    //   final int argumentsShift =
    //       task.samples.first.timestamp.millisecondsSinceEpoch;
    // } else {
    //   final int argumentsShift = 0;
    // }

    // // final int argumentsShift =
    // //       task.samples.first.timestamp.millisecondsSinceEpoch;

    // final Duration showDuration =
    //     Duration(seconds: 5); // @TODO . show duration should be configurable
    // final Iterable<DataSample> lastSamples = task.getLastOf(showDuration);

    // final Iterable<double> arguments = lastSamples.map((sample) {
    //   return (sample.timestamp.millisecondsSinceEpoch - argumentsShift!)
    //       .toDouble();
    // });

    // //Step for argument labels
    // final Duration argumentsStep =
    //     Duration(seconds: 5); // @TODO . step duration should be configurable

    // // Find first timestamp floored to step before
    // final DateTime beginningArguments = lastSamples.first.timestamp;
    // DateTime beginningArgumentsStep = DateTime(beginningArguments.year,
    //     beginningArguments.month, beginningArguments.day);
    // while (beginningArgumentsStep.isBefore(beginningArguments)) {
    //   beginningArgumentsStep = beginningArgumentsStep.add(argumentsStep);
    // }
    // beginningArgumentsStep = beginningArgumentsStep.subtract(argumentsStep);
    // final DateTime endingArguments = lastSamples.last.timestamp;

    // // Generate list of timestamps of labels
    // final Iterable<DateTime> argumentsLabelsTimestamps = () sync* {
    //   DateTime timestamp = beginningArgumentsStep;
    //   yield timestamp;
    //   while (timestamp.isBefore(endingArguments)) {
    //     timestamp = timestamp.add(argumentsStep);
    //     yield timestamp;
    //   }
    // }();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: NavDrawer(
          club: club,
          lieAngle: lieAngle,
          swingSpeed: swingSpeed,
          shaftLean: shaftLean,
          date: date,
          time: time,
          isFavorited: isFavorited,
          controllers: controllers,
          // numSwings: numSwings,
        ),
        appBar: AppBar(
          title: const Text('GolfGo'),
          // actions: <Widget>[
          //   // Progress circle
          //   (task.inProgress
          //       ? FittedBox(
          //           child: Container(
          //               margin: new EdgeInsets.all(16.0),
          //               child: CircularProgressIndicator(
          //                   valueColor:
          //                       AlwaysStoppedAnimation<Color>(Colors.white))))
          //       : Container(/* Dummy */)),
          //   // Start/stop buttons
          //   (task.inProgress
          //       ? IconButton(icon: Icon(Icons.pause), onPressed: task.pause)
          //       : IconButton(
          //           icon: Icon(Icons.play_arrow), onPressed: task.reasume)),
          // ],
        ),
        body: RefreshIndicator(
          child: ListView.builder(
            itemBuilder: (ctx, idx) {
              var reversedControllers = controllers.reversed.toList();
              var clubreversedList = club.reversed.toList();
              var lieAnglereversedList = lieAngle.reversed.toList();
              var swingSpeedreversedList = swingSpeed.reversed.toList();
              var shaftLeanreversedList = shaftLean.reversed.toList();
              var datereversedList = date.reversed.toList();
              var timereversedList = time.reversed.toList();
              var favoritedreversedList = isFavorited.reversed.toList();
              return Card(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Swing ${club.length - idx}')),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text("Golf Club: "),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 5, bottom: 3),
                                      width: 140,
                                      height: 40,
                                      child: TextField(
                                        controller: reversedControllers[idx],
                                        textAlign: TextAlign.justify,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 7),
                                          hintText: clubreversedList[idx] == ""
                                              ? "eg. Iron 7"
                                              : "",
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          border: OutlineInputBorder(),
                                        ),
                                        onSubmitted: (String value) {
                                          setState(() {
                                            clubreversedList[idx] = value;
                                          });
                                          SchedulerBinding.instance!
                                              .addPostFrameCallback((_) {
                                            club = clubreversedList.reversed
                                                .toList();
                                          });
                                          reversedControllers[idx].text =
                                              clubreversedList[idx];
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text('${datereversedList[idx]}')),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text('${timereversedList[idx]}')),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  IntrinsicHeight(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(child: Text('Lie Angle')),
                                    Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                            '${lieAnglereversedList[idx]}')),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(child: Text('Swing Speed')),
                                    Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                            '${swingSpeedreversedList[idx]}')),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(child: Text('Shaft Lean')),
                                    Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                            '${shaftLeanreversedList[idx]}')),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          favoritedreversedList[idx] =
                                              !favoritedreversedList[idx];
                                        });
                                        SchedulerBinding.instance!
                                            .addPostFrameCallback((_) {
                                          isFavorited = favoritedreversedList
                                              .reversed
                                              .toList();
                                        });
                                      },
                                      icon: Icon(
                                        favoritedreversedList[idx]
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      // icon: favoritedreversedList[idx]
                                      //     ? Icon(Icons.favorite)
                                      //     : Icon(Icons.favorite_border),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ));
            },
            itemCount: club.length,
            physics: const AlwaysScrollableScrollPhysics(),
          ),
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
              () {
                setState(() {
                  controllers.add(TextEditingController());
                  club.addAll([""]);
                  // numSwings += 1;
                  isFavorited.addAll([false]);

                  // lieAngle.addAll(lastSamples.map((sample) => sample.lieAngle));
                  // swingSpeed
                  //     .addAll(lastSamples.map((sample) => sample.swingSpeed));
                  // shaftLean
                  //     .addAll(lastSamples.map((sample) => sample.shaftLean));
                  // date.addAll(lastSamples.map((sample) => sample.date));
                  // time.addAll(lastSamples.map((sample) => sample.time));

                  // lieAngle.addAll([lastSamples.last.lieAngle]);
                  // swingSpeed
                  //     .addAll([lastSamples.last.swingSpeed]);
                  // shaftLean
                  //     .addAll([lastSamples.last.shaftLean]);
                  // date.addAll([lastSamples.last.date]);
                  // time.addAll([lastSamples.last.time]);

                  // List<double> lieAnglesToAdd = [53, 71, 62];
                  // List<double> shaftLeansToAdd = [2, -3, 15];
                  // List<double> swingSpeedsToAdd = [2, 5, 10];

                  // for (var i = 0; i >= 3; i++) {
                  //   lieAngle.addAll([lieAnglesToAdd[i]]);
                  //   shaftLean.addAll([shaftLeansToAdd[i]]);
                  //   swingSpeed.addAll([swingSpeedsToAdd[i]]);
                  //   String dateToAdd =
                  //     DateFormat.yMd().format(DateTime.now()).toString();
                  //   date.addAll([dateToAdd]);
                  //   String timeToAdd =
                  //     DateFormat.jm().format(DateTime.now()).toString();
                  //   time.addAll([timeToAdd]);
                  // }

                  //ADD THIS FOR DUMMY DATA:

                  int minLieAngle = 50, maxLieAngle = 70;
                  // int lieAngleToAdd =
                  //     minLieAngle + rnd.nextInt(maxLieAngle - minLieAngle);
                  // lieAngle.addAll([lieAngleToAdd.toDouble()]);
                  double lieAngleToAdd = rnd.nextDouble() +
                      minLieAngle +
                      rnd.nextInt(maxLieAngle - minLieAngle);

                  String lieAngleToAdd2 = lieAngleToAdd.toStringAsFixed(2);
                  double lieAngleToAdd3 = double.parse(lieAngleToAdd2);
                  lieAngle.addAll([lieAngleToAdd3.toDouble()]);

                  // double doubleInRange(Random source, num start, num end) =>
                  //   source.nextDouble() * (end - start) + start;
                  int minSwingSpeed = 3, maxSwingSpeed = 5;
                  double swingSpeedToAdd = rnd.nextDouble() +
                      minSwingSpeed +
                      rnd.nextInt(maxSwingSpeed - minSwingSpeed);
                  String swingSpeedToAdd2 = swingSpeedToAdd.toStringAsFixed(2);
                  double swingSpeedToAdd3 = double.parse(swingSpeedToAdd2);
                  swingSpeed.addAll([swingSpeedToAdd3.toDouble()]);

                  int minShaftLean = -5, maxShaftLean = 20;
                  double shaftLeanToAdd = rnd.nextDouble() +
                      minShaftLean +
                      rnd.nextInt(maxShaftLean - minShaftLean);
                  String shaftLeanToAdd2 = shaftLeanToAdd.toStringAsFixed(2);
                  double shaftLeanToAdd3 = double.parse(shaftLeanToAdd2);
                  shaftLean.addAll([shaftLeanToAdd3.toDouble()]);

                  String dateToAdd =
                      DateFormat.yMd().format(DateTime.now()).toString();
                  date.addAll([dateToAdd]);

                  String timeToAdd =
                      DateFormat.jm().format(DateTime.now()).toString();
                  time.addAll([timeToAdd]);

                  //IGNORE THIS:
                  // date.addAll(['15/02/2022']);
                  // time.addAll(['3:30pm']);
                  // date.addAll([lastSamples.last.date]);
                  // time.addAll([lastSamples.last.time]);
                });
                // showing snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Page Refreshed'),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
