import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bluetooth_serial_example/user.dart';
import 'package:flutter_bluetooth_serial_example/user_preferences.dart';
import 'package:flutter_bluetooth_serial_example/widget/appbar_widget.dart';
import 'package:flutter_bluetooth_serial_example/widget/button_widget.dart';
import 'package:flutter_bluetooth_serial_example/widget/profile_widget.dart';
import 'package:flutter_bluetooth_serial_example/widget/textfield_widget.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();

    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context, 'Edit Profile'),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {
                    final image =
                        await ImagePicker().getImage(source: ImageSource.gallery);

                    if (image == null) return;

                    final directory = await getApplicationDocumentsDirectory();
                    final name = basename(image.path);
                    final imageFile = File('${directory.path}/$name');
                    final newImage = await File(image.path).copy(imageFile.path);

                    setState(() => user = user.copy(imagePath: newImage.path));
                  },
                ),
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Name',
                text: user.name,
                onChanged: (name) => user = user.copy(name: name),
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Email',
                text: user.email,
                onChanged: (email) => user = user.copy(email: email),
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Club Membership',
                text: user.clubMembership,
                maxLines: 5,
                onChanged: (clubMembership) => user = user.copy(clubMembership: clubMembership),
              ),
              const SizedBox(height: 24),
              ButtonWidget(
                text: 'Save',
                onClicked: () {
                  UserPreferences.setUser(user);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
}
