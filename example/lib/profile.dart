// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   final String name = 'Timothy';

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       backgroundColor: Colors.green,
//       title: Text(name),
//       centerTitle: true,
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/user.dart';
import 'package:flutter_bluetooth_serial_example/edit_profile_page.dart';
import 'package:flutter_bluetooth_serial_example/user_preferences.dart';
import 'package:flutter_bluetooth_serial_example/widget/appbar_widget.dart';
import 'package:flutter_bluetooth_serial_example/widget/button_widget.dart';
import 'package:flutter_bluetooth_serial_example/widget/numbers_widget.dart';
import 'package:flutter_bluetooth_serial_example/widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  List<String> club;
  ProfilePage({required this.club});
  @override
  _ProfilePageState createState() => _ProfilePageState(club);
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> club;
  _ProfilePageState(this.club);
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return Builder(
      builder: (context) => Scaffold(
        appBar: buildAppBar(context, 'User Profile'),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: ProfileWidget(
                imagePath: user.imagePath,
                onClicked: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 24),
            buildName(user),
            const SizedBox(height: 24),
            NumbersWidget(club: club, clubMembership: user.clubMembership),
          ],
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  // Widget buildAbout(User user) => Container(
  //       padding: EdgeInsets.symmetric(horizontal: 48),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'About',
  //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 16),
  //           Text(
  //             user.about,
  //             style: TextStyle(fontSize: 16, height: 1.4),
  //           ),
  //         ],
  //       ),
  //     );
}
