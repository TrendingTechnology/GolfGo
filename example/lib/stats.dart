import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// class StatsPage extends StatefulWidget {
//   @override
//   _StatsPageState createState() => _StatsPageState();
// }

class StatsPage extends StatelessWidget {
  // late GlobalKey<ScaffoldState> _scaffoldKey;
  List<double> lieAngle;
  List<double> swingSpeed;
  List<double> shaftLean;
  StatsPage(
      {required this.lieAngle,
      required this.swingSpeed,
      required this.shaftLean});

  List<String> averageStatsTitle = [
    'Average Lie Angle',
    'Average Swing Speed',
    'Average Shaft Lean'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('My Stats'),
        ),
        body: ListView.builder(
          itemCount: averageStatsTitle.length,
          itemBuilder: (context, idx) {
            double totalLieAngle = 0;
            for (var e in lieAngle) {
              totalLieAngle += e;
            }
            var averageLieAngle = totalLieAngle / lieAngle.length;

            double totalSwingSpeed = 0;
            for (var e in swingSpeed) {
              totalSwingSpeed += e;
            }
            var averageSwingSpeed = totalSwingSpeed / swingSpeed.length;

            double totalShaftLean = 0;
            for (var e in shaftLean) {
              totalShaftLean += e;
            }
            var averageShaftLean = totalShaftLean / shaftLean.length;

            List<double> averageStats = [
              averageLieAngle,
              averageSwingSpeed,
              averageShaftLean
            ];

            return Card(
                child: Column(
              children: [
                Container(
                    height: 110,
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: '${averageStatsTitle[idx]}:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black),
                        ),
                      ),
                    )),
                Container(
                    height: 110,
                    padding: EdgeInsets.all(10),
                    child: RichText(
                      text: TextSpan(
                        text: '${double.parse(averageStats[idx].toStringAsFixed(2))}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: Colors.black),
                      ),
                    )),
              ],
            ));
          },
        ),
      ),
    );
  }
}
