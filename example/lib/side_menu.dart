import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/favourites.dart';
import 'package:flutter_bluetooth_serial_example/profile.dart';
import 'package:flutter_bluetooth_serial_example/stats.dart';
import 'bluetooth_connection.dart';

class NavDrawer extends StatelessWidget {
  List<String> club;
  List<double> lieAngle;
  List<double> swingSpeed;
  List<double> shaftLean;
  List<String> date;
  List<String> time;
  List<bool> isFavorited;
  List<TextEditingController> controllers;
  // int numSwings;
  NavDrawer(
      {required this.club,
      required this.lieAngle,
      required this.swingSpeed,
      required this.shaftLean,
      required this.date,
      required this.time,
      required this.isFavorited,
      // required this.numSwings,
      required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
              decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                  image: AssetImage("assets/golfCourse.jpeg"),
                     fit: BoxFit.cover)
              ),
            // child: Container(
            //   width: 300,
            //   height: 113,
            //   decoration: BoxDecoration(
            //   image: DecorationImage(
            //       fit: BoxFit.fill,
            //       image: AssetImage('assets/golfCourse.jpeg'))
            //   ),
            // )
            // child: Text(
            //   'Side menu',
            //   style: TextStyle(fontSize: 25),
            // ),
            // decoration: BoxDecoration(
            //   // color: Colors.green,
            //   image: DecorationImage(
            //       fit: BoxFit.fill,
            //       image: AssetImage('assets/golfCourse.jpg'))
            // ),
          ),
          // ListTile(
          //   leading: Icon(Icons.bluetooth),
          //   title: Text('Bluetooth Connection'),
          //   onTap: () => {
          //     Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => BluetoothConnectionPage(),
          //     ))
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfilePage(club: club,),
              ))
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favourites'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FavouritesPage(
                  club: club,
                  lieAngle: lieAngle,
                  swingSpeed: swingSpeed,
                  shaftLean: shaftLean,
                  date: date,
                  time: time,
                  isFavorited: isFavorited,
                  controllers: controllers,
                ),
              ))
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('My Stats'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StatsPage(
                  lieAngle: lieAngle,
                  swingSpeed: swingSpeed,
                  shaftLean: shaftLean,
                ),
              ))
            },
          ),
        ],
      ),
    );
  }
}
