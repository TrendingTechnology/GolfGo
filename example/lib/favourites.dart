import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// class FavouritesPage extends StatefulWidget {
//   @override
//   _FavouritesPageState createState() => _FavouritesPageState();
// }

class FavouritesPage extends StatelessWidget {
  // late GlobalKey<ScaffoldState> _scaffoldKey;
  // late List<String> _demoData;
  List<String> club;
  List<double> lieAngle;
  List<double> swingSpeed;
  List<double> shaftLean;
  List<String> date;
  List<String> time;
  List<bool> isFavorited;
  List<TextEditingController> controllers;

  FavouritesPage({required this.club, required this.lieAngle, required this.swingSpeed, required this.shaftLean, 
    required this.date, required this.time, required this.isFavorited, required this.controllers});

  // @override
  // void initState() {
  //   // _controllers = [];
  //   // for (int i = 0; i < 4; i++) {
  //   //   _controllers.add(TextEditingController());
  //   // }
  //   club = ["", "", "", ""];
  //   lieAngle = [10, 20, 30, 40];
  //   swingSpeed = [120, 100, 150, 160];
  //   shaftLean = [10, 10, 10, 10];
  //   date = ['11/02/2022', '12/02/2022', '13/02/2022', '14/02/2022'];
  //   time = ['11:02am', '10:50am', '7:25pm', '8:30pm'];
  //   _isFavorited = [false, false, false, false];
  // }

// This method will run when widget is unmounting
  // @override
  // void dispose() {
  //   // disposing states
  //   _scaffoldKey.currentState?.dispose();
  //   // clubEditingHandler.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('My Favourites'),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, idx) {
            // List Item
            // var clubEditingHandler = TextEditingController();
            var reversedControllers = controllers.reversed.toList();
            var clubreversedList = club.reversed.toList();
            var lieAnglereversedList = lieAngle.reversed.toList();
            var swingSpeedreversedList = swingSpeed.reversed.toList();
            var shaftLeanreversedList = shaftLean.reversed.toList();
            var datereversedList = date.reversed.toList();
            var timereversedList = time.reversed.toList();
            var favoritedreversedList = isFavorited.reversed.toList();
            return favoritedreversedList[idx] == true ? Card(
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
                              // decoration: BoxDecoration(
                              //   border: Border.all(color: Colors.blueAccent)
                              // ),
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
                                    },
                                    icon: Icon(
                                      favoritedreversedList[idx] ? Icons.favorite : Icons.favorite_border,
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
            )
            ) : SizedBox.shrink();
          },
          // Length of the list
          itemCount: club.length,
          // To make listView scrollable
          // even if there is only a single item.
          physics: const AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }
}

